import 'package:flutter/material.dart';
import 'package:flutter_github_api/controller/repo_provider.dart';
import 'package:flutter_github_api/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RepoProvider()),
      ],
      child: MyApp(),
    ),
  );
}


