import 'dart:convert';
import 'package:http/http.dart' as http;

class GitHubService {
  final String baseUrl = "https://api.github.com";

  Future<List<dynamic>> fetchUserRepos(String username) async {
    final url = Uri.parse('$baseUrl/users/$username/repos');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } 
    else if(response.statusCode == 404){
      throw Exception('Página não encontrada');
    }
    else {
      throw Exception('Failed to fetch repositories');
    }
  }
}
