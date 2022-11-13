import 'dart:html';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

final Uri _url = Uri.parse('https://forms.gle/j6c6sp2LqqHgzT1s6');

class HomePage extends StatelessWidget {
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: context.theme.canvasColor,
        floatingActionButton: FloatingActionButton(
          backgroundColor: context.theme.buttonColor,
          onPressed: () {},
          child: Icon(
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
          title:
              "Hi! Welcome to the VIPS event management".text.bold.xl3.make(),
          foregroundColor: context.accentColor,
        ),
        body: Column(children: [
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
          ElevatedButton(
            child: "To Book The Venue Click Here".text.bold.xl3.make(),
            onPressed: _launchUrl,
          )
        ])).safeArea();
  }
}
