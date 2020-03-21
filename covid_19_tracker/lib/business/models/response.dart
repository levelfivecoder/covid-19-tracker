class Response<T> {
  ApiStatus status;
  T data;
  String message;

  Response.loading(this.message) : status = ApiStatus.loading;
  Response.completed(this.data) : status = ApiStatus.completed;
  Response.error(this.message) : status = ApiStatus.error;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

enum ApiStatus { loading, completed, error }