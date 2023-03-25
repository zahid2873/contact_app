//import 'dart:js';

import 'package:contactapp/pages/contact_details-page.dart';
import 'package:contactapp/pages/contact_form_page.dart';
import 'package:contactapp/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_pages.dart';

void main() {
  runApp( ChangeNotifierProvider(
    create: (context)=>ContactProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName : (context)=>HomePage(),
        ContactFormPage.routeName :(context)=>ContactFormPage(),
        ContactDetailsPage.routeName : (context) =>ContactDetailsPage(),
      },
    );
  }
}

