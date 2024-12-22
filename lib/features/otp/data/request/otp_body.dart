/// otp : "string"

class OtpBody {
  OtpBody({this.otp, this.email});

  OtpBody.fromJson(dynamic json) {
    otp = json['otp'];
    email = json['email'];
  }
  String? otp;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['otp'] = otp;
    map['email'] = email;
    return map;
  }

}