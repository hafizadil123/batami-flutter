class LoggedInUser {
  final String? code;
  final String? userName;
  final String? idNumber;
  final String? firstName;
  final String? lastName;
  final String? cellPhone;
  final String? email;
  final bool? isActive;
  final bool? isAbroad;
  final bool? isFemale;
  final String? userType;
  final int? regCoo;
  final bool? result;
  final String? message;

  LoggedInUser(
      {this.code,
      this.userName,
      this.idNumber,
      this.firstName,
      this.lastName,
      this.cellPhone,
      this.email,
      this.isActive,
      this.isAbroad,
      this.isFemale,
      this.userType,
      this.regCoo,
      this.result,
      this.message});

  factory LoggedInUser.fromJson(Map<String, dynamic> parsedJson) {
    return LoggedInUser(
      code: parsedJson['code'],
      userName: parsedJson['userName'],
      idNumber: parsedJson['idNumber'],
      firstName: parsedJson['firstName'],
      lastName: parsedJson['lastName'],
      cellPhone: parsedJson['cellPhone'],
      email: parsedJson['email'],
      isActive: parsedJson['isActive'],
      isAbroad: parsedJson['isAbroad'],
      isFemale: parsedJson['isFemale'],
      userType: parsedJson['userType'],
      regCoo: parsedJson['regCoo'],
      result: parsedJson['result'],
      message: parsedJson['message'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'code': code,
        'userName': userName,
        'idNumber': idNumber,
        'firstName': firstName,
        'lastName': lastName,
        'cellPhone': cellPhone,
        'email': email,
        'isActive': isActive,
        'isAbroad': isAbroad,
        'isFemale': isFemale,
        'userType': userType,
        'regCoo': regCoo,
        'result': result,
        'message': message,
      };
}
