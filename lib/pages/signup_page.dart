import 'dart:html';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/routes.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  String name = "";
  bool ChangeButton = false;
  final _formkey = GlobalKey<FormState>();

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


  void createAccount() async {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String cPassword = cPasswordController.text.trim();
    if (email == "" ||
        name == "" ||
        phone == "" ||
        password == "" ||
        cPassword == "") {
      log("Please fill all the details");
      AnimatedSnackBar.material(
        'Please fill all the fields',
        type: AnimatedSnackBarType.info,
        // mobileSnackBarPosition: MobileSnackBarPosition.top, // Position of snackbar on mobile devices
        desktopSnackBarPosition: DesktopSnackBarPosition
            .topCenter, // Position of snackbar on desktop devices
      ).show(context);
    } else if (password != cPassword) {
      log("Passwords do not match");
      AnimatedSnackBar.material(
        'Password does not match',
        type: AnimatedSnackBarType.info,
        desktopSnackBarPosition: DesktopSnackBarPosition
            .topCenter, // Position of snackbar on desktop devices
      ).show(context);
    } else {
      try {
        //create new acc
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          Navigator.pushNamed(context, MyRoutes.loginRoute);
        }
        log("User created successfully");
      } on FirebaseAuthException catch (ex) {
        log(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.canvasColor,
      body: SafeArea(
        child: Container(
          padding: Vx.m32,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            "Sign Up".text.xl5.bold.color(context.theme.accentColor).make(),
            "Create your account".text.xl2.make(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 600.0),
            ),
            TextFormField(
              controller: nameController,
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
            
            // TextFormField(
            //   controller: phoneController,
            //   decoration: const InputDecoration(
            //     hintText: "Phone number",
            //     labelText: "Contact",
            //   ),
            //   validator: (value) {
            //     var phoneNumber = value;
            //     var regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
            //     var regExp = new RegExp(regexPattern);

            //     if (value?.length == 0) {
            //       return "Invalid Phone number";
            //     } else if (regExp.hasMatch(value!)) {
            //       return "Invalid Phone number";
            //     }
            //     return "Invalid Phone number";
            //   },
            //   onChanged: ((value) {
            //     name = value;
            //     setState(() {});
            //   }),
            // ),
            
            
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "Enter Email",
                labelText: "Email",
              ),
              validator: ValidationBuilder().email().maxLength(50).build(),
              onChanged: ((value) {
                name = value;
                setState(() {});
              }),
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: "Enter Password",
                labelText: "Password",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password cannot be empty";
                } else if (value.length < 6) {
                  return "Password length must be 6";
                }
                return null;
              },
              onChanged: ((value) {
                name = value;
                setState(() {});
              }),
            ),
            TextFormField(
              controller: cPasswordController,
              decoration: const InputDecoration(
                hintText: "Confirm Password",
                labelText: "Confirm password",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password cannot be empty";
                } else if (value.length < 6) {
                  return "Password length must be 6";
                }
                return null;
              },
              onChanged: ((value) {
                name = value;
                setState(() {});
              }),
            ),
            // CupertinoFormSection(
            //     header: "Terms & Conditions".text.make(),
            //     children: [
            //       CupertinoFormRow(
            //         prefix: "I Agree".text.make(),
            //         child: CupertinoSwitch(
            //           value: true,
            //           onChanged: (value) {},
            //         ),
            //       ),
            //     ]),
            Material(
              borderRadius: BorderRadius.circular(ChangeButton ? 50 : 8),
              color: context.theme.buttonColor,
              child: InkWell(
                onTap: (() {
                  createAccount();
                  if (_formkey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                }),
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  width: ChangeButton ? 50 : 150,
                  height: 50,
                  alignment: Alignment.center,
                  child: ChangeButton
                      ? const Icon(Icons.done, color: Colors.white)
                      : const Text("SignUp",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                ),
              ),
            ).centered(),
          ]),
        ),
      ),
    );
  }
}
