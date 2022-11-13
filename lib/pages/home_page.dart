import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:scheduler_app/widgets/themes.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SfCalendar(view: CalendarView.month))
        .safeArea()
        .p32();
  }
}
