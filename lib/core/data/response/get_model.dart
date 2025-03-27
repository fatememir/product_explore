import 'package:dio/dio.dart';
import '../../../main.dart';
import '../../utils/constant/constant.dart';
import 'package:flutter/material.dart';

import '../api_result.dart';

extension DioExtensions on Dio {
  Future<ApiResult<T>> safeGet<T>(
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
        final mapped = mapper(response.data);
        return Success<T>(mapped, "Success", true);
      } else {
        _showSnackbar('Error: ${response.statusCode}');
        return InternalError<T>();
      }
    } on DioException catch (e) {
      if (e.response != null) {
        _showSnackbar('DioException: ${e.response?.data}');
      } else {
        _showSnackbar('DioException without response: $e');
      }

      return NetworkError<T>([
        ApiError()
      ]);
    } catch (e) {
      _showSnackbar('Unexpected error: $e');
      return InternalError<T>();
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
