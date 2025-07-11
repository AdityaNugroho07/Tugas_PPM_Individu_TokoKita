
class AppException implements Exception{
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);
  @override
  String toString() {
    return "$_prefix$_message";
  }
}
class FetchDataException extends AppException {
  FetchDataException([String? mesaage]):super(mesaage, "Eror During Communication:");
}
class BadRequestException extends AppException {
  BadRequestException([mesaage]):super(mesaage, "Invalid Request:");
}
class UnauthorisedException extends AppException {
  UnauthorisedException([mesaage]):super(mesaage, "Unauthorised:");
}
class UnprocessableEntityException extends AppException {
  UnprocessableEntityException([mesaage]):super(mesaage, "Unprocessable Entity:");
}
class InvalidInputException extends AppException {
  InvalidInputException([mesaage]):super(mesaage, "Invalid Input:");
}