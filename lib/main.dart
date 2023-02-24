
import 'package:code_app/modules/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'layout/bloc_observer.dart';

void main(){
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterScreen()
    );
  }
}
