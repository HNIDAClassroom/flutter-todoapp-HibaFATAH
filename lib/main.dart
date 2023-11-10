import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app/auth_verify.dart';
import 'package:todolist_app/firebase_options.dart';
import 'application.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

options: DefaultFirebaseOptions.currentPlatform,

);
  runApp(
    ChangeNotifierProvider<UserTheme>(
      create: (context) => UserTheme(), // Créez ici une instance de UserTheme
      child:
          MyApp(), // Replacez MyApp par le widget racine de votre application
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey),
        scaffoldBackgroundColor: Color.fromARGB(255, 249, 249, 250),
        appBarTheme: const AppBarTheme(elevation: 0),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: AuthVerify(),
    );
  }
}

class UserTheme extends ChangeNotifier {
  int count;
  Color backgroundColor;

  UserTheme({this.count = 5, this.backgroundColor = Colors.black});

  void incrementCount() {
    count++;
    notifyListeners();
  }

  void changeBackgroundColor(Color bgColor) {
    backgroundColor = bgColor;
    notifyListeners();
  }
}


