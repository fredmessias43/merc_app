import 'package:flutter/material.dart';
import 'package:merc_app/models/item.dart';
import 'package:provider/provider.dart';

import 'pages/list_group_page.dart';
import 'pages/list_page.dart';

void main() {
  runApp(const MercApp());
}

class MercApp extends StatelessWidget {
  const MercApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const ListGroupPage()
        //initialRoute: '/',
        //routes: {
        //  "/": (context) => const ListGroupPage(),
        //  "/items": (context) => const ListPage()
        //}
        );
  }
}
