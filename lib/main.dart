import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visiting_card/pages/contact_details_page.dart';
import 'package:visiting_card/pages/form_page.dart';
import 'package:visiting_card/pages/home_page.dart';
import 'package:visiting_card/pages/scan_page.dart';
import 'package:visiting_card/providers/contact_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context)=> ContactProvider(),
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
      ),
      initialRoute: HomePage.routename,
      routes: {
        HomePage.routename: (context)=> const HomePage(),
        ScanPage.routename: (context)=> const ScanPage(),
        FormPage.routename: (context)=> const FormPage(),
        ContactDetailsPage.routename: (context)=> const ContactDetailsPage(),
      },
    );
  }
}

