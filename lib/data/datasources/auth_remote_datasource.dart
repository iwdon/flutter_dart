import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_fic7_app/common/global_variables.dart';
import 'package:flutter_fic7_app/data/datasources/auth_local_datasource.dart';
import 'package:flutter_fic7_app/data/models/auth_response_model.dart';
import 'package:flutter_fic7_app/data/models/requests/login_request_model.dart';
import 'package:http/http.dart' as http;
import '../models/requests/register_request_model.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> register(
      RegisterRequestModel model) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final response = await http.post(
        Uri.parse('${GlobalVariables.baseUrl}/api/register'),
        headers: headers,
        body: model.toJson());

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return const Left('Sever Eror');
    }
  }

  Future<Either<String, AuthResponseModel>> login(
      LoginRequestModel model) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    final response = await http.post(
        Uri.parse('${GlobalVariables.baseUrl}/api/login'),
        headers: headers,
        body: model.toJson());

    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      final obj = jsonDecode(response.body);
      return Left(obj['message']);
    }
  }

  Future<Either<String, String>> logout() async {
    final token = await AuthLocalDatasource().getToken();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.post(
      Uri.parse('${GlobalVariables.baseUrl}/api/logout'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return const Right('logout success');
    } else {
      return const Left('Sever Eror');
    }
  }
}
