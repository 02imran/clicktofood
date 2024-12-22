class RegisterBody {
  RegisterBody({
    this.userName,
    this.email,
    this.mobile,
    this.password,
  });

  RegisterBody.fromJson(dynamic json) {
    userName = json['userName'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
  }
  String? userName;
  String? email;
  String? mobile;
  String? password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = userName;
    map['email'] = email;
    map['mobile'] = mobile;
    map['password'] = password;
    return map;
  }

}