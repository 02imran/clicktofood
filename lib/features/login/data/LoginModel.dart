/// status : 200
/// success : false
/// message : "User Not Found"

class CommonResponse {
  CommonResponse({
      this.status, 
      this.success, 
      this.succeeded,
      this.message,});

  CommonResponse.fromJson(dynamic json) {
    status = json['status'];
    success = json['success'];
    succeeded = json['succeeded'];
    message = json['message'];
  }
  num? status;
  bool? success;
  bool? succeeded;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['success'] = success;
    map['succeeded'] = succeeded;
    map['message'] = message;
    return map;
  }

}