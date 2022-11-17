import 'dart:html';
import 'package:android_app/models/user.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../api/sheets/user_sheets_api.dart';
import '../widgets/user_form_widget.dart';


import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.canvasColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.theme.buttonColor,
        onPressed: () {},
        child: const Icon(
          CupertinoIcons.phone_circle_fill,
          color: Colors.white,
        ),
      ).safeArea(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person_outline_rounded),
            tooltip: 'Your Profile',
            onPressed: () {},
          ).p20(),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menu Icon',
          onPressed: () {},
        ).p20(),
        toolbarHeight: 100,
        elevation: 10,
        shadowColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        backgroundColor: context.canvasColor,
        centerTitle: true,
        title: "Hi! Welcome to the VIPS event management".text.bold.xl3.make(),
        foregroundColor: context.accentColor,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SfCalendar(
              view: CalendarView.month,
              showNavigationArrow: true,
              cellBorderColor: Colors.blue,
              selectionDecoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                shape: BoxShape.rectangle,
              )).h64(context).p24(),
          SizedBox(
            height: 40,
            child: "Form".text.xl4.make(),
          ),
          SizedBox(
            height: 1200,
            child: CreateSheetsPage(User),
          )
        ]),
      ),
    ).safeArea();
  }
}

class CreateSheetsPage extends StatelessWidget {
  const CreateSheetsPage(Type user, {super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(32),
            child: UserFormWidget(onSavedUser: (user) async {
              await UserSheetsApi.insert([user.toJson()]);
            })),
      );
}
