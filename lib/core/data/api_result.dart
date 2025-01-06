abstract class ApiResult<T> {}

class Success<T> extends ApiResult<T> {
  final T? data;
  final String message;
  final bool status;

  Success(this.data, this.message, this.status);
}
