import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_tuto_blc/firebase_options.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tuto_blc/bloc_page/bloc_event.dart';
import 'package:flutter_tuto_blc/bloc_page/bloc_page.dart';
import 'package:flutter_tuto_blc/bloc_page/bloc_state.dart';
import 'package:flutter_tuto_blc/home.dart';
import 'package:flutter_tuto_blc/login_screen.dart';
import 'package:flutter_tuto_blc/register_screen.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(MyApp());
  } catch (error) {
    print("Firebase initialization error: $error");
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocPage>(
      create: (context) => BlocPage()..add(LoginEvent()),
      child: MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BlocPage, BlocState>(
      builder: (BuildContext context, state) {
        if (state is LoginState) {
          return LoginScreen();
        } else if (state is RegisterState) {
          return RegisterScreen();
        } else if (state is HomeState) {
          return HomePage();
        } else {
          return HomePage();
        }
      },
    ),
    );
  }
}
