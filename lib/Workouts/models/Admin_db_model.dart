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
    await http.get(Uri.parse(url)).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      print(jsonFeedback);
      _listAdmin =
          jsonFeedback.map((json) => AdminDbModel.fromJson(json)).toList();

      notifyListeners();
    });
    return null;
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

 // _listAdmin.add(AdminDbModel(
    //     emailId: 'madhu.vadali@iitgn.ac.in',
    //     name: 'Madhu Vadali',
    //     uniqueId: 'madhu.vadali@iitgn.ac.in'));
    // _listAdmin.add(AdminDbModel(
    //     emailId: 'gautam.pv@iitgn.ac.in',
    //     name: 'Gautam Vashishtha',
    //     uniqueId: 'gautam.pv@iitgn.ac.in'));