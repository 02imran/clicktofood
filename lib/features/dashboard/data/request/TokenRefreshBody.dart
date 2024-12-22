/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6Ijg3MjExZTZkLWJmMTQtNGU5ZS1iYmY1LTQ5ZThlM2EzODNmNyIsInJvbGUiOiIiLCJuYmYiOjE3MzQ4MDE3NTgsImV4cCI6MTczNDgwMjM1OCwiaWF0IjoxNzM0ODAxNzU4fQ.FYGgEU5K7Sp0diWBVOHw48ybuirwIlo5ILT2MuXCTOg"
/// refreshToken : "73d1d498-e734-4281-aaed-767473099896"

class TokenRefreshBody {
  TokenRefreshBody({
      this.token, 
      this.refreshToken,});

  TokenRefreshBody.fromJson(dynamic json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
  }
  String? token;
  String? refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    map['refreshToken'] = refreshToken;
    return map;
  }

}