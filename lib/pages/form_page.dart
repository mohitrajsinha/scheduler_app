import 'package:flutter_auto_form/flutter_auto_form.dart';
import 'package:flutter/material.dart';


class formPage extends TemplateForm {
  @override
  final List<Field> fields = [
    AFTextField(
      id: 'identifier',
      name: 'Identifier',
      validators: [
        MinimumStringLengthValidator(
          5,
          (e) => 'Min 5 characters, currently ${e?.length ?? 0} ',
        )
      ],
      type: AFTextFieldType.NEW_USERNAME,
    ),
    AFTextField(
      id: 'email',
      name: 'E-mail',
      validators: [EmailValidator('Please enter a valid email')],
      type: AFTextFieldType.EMAIL,
    ),
    AFTextField(
      id: 'password',
      name: 'Password',
      validators: [
        MinimumStringLengthValidator(
          6,
          (e) => 'Min 6 characters, currently ${e?.length ?? 0} ',
        )
      ],
      type: AFTextFieldType.NEW_PASSWORD,
    ),
    AFBooleanField(
      id: 'accept-condition',
      name: 'Accept terms',
      validators: [ShouldBeTrueValidator('Please accept terms')],
      value: false,
    ),
  ];
}