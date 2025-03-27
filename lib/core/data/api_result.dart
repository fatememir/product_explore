import 'package:dio/dio.dart';

abstract class ApiResult<T> {
  static ApiResult<T> fromResponse<T>(Response response, T Function(dynamic json) mapper) {
    try {
      final responseData = response.data;
      print("🔥 Full API Response: $responseData");

      final mapped = mapper(responseData);
      return Success<T>(mapped, "Success", true);
    } catch (e) {
      print("❌ Mapping error: $e");
      return InternalError<T>();
    }
  }
}

class Success<T> extends ApiResult<T> {
  final T? data;
  final String message;
  final bool status;

  Success(this.data, this.message, this.status);
}

class Failed<T> extends ApiResult<T> {
  List<ApiError>? errors;

  Failed(this.errors);
}

class ApiError {
}

class NetworkError<T> extends Failed<T> {
  NetworkError(super.errors);
}

class InternalError<T> extends Failed<T> {
  InternalError() : super(List.empty());
}
