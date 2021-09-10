import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/loading_provider.dart';
import 'ui/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoadingProvider>(
            create: (_) => LoadingProvider())
      ],
      builder: (ctx, widget) => widget!,
      child: MaterialApp(
        title: 'Text Recognition',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Home(),
      ),
    );
  }
}
