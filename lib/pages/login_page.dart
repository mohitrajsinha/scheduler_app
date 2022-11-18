import 'package:android_app/pages/home_page.dart';
import 'package:android_app/pages/signup_page.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:developer';
import 'package:form_validator/form_validator.dart';

import '../utils/routes.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool ChangeButton = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  

  movetohome(BuildContext context) async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        ChangeButton = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(() {
        ChangeButton = false;
      });
    }
  }
  
  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email == "" || password == "") {
      log("Please fill all the fields");
      AnimatedSnackBar.material(
    'Please fill all the fields',
    type: AnimatedSnackBarType.info,
    // mobileSnackBarPosition: MobileSnackBarPosition.top, // Position of snackbar on mobile devices
    desktopSnackBarPosition: DesktopSnackBarPosition.topCenter, // Position of snackbar on desktop devices
).show(context);
    }
      else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        if (userCredential != null) {
          movetohome(context);
        }
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.canvasColor,
      child: SingleChildScrollView(
          child: Form(
        key: _formkey,
        child: Column(children: [
          Image.asset(
            "lib/assets/images/login.jpg",
            // fit: BoxFit.contain,
          ).w32(context).p32(),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            "Welcome $name",
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 600.0),
            child: Column(children: [
              TextFormField(
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
                  hintText: "Enter email",
                  labelText: "Email",
                ),
                // validator: (value) {
                //   if (value == null || value.isEmpty || !value.contains('@')) {
                //     return "Email cannot be empty";
                //   }
                //   return null;
                // },
                validator: ValidationBuilder().email().maxLength(50).build(),
                controller: emailController,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: "Enter Password", labelText: "Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password cannot be empty";
                  } else if (value.length < 6) {
                    return "Password length must be 6";
                  }
                  return null;
                },
                controller: passwordController,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Material(
                borderRadius: BorderRadius.circular(ChangeButton ? 50 : 8),
                color: context.theme.buttonColor,
                child: InkWell(
                  onTap: () {
                    
                    login();
                    if (_formkey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: ChangeButton ? 50 : 150,
                    height: 50,
                    alignment: Alignment.center,
                    child: ChangeButton
                        ? const Icon(Icons.done, color: Colors.white)
                        : const Text("Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(
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
                child: const Text("Sign Up").text.headline6(context).make(),
              ),
            ]),
          )

          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.pushNamed(context, MyRoutes.homeroute);
          //   },
          //   child: Text(
          //     "Login",
          //   ),
          //   style: TextButton.styleFrom(minimumSize: Size(150, 50)),
          // )
        ]),
      )),
    );
    ;
  }
}
