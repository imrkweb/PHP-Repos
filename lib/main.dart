import 'package:final_app1/models/repo_model.dart';
import 'package:final_app1/services/db_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<RepoModel>> _reposFuture;

  @override
  void initState() {
    super.initState();
    fetchAndSaveRepo();
    _reposFuture = DbService.db.getRepo(); //fetch repos from DB
  }

  Future<void> fetchAndSaveRepo() async {
    try {
      await DbService.db.fetchAndSaveRepo();
      setState(() {
        _reposFuture = DbService.db.getRepo(); // Refresh the Future
      });
    } catch (e) {
      print('Error during fetching and saving repos: $e'); // Log the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        centerTitle: true,
        title: const Text(
          'PHP Repos',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await fetchAndSaveRepo();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder<List<RepoModel>>(
          future: _reposFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No Repos Data found'));
            } else {
              final repos = snapshot.data!;
              return ListView.builder(
                itemCount: repos.length,
                itemBuilder: (context, index) {
                  final repo = repos[index];
                  return Card(
                    child: ListTile(
                      title: Center(
                        child: Text(
                          repo.name,
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          Text('Stars: ${repo.stargazersCount}'),
                          Text('Pushed At: ${repo.pushedAt}'),
                          Text('URL: ${repo.url}'),
                        ],
                      ),
                      onTap: () {
                        _showDialog(
                          context,
                          repo.createdAt,
                          repo.description,
                        );
                      },
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}

void _showDialog(BuildContext context, String createdAt, String description) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Created At: $createdAt',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                'Description: $description',
              ),
            ],
          ),
        ),
      );
    },
  );
}
