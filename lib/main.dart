import 'package:code_app/modules/Screens/auth_screens/auth_cubit/auth_cubit.dart';
import 'package:code_app/modules/Screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'shared/bloc_observer/bloc_observer.dart';

void main()
{
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers:
        [
          BlocProvider(create: (context) => AuthCubit()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: LoginScreen()
        ),
    );
  }
}
