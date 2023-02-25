import 'package:code_app/modules/Screens/auth_screens/auth_cubit/auth_cubit.dart';
import 'package:code_app/modules/Screens/home_screen/home_screen.dart';
import 'package:code_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_cubit/auth_states.dart';
class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("images/auth_background.png"),fit: BoxFit.fill)
        ),
        child: BlocConsumer<AuthCubit,AuthStates>(
          listener: (context,state)
          {
            if( state is LoginSuccessState )
              {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
              }
            if( state is FailedToLoginState )
              {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: Text(state.message),
                )));
              }
          },
          builder: (context,state){
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: 50),
                    child: const Text("Login to continue process",style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.bold),),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    decoration: BoxDecoration(
                        color: thirdColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35))
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              hintText: "Email",
                            ),
                            validator: (input){
                              if( emailController.text.isNotEmpty )
                              {
                                return null;
                              }
                              else
                              {
                                return "Email must not be empty";
                              }
                            },
                          ),
                          SizedBox(height: 15,),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Password",
                            ),
                            validator: (input){
                              if( passwordController.text.isNotEmpty )
                              {
                                return null;
                              }
                              else
                              {
                                return "Password must not be empty";
                              }
                            },
                          ),
                          SizedBox(height: 25,),
                          MaterialButton(
                            onPressed: ()
                            {
                              // Login
                              if( formKey.currentState!.validate() == true )
                                {
                                  BlocProvider.of<AuthCubit>(context).login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                  );
                                }
                            },
                            minWidth: double.infinity,
                            color: mainColor,
                            textColor: Colors.white,
                            child: Text(state is LoginLoadingState ? "Loading..." : "Login"),
                          ),
                          SizedBox(height: 15,),
                          RichText(
                              text: TextSpan(
                                children:
                                [
                                  TextSpan(text: 'forget your password? ',style: TextStyle(color: Colors.black)),
                                  TextSpan(text: 'Click here',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold)),
                                ]
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        )
      ),
    );
  }
}
