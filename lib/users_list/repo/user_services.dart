import 'dart:io';

import 'package:flutter_mvvm/users_list/models/users_list_model.dart';
import 'package:flutter_mvvm/users_list/repo/api_status.dart';
import 'package:flutter_mvvm/utils/constants.dart';
import 'package:http/http.dart' as http;

class UserServices {
  static Future<Object> getUsers() async {
    try {
      var url = Uri.parse(USERSURL);
      var response = await http.get(url);

      final responseCode = response.statusCode;
      final responseBody = response.body;

      if (200 == responseCode) {
        return Success(
          code: responseCode,
          response: usersListModelFromJson(
            responseBody,
          ),
        );
      } else {
        return Failure(
          code: responseCode,
          errorResponse: 'Invalid response',
        );
      }
    } on FormatException {
      return Failure(code: INVALIDFORMAT, errorResponse: 'Invalid format');
    } on SocketException {
      return Failure(code: NOINTERNET, errorResponse: 'No internet');
    } catch (e) {
      return Failure(code: UNKNOWNERROR, errorResponse: 'Unknown error');
    }
  }
}
