import 'package:flutter/material.dart';
import 'package:flutter_github_api/service/http_service.dart';

class RepoProvider with ChangeNotifier {
  final GitHubService  _service = GitHubService();
  List<dynamic> _repos = [];
  bool _isLoading = false;

  List<dynamic> get repos => _repos;
  bool get isLoading => _isLoading;

  Future<void> fetchRepos(String username) async {
    _isLoading = true;
    notifyListeners();

    try {
      _repos = await _service.fetchUserRepos(username);
    } catch (e) {
      print("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
