/*
import 'package:code_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("images/auth_background.png"),fit: BoxFit.fill)
        ),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children:
            [
              Expanded(
                flex: 1,
                child: Container(
                  // color: Colors.red,
                  width: double.infinity,
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(bottom: 40),
                  child: const Text("Login to complete process",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 45),
                  decoration: BoxDecoration(
                    color: thirdColor,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [
                      Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.5),),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:
                        [
                          Icon(Icons.email),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Email",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

 */