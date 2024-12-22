/// result : {"succeeded":true,"isLockedOut":false,"isNotAllowed":false,"requiresTwoFactor":false}
/// isAuthenticated : true
/// id : "87211e6d-bf14-4e9e-bbf5-49e8e3a383f7"
/// userFName : null
/// userLName : null
/// phoneNumber : null
/// userName : "testme0098@gmail.com"
/// tokenString : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6Ijg3MjExZTZkLWJmMTQtNGU5ZS1iYmY1LTQ5ZThlM2EzODNmNyIsInJvbGUiOiIiLCJuYmYiOjE3MzQ3OTAzMzksImV4cCI6MTczNDc5MDkzOSwiaWF0IjoxNzM0NzkwMzM5fQ.yyfcVftZuXrN-jfsVI-ra_L0IxTPvvMgHqiveezQ9-4"
/// refreshToken : "c67b73ee-bd1f-4c63-9884-da3bd9be1a7f"

class LoginResponse {
  LoginResponse({
      this.result, 
      this.isAuthenticated, 
      this.id, 
      this.userFName, 
      this.userLName, 
      this.phoneNumber, 
      this.userName, 
      this.message,
      this.tokenString,
      this.refreshToken,});

  LoginResponse.fromJson(dynamic json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    isAuthenticated = json['isAuthenticated'];
    id = json['id'];
    userFName = json['userFName'];
    userLName = json['userLName'];
    phoneNumber = json['phoneNumber'];
    userName = json['userName'];
    tokenString = json['tokenString'];
    message = json['message'];
    refreshToken = json['refreshToken'];
  }
  Result? result;
  bool? isAuthenticated;
  String? id;
  dynamic userFName;
  dynamic userLName;
  dynamic phoneNumber;
  dynamic message;
  String? userName;
  String? tokenString;
  String? refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (result != null) {
      map['result'] = result?.toJson();
    }
    map['isAuthenticated'] = isAuthenticated;
    map['id'] = id;
    map['userFName'] = userFName;
    map['userLName'] = userLName;
    map['phoneNumber'] = phoneNumber;
    map['message'] = message;
    map['userName'] = userName;
    map['tokenString'] = tokenString;
    map['refreshToken'] = refreshToken;
    return map;
  }

}

/// succeeded : true
/// isLockedOut : false
/// isNotAllowed : false
/// requiresTwoFactor : false

class Result {
  Result({
      this.succeeded, 
      this.isLockedOut, 
      this.isNotAllowed, 
      this.requiresTwoFactor,});

  Result.fromJson(dynamic json) {
    succeeded = json['succeeded'];
    isLockedOut = json['isLockedOut'];
    isNotAllowed = json['isNotAllowed'];
    requiresTwoFactor = json['requiresTwoFactor'];
  }
  bool? succeeded;
  bool? isLockedOut;
  bool? isNotAllowed;
  bool? requiresTwoFactor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['succeeded'] = succeeded;
    map['isLockedOut'] = isLockedOut;
    map['isNotAllowed'] = isNotAllowed;
    map['requiresTwoFactor'] = requiresTwoFactor;
    return map;
  }

}