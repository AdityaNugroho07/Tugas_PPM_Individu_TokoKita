
class Login {
  int? code;
  bool? status;
  String? token;
  int? userID;
  String? userEmail;

  Login({this.code, this.status, this.token, this.userEmail, this.userID});

  factory Login.fromJson(Map<String, dynamic> obj) {
    return Login(
      code: obj['code'],
      status: obj['status'],
      token: obj['token'],
      userEmail: obj['data']['user']['userEmail'],
      userID: obj['data']['user']['id']
    );
  }
}