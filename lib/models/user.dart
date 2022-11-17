import 'package:flutter_auto_form/flutter_auto_form.dart';

class UserFields {
  static final String name = 'name';
  static final String email = 'email';
  static final String Description = 'Description';
  static final String StartDateTime = 'StartDateTime';
  static final String EndDateTime = 'EndDateTime';
  static final String GuestEmail = 'GuestEmail';
  static final String Loctaion = 'Loctaion';

  static List<String> getFields() => [ name, email,Description,StartDateTime,EndDateTime,GuestEmail,Loctaion];
}

class User {
  
  final String? name;
  final String? email;
  final String? Description;
  final String? StartDateTime;
  final String? EndDateTime;
  final String? GuestEmail;
  final String? Location;
  

  const User({
    required this.name,
    required this.email,
    required this.Description,
    required this.StartDateTime,
    required this.EndDateTime,
    required this.GuestEmail,
    required this.Location,
  });

  Map<String, dynamic> toJson() => {
        UserFields.name: name,
        UserFields.email: email,
        UserFields.Description:Description,
        UserFields.StartDateTime:StartDateTime,
        UserFields.EndDateTime:EndDateTime,
        UserFields.GuestEmail:GuestEmail,
        UserFields.Loctaion:Location,
      };
}
