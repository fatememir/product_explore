import 'package:dio/dio.dart';
import '../../../main.dart';
import '../../utils/constant/constant.dart';
import 'package:flutter/material.dart';

extension DioExtensions on Dio {
  Future<T> safeGet<T>(
      String path,
      T Function(dynamic json) mapper, {
        dynamic data,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    Options? options;

    try {
      final response = await get(
        Constants.serverUrlDio + path,
        data: data,
        options: options,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode == 200) {
        return mapper(response.data);
      } else {
        _showSnackbar('Error: ${response.statusCode}');
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      if (e.response != null) {
        _showSnackbar('DioException: ${e.response?.data}');
      } else {
        _showSnackbar('DioException without response: $e');
      }
      rethrow;
    } catch (e) {
      _showSnackbar('Unexpected error: $e');
      rethrow;
    }
  }

  void _showSnackbar(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
