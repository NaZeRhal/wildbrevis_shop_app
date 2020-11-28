import 'package:flutter/cupertino.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wildbrevis_shop_app/models/http_exception.dart';

class Auth with ChangeNotifier {
  static const SIGN_UP = 'signUp';
  static const SIGN_IN_WITH_PASSWORD = 'signInWithPassword';

  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCaXhR9bOsEV2xzKy2MruKOsbijH7aC2wY';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, Auth.SIGN_UP);
  }

  Future<void> signin(String email, String password) async {
    return _authenticate(email, password, Auth.SIGN_IN_WITH_PASSWORD);
  }
}
