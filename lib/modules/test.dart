/*
import 'package:code_app/modules/auth_cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_cubit/states.dart';
import 'home_screen.dart';
class RegisterScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthCubit(),
        child: BlocConsumer<AuthCubit,AuthStates>(
          listener: (context,state){
            if( state is RegisterSuccessState )
              {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
              }
            else if ( state is FailedToRegisterState )
              {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: double.infinity,
                      child: Text(state.message),
                    )))
                ;
              }
          },
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children:
                      [
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                              hintText: "Name",
                              border: OutlineInputBorder()
                          ),
                          validator: (input){
                            if( nameController.text.isNotEmpty )
                              {
                                return null;
                              }
                            else
                              {
                                return "Name must not be empty!";
                              }
                          },
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: "Email",
                              border: OutlineInputBorder()
                          ),
                          validator: (input){
                            if( emailController.text.isNotEmpty )
                              {
                                return null;
                              }
                            else
                              {
                                return "Email must not be empty!";
                              }
                          },
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                              hintText: "Phone",
                              border: OutlineInputBorder()
                          ),
                          validator: (input){
                            if( phoneController.text.isNotEmpty )
                              {
                                return null;
                              }
                            else
                              {
                                return "Phone must not be empty!";
                              }
                          },
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Password",
                              border: OutlineInputBorder()
                          ),
                          validator: (input){
                            if( passwordController.text.isNotEmpty )
                              {
                                return null;
                              }
                            else
                              {
                                return "Password must not be empty!";
                              }
                          },
                        ),
                        SizedBox(height: 15,),
                        MaterialButton(
                          onPressed: ()
                          {
                            if( formKey.currentState!.validate() == true )
                              {
                                BlocProvider.of<AuthCubit>(context).register(
                                    email: emailController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text
                                );
                              }
                          },
                          color: Colors.greenAccent,
                          child: const Text("Register"),
                        )
                      ],
                    ),
                  ),
                )
              ),
            );
          },
        )
    );
  }
}

 */