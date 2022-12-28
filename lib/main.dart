import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:p_m_m/Screens/addTransaction/screeen_add_transaction.dart';
import 'package:p_m_m/db/category/category_db.dart';
import 'package:p_m_m/home/Screeen_home.dart';
import 'package:p_m_m/models/category/category_model.dart';

Future<void> main() async{
  final obj1 = CategoryDB();
  final obj2 = CategoryDB();
  print('Object Comparing');
  print(obj1 == obj2);
  WidgetsFlutterBinding.ensureInitialized(); //Checking the packages and all whether its there or not
  await Hive.initFlutter();

  //Adapters Registration (CategoryType)
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  // (Categorymodel)
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  
  runApp(const MyApp());
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

        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
        backgroundColor: Colors.grey[100],
      ),
      
      home: const ScreenHome(),
      routes: {
         ScreenAddTransaction.routeName: (ctx) => const ScreenAddTransaction(),
      }

      
      
    );
  }
}

