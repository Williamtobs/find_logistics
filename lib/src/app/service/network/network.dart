import 'package:dio/dio.dart';
import 'package:find_logistic/src/app/model/user.dart';
import 'package:flutter/material.dart';

abstract class Network {
  Future<Response> postWithToken(
      {required Map<String, dynamic> formData, required String path});
  Future<Response> post(
      {required Map<String, dynamic> formData, required String path});
  Future<Response> get({required String path});
  Future<Response> getAsync({required String path});
  Future<void> logout({required BuildContext context});
  Future<AppUser?> getUserProfile({required BuildContext context});
  Future postMultipart({
    required Map<String, String> formData,
    required String path,
    required String pathName,
    required List<dynamic> files,
  });
}
