import 'dart:convert';

import 'package:final_app1/models/repo_model.dart';
import 'package:http/http.dart' as http;

Future<List<RepoModel>> fetchRepo() async {
  final response = await http.get(Uri.parse(
      'https://api.github.com/search/repositories?q=language:php&sort=stars&order=desc'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> jsonResponse = json.decode(response.body);
    //print('JSON Response: ${jsonResponse.toString()}');
    List<dynamic> items = jsonResponse['items'];
    return items.map((repo) => RepoModel.fromJson(repo)).toList();
  } else {
    throw Exception('Failed to fetch repos');
  }
}
