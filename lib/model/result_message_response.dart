class ResultMessageResponse {
  final bool? result;
  final String? message;

  ResultMessageResponse({
    this.result,
    this.message,
  });

  factory ResultMessageResponse.fromJson(Map<String, dynamic> parsedJson) {
    return ResultMessageResponse(
      result: parsedJson['Result'],
      message: parsedJson['Message'],
    );
  }
}
