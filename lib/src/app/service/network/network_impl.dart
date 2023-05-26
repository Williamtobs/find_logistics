import 'package:dio/dio.dart';
import 'package:find_logistic/src/app/constant/app_string.dart';
import 'package:find_logistic/src/app/model/user.dart';
import 'package:find_logistic/src/app/service/network/network.dart';
import 'package:find_logistic/src/screens/auth/login/login.dart';
import 'package:find_logistic/src/screens/widgets/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkImpl implements Network {
  final Dio _dio;
  final Ref ref;

  SharedPreferences? _sharedPreference;
  //SharedPreference? _sharedPreference;

  NetworkImpl({required Dio dio, required this.ref}) : _dio = dio;

  @override
  Future<Response> get({
    required String path,
    Map<String, dynamic>? formData,
  }) async {
    var token = await _getToken();
    var fullUrl = "$url$path";
    final response = await _dio.get(
      fullUrl,
      queryParameters: formData,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json"
        },
      ),
    );
    return response;
  }

  @override
  Future<Response> getAsync({required String path}) async {
    var fullUrl = "$url$path";
    final response = await _dio.get(
      fullUrl,
    );
    return response;
  }

  @override
  Future<AppUser?> getUserProfile({required BuildContext context}) {
    // TODO: implement getUserProfile
    throw UnimplementedError();
  }

  @override
  Future<void> logout({required BuildContext context}) async {
    await Future.delayed(const Duration(seconds: 3), () async {
      _deleteToken();
      BottomSnack.successSnackBar(
          message: 'Log out successfully', context: context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Future<Response> post(
      {required Map<String, dynamic> formData, required String path}) async {
    var fullUrl = "$url$path";
    // _dio.options.headers["Content-Type"] = "application/json";
    final response = await _dio.post(
      fullUrl,
      data: FormData.fromMap(formData),
      options: Options(
        validateStatus: (_) => true,
        headers: {"Content-Type": "application/json", "Accept": "*/*"},
      ),
    );
    return response;
  }

  @override
  Future postMultipart(
      {required Map<String, String> formData,
      required String path,
      required String pathName,
      required List files}) {
    // TODO: implement postMultipart
    throw UnimplementedError();
  }

  @override
  Future<Response> postWithToken(
      {required Map<String, dynamic> formData, required String path}) async {
    var token = await _getToken();
    var fullUrl = "$url$path";
    try {
      final data = await _dio.post(
        fullUrl,
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json"
          },
        ),
      );
      return data;
      // return BaseResponse(
      //   success: true,
      //   data: data,
      //   message: "Data fetched successfully",
      // );
    } on DioError catch (e) {
      return e.response!;
    }
  }

  _getToken() async {
    _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference!.get('token');
  }

  _deleteToken() async {
    _sharedPreference = await SharedPreferences.getInstance();
    return _sharedPreference!.remove('token');
  }
}
