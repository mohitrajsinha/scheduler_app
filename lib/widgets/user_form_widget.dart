import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/user.dart';

class UserFormWidget extends StatefulWidget {
  final ValueChanged<User> onSavedUser;
  const UserFormWidget({super.key, required this.onSavedUser});

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  late TextEditingController controllerName;
  late TextEditingController controllerEmail;
  late TextEditingController controllerDescription;
  late TextEditingController controllerStartDateTime;
  late TextEditingController controllerEndDateTime;
  late TextEditingController controllerGuestEmail;
  late TextEditingController controllerLocation;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  void initUser() {
    controllerName = TextEditingController();
    controllerEmail = TextEditingController();
    controllerDescription = TextEditingController();
    controllerStartDateTime = TextEditingController();
    controllerEndDateTime = TextEditingController();
    controllerGuestEmail = TextEditingController();
    controllerLocation = TextEditingController();
  }

  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          buildName(),
          const SizedBox(height: 30),
          buildEmail(),
          const SizedBox(height: 30),
          builddescription(),
          const SizedBox(height: 30),
          buildStartDateTime(),
          const SizedBox(height: 30),
          buildEndDateTime(),
          const SizedBox(height: 30),
          buildGuestEmail(),
          const SizedBox(height: 30),
          buildLocation(),
          const SizedBox(height: 30),
          buildSubmit(),
        ],
      );
  Widget buildName() => TextFormField(
        controller: controllerName,
        decoration: InputDecoration(
          labelText: "Name",
          border: OutlineInputBorder(),
        ),
      );

  Widget buildEmail() => TextFormField(
        controller: controllerEmail,
        decoration: InputDecoration(
          labelText: "Email",
          border: OutlineInputBorder(),
        ),
      );
  Widget builddescription() => TextFormField(
        controller: controllerDescription,
        decoration: InputDecoration(
          labelText: "Description",
          border: OutlineInputBorder(),
        ),
      );
  Widget buildStartDateTime() => TextFormField(
        controller: controllerStartDateTime,
        decoration: InputDecoration(
          labelText: "StartDateTime(YYYY-MM-DD HH:MM)",
          border: OutlineInputBorder(),
        ),
      );
  Widget buildEndDateTime() => TextFormField(
        controller: controllerEndDateTime,
        decoration: InputDecoration(
          labelText: "EndDateTime(YYYY-MM-DD HH:MM)",
          border: OutlineInputBorder(),
        ),
      );
  Widget buildGuestEmail() => TextFormField(
        controller: controllerGuestEmail,
        decoration: InputDecoration(
          labelText: "Guest Email",
          border: OutlineInputBorder(),
        ),
      );
  Widget buildLocation() => TextFormField(
        controller: controllerLocation,
        decoration: InputDecoration(
          labelText: "Location",
          border: OutlineInputBorder(),
        ),
      );
  Widget buildSubmit() => ElevatedButton(
        child: "Save".text.xl3.make(),
        onPressed: () {
          final user = User(
            name: controllerName.text,
            email: controllerEmail.text,
            Description: controllerDescription.text,
            StartDateTime: controllerEndDateTime.text,
            EndDateTime: controllerEndDateTime.text,
            GuestEmail: controllerGuestEmail.text,
            Location: controllerLocation.text,
          );
          widget.onSavedUser(user);
        },
      );
}
