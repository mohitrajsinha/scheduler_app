import 'package:android_app/models/user.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetsApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "vipsevent",
  "private_key_id": "6470b583582836d4e30b4da851efd5199c46bdd1",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC4WrPuD/XvjNzL\nQ7OSCipbeiD1RggMCKdWIWDNc9YjvU/E9YNNm4opWubQBqI4BHABn4LqxhNic4ff\nInJDca1APT3mHQfRohQelBamhn0IgEN/K9v7KAmYma2etbIA4g+HE1daFpCS5W4f\nZKT6/dMkxH4DeE2Kgd6PtOgO9XlT/5fvogUFbCIhKfhtdmyECCnikt5PwrZfwPx3\nfESizasrTALClJrN+dJchS5ggOuBYShy4J0L038Vj0awmrxuQCCDh+s/SiY9D0af\nHbf1bvBD6zuijxpdpDmhZZGF1vBzJD+7W+A6XfJGXqylSdqNhcqFmv63mTvCJ2x5\nB6KJRbsLAgMBAAECggEAUbNA0lwYbhVLNHnIdwwyQWAagxiKMGsVXcJlGCgh2qzn\nUS5NBnPMAw/aAo8uDQ1KZi2+4zTtGlCBAo5NfT4/vZxmdjifYnQl3ndaomovtzjA\nsPdLAj94ITzaCOAVBvcoUoBr0ez2HWO4Lgl4ZBNhI4ZBImCKXLu5Wo6d2SNIpcR6\njZQi9EC4nVHqpUucQmFtZWcRKvYJwYpex4ejSunl/sOdilbZ7uSPQUVUo5dbkaMc\nHhtpCvum30dPUxin5NwKWnK+92h9YC/nGefH6bzcUufkTVZOa6cUPgfbxNzcZ3mv\n7xWbCPkvt73ciy/cWT+qvZCENcN3y4hFafaR9cbY4QKBgQDwnuayZhmkz20Nc+K7\nh+B2WxsJXMC6eYfc/KvIYjxZ2UqJfvhViaNpZ3x0YA4ZpoOvmD2J5V21JJD0pGxO\nLWnmlUtLThtjDd53avuxk2pFMzYbo/U0C3WhvpD7rAzzX+pLQ4qfaRIkNFKzZpKA\nuMjdBjRo1mciauiRfHV/wL7TvwKBgQDEIyf6y0pWabm+vAio7cpp407gP7LKcAqC\ntgZMNbu5QG8DmEI44FzFxbbX5DUyu2R0gbkwN06IF0xkOAqDScrqcJJbYkGVKw3p\nUCL/ADV7FS7ovHi5oiGepUVkM+Zk+V1bqHVR5PetD9jQO2YEduJV2NqZoc6FGDSo\naJkVB7M7tQKBgCZfAKUEWSSKG3bguxByu53EK4yTqPxTsxHPjUlYOQ2O9C72+30Q\nhOmjIhqg0r7OagOPgIjD9eyUFzWcHtVcsp2dwzMQEpf6NzbN7bNEsda1MvS3cbvJ\n9AlGDXLE3g/VhNRZwfpn1AfH/EQ1oDk8vnNYsPTi8/FuIQZKVaZ4wzWbAoGBAKfY\nvhntZoxUpdQH7hFCjXnYQGO/ny2GfDgntXP6d8+syFP3NJSfzESjUjmm3a+wleLu\nMKCGc/oalhEdtEFuIOxHsbfqed1BnwIOxiQa9amDE0WwJFAX41V0cdGyaHP4wl/x\n5ZRTsXC0owJwEnm3kzGMBmZ7BdT4RffoqzhIAqYRAoGBAM9TyAKkwWF6GSAtikjU\n5DkHl+BbHMiUtyDgJPw7P29IT2Y1Ryik7N6bYgfKZLx4bPUKc6p5RX9puSwt7nnl\n252VWJsN3fMGsML//AUZS8IUESe8mMS5IP/JQmPYJ5BRYbExfnDGbn3Ex1X37LcN\nnl1HKKZ3O67iShs6fo74YAYI\n-----END PRIVATE KEY-----\n",
  "client_email": "vipsevent-1000@vipsevent.iam.gserviceaccount.com",
  "client_id": "103677965962908903615",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/vipsevent-1000%40vipsevent.iam.gserviceaccount.com"
}

''';
  static final _spreadsheetId = '1RfgJ3Prc95tI5jhKD0ML2rb_PpqNeGGhcCW-ACiq-Cs';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _usersheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _usersheet = await _getWorkSheet(spreadsheet, title: 'User');
      final firstRow = UserFields.getFields();
      _usersheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print("Init Error:$e");
    }
  }

  static Future<Worksheet?> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title);
    }
  }

  static insert(List<Map<String, dynamic>> rowlist) async {
    if (_usersheet == null) return;
    _usersheet!.values.map.appendRows(rowlist);
  }
}
