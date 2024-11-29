import 'package:flutter/material.dart';
import 'package:flutter_github_api/controller/repo_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consumo de API - GitHub',
      theme: ThemeData(
        primarySwatch: Colors.blue, 
        colorScheme: const ColorScheme(
          brightness: Brightness.dark, 
          primary: Colors.white, 
          onPrimary: Colors.white, 
          secondary: Colors.black, 
          onSecondary: Colors.lightBlueAccent, 
          error: Colors.red, 
          onError: Colors.redAccent, 
          surface: Color.fromARGB(255, 5, 5, 5), 
          onSurface: Color.fromARGB(255, 234, 236, 237)
          ),
      ),
      home: RepoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RepoPage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  RepoPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    final repoProvider = Provider.of<RepoProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Repositórios GitHub')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              onFieldSubmitted: (_) => repoProvider.fetchRepos(_controller.text.trim()),
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'GitHub User Name',
                suffixIcon: IconButton(
                  icon:const Icon(Icons.search),
                  onPressed: () {
                    repoProvider.fetchRepos(_controller.text.trim());
                  },
                ),
              ),
              validator: (String? value) {
                if(value!.contains(" ")){
                  return "Insira o nome sem espaço";
                }else{
                  return null;
                }
              },
            ),
          ),
          if (repoProvider.isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Expanded(
              child: ListView.builder(
                itemCount: repoProvider.repos.length,
                itemBuilder: (context, index) {
                  final repo = repoProvider.repos[index];
                  return ListTile(
                    title: Text(repo['name']),
                    subtitle: Text(repo['description'] ?? 'Sem descrição'),
                    trailing: const Icon(Icons.code),
                    onTap: () => print(repo['html_url']),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
