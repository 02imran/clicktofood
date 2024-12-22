/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6Ijg3MjExZTZkLWJmMTQtNGU5ZS1iYmY1LTQ5ZThlM2EzODNmNyIsInJvbGUiOiIiLCJuYmYiOjE3MzQ4MDIzOTAsImV4cCI6MTczNDgwMjk5MCwiaWF0IjoxNzM0ODAyMzkwfQ.c9GQqei65ND6J3wBovPWudsHnqSHT1pdlX2GNr3087M"
/// refreshToken : "68e1b050-71ae-4bfd-82f8-b4bf3a40fa83"

class TokenRefreshResponse {
  TokenRefreshResponse({
      this.token, 
      this.refreshToken,});

  TokenRefreshResponse.fromJson(dynamic json) {
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