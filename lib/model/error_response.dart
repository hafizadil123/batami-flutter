class ErrorResponse {
  final String? error;
  final String? errorDescription;

  ErrorResponse({
    this.error,
    this.errorDescription,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> parsedJson) {
    return ErrorResponse(
      error: parsedJson['error'],
      errorDescription: parsedJson['error_description'],
    );
  }
}
