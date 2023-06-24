class Success {
  final int code;
  final Object response;

  Success({required this.code, required this.response});
}

class Failure {
  int code;
  Object errorResponse;

  Failure({required this.code, required this.errorResponse});
}
