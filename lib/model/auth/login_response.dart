class LoginResponse {
  final String? accessToken;
  final String? tokenType;
  final String? userName;

  LoginResponse({
    this.accessToken,
    this.tokenType,
    this.userName,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> parsedJson) {
    return LoginResponse(
      accessToken: parsedJson['access_token'],
      tokenType: parsedJson['token_type'],
      userName: parsedJson['userName'],
    );
  }
}
