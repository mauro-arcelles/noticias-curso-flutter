import 'package:flutter/material.dart';
import 'package:newsapp/screens/tabs_screen.dart';
import 'package:newsapp/services/news_service.dart';
import 'package:provider/provider.dart';

import 'theme/tema.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService(), lazy: false),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: miTema,
        title: 'Material App',
        home: const TabsScreen(),
      ),
    );
  }
}
