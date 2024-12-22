/// email : "string"

class LoginBody {
  LoginBody({this.email, this.userName, this.password});

  LoginBody.fromJson(dynamic json) {
    email = json['email'];
    userName = json['userName'];
    password = json['password'];
  }
  String? email;
  String? userName;
  String? password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['userName'] = userName;
    map['password'] = password;
    return map;
  }

}