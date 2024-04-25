import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata_book/view/addkhata.dart';
import 'package:khata_book/view/home_page.dart';
import 'package:khata_book/view/viewall.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Khatabook Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(),
      // home:  MyHomePage(title: 'Flutter Demo Home Page'),

      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/add',
          page: () => AddEntry(),
        ),
        GetPage(
          name: '/viewAllTab',
          page: () => ViewAllTab(),
        ),
      ],
    );
  }
}
