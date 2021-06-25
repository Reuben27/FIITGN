import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AdminDbModel {
  final String emailId;
  final String uniqueId;
  final String name;

  AdminDbModel({
    @required this.emailId,
    @required this.name,
    @required this.uniqueId,
  });

  factory AdminDbModel.fromJson(dynamic json) {
    return AdminDbModel(
        emailId: "${json['email id']}",
        uniqueId: "${json['unique id']}",
        name: "${json['name']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'id': emailId,
        'name': name,
        'url': uniqueId,
      };
}

class GetAdminDataFromGoogleSheetProvider with ChangeNotifier {
  // ignore: deprecated_member_use
  List<AdminDbModel> _listAdmin = List<AdminDbModel>();
  static const url =
      "https://script.google.com/macros/s/AKfycbx57muC0PlTGKmlkLTfrKP4Om9QJn1pjtVShNxc0Hxv7F5z9Sx5JB1xxhxGyiwchOw/exec";
  getListOfAdmins() async {
    print("t1");
    await http.get(Uri.parse(url)).then((response) {
      print("t2");
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      print("t3");
      print(jsonFeedback);
      print("t4");
      _listAdmin =
          jsonFeedback.map((json) => AdminDbModel.fromJson(json)).toList();
      print("t5");
      notifyListeners();
    });
    // return null;
  }

  List<String> getAdminEmailIds() {
    // print(_listAdmin[0].name);
    List<String> adminEmailIds = [];
    _listAdmin.forEach(
      (element) {
        adminEmailIds.add(element.emailId);
      },
    );
    print(adminEmailIds);
    return adminEmailIds;
  }

  List<AdminDbModel> get listAdmin {
    return [..._listAdmin];
  }
}
