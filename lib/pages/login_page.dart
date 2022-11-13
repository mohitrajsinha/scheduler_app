import 'package:flutter/material.dart';
import 'package:scheduler_app/pages/home_page.dart';
import 'package:scheduler_app/pages/signup_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/routes.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool ChangeButton = false;
  final _formkey = GlobalKey<FormState>();

  movetohome(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        ChangeButton = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(() {
        ChangeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: context.canvasColor,
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                Image.asset(
                  "lib/assets/images/login.jpg",
                  // fit: BoxFit.contain,
                ).w32(context).p32(),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  "Welcome $name",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 500.0),
                  child: Column(children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Enter UserName",
                        labelText: "UserName",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "UserName cannot be empty";
                        }
                        return null;
                      },
                      onChanged: ((value) {
                        name = value;
                        setState(() {});
                      }),
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Enter Password", labelText: "Password"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password cannot be empty";
                        } else if (value.length < 6) {
                          return "Password length must be 6";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Material(
                      borderRadius:
                          BorderRadius.circular(ChangeButton ? 50 : 8),
                      color: context.theme.buttonColor,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, MyRoutes.homeRoute);
                        },
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          width: ChangeButton ? 50 : 150,
                          height: 50,
                          alignment: Alignment.center,
                          child: ChangeButton
                              ? Icon(Icons.done, color: Colors.white)
                              : Text("Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                        ),  
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextButton(
                      onPressed: () {
                        context.push((context) => SignUpPage());
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all(
                          context.accentColor,
                        ),
                      ),
                      child: Text("Sign Up").text.headline6(context).make(),
                    ),
                  ]),
                )
              ],
            ),
          ),
        ));
  }
}
