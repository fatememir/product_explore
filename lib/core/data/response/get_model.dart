import 'package:dio/dio.dart';
import '../../utils/constant/constant.dart';

extension DioExtensions on Dio {
  Future<T> safeGet<T>(String path, T Function(dynamic json) mapper, {
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
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse, // Example for failed response type
        );
      }
    } on DioException catch (e) {
      // Handle Dio exceptions
      if (e.response != null) {
        print('DioException with response: ${e.response?.data}');
      } else {
        print('DioException without response: $e');
      }
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      print('Unexpected error: $e');
      throw e;
    }
  }
}




