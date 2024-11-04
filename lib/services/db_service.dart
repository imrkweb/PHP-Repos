import 'dart:io';

import 'package:final_app1/models/repo_model.dart';
import 'package:final_app1/services/api_service.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  static Database? _database;
  static final DbService db = DbService._();

  DbService._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'php_repo.db');

    return await openDatabase(
      path,
      version: 2, // Increment the version to trigger onUpgrade
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('CREATE TABLE Repo('
            'id INTEGER PRIMARY KEY,'
            'name TEXT,'
            'url TEXT,'
            'created_at TEXT,'
            'pushed_at TEXT,'
            'description TEXT,'
            'stargazers_count INTEGER'
            ')');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          await db.execute('DROP TABLE IF EXISTS Repo');
          await db.execute('CREATE TABLE Repo('
              'id INTEGER PRIMARY KEY,'
              'name TEXT,'
              'url TEXT,'
              'created_at TEXT,'
              'pushed_at TEXT,'
              'description TEXT,'
              'stargazers_count INTEGER'
              ')');
        }
      },
    );
  }

  //For fetch and save repos into DB
  Future<void> fetchAndSaveRepo() async {
    try {
      List<RepoModel> repos = await fetchRepo();
      //print('Fetched ${repos.length} repositories');
      await deleteRepo(); //Clear exisitng repos if need

      //insert each repo into DB
      for (RepoModel repo in repos) {
        await createRepo(repo);
      }
    } catch (e) {
      throw Exception('Failed to fetch repos: $e');
    }
  }

  //inserting data to table
  createRepo(RepoModel newRepo) async {
    //await deleteRepo();
    final db = await database;
    final res = await db.insert('Repo', newRepo.toJson());
    return res;
  }

  //Delete Repo
  Future<int> deleteRepo() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Repo');

    return res;
  }

  //feteching repo
  Future<List<RepoModel>> getRepo() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM REPO");

    List<RepoModel> list =
        res.isNotEmpty ? res.map((c) => RepoModel.fromJson(c)).toList() : [];

    return list;
  }
}
