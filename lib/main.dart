import 'package:band_names/pages/status.dart';
import 'package:band_names/services/socket_service.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
//pages
import 'package:band_names/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SocketService())],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (context) => HomePage(),
          'status': (context) => StatusPage()
        },
      ),
    );
  }
}
