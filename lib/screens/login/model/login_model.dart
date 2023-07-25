class LoginModel {
  LoginModel({
      this.status, 
      this.message, 
      this.data,});

  LoginModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? status;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.name, 
      this.firstName, 
      this.lastName, 
      this.email, 
      this.countryShortCode, 
      this.countryCode, 
      this.mobile, 
      this.profileImage, 
      this.referCode, 
      this.notificationFlag, 
      this.tradeCount, 
      this.token, 
      this.socialLogin,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    countryShortCode = json['country_short_code'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    profileImage = json['profile_image'];
    referCode = json['refer_code'];
    notificationFlag = json['notification_flag'];
    tradeCount = json['trade_count'];
    token = json['token'];
    socialLogin = json['social_login'];
  }
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? countryShortCode;
  String? countryCode;
  String? mobile;
  String? profileImage;
  String? referCode;
  String? notificationFlag;
  int? tradeCount;
  String? token;
  int? socialLogin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['country_short_code'] = countryShortCode;
    map['country_code'] = countryCode;
    map['mobile'] = mobile;
    map['profile_image'] = profileImage;
    map['refer_code'] = referCode;
    map['notification_flag'] = notificationFlag;
    map['trade_count'] = tradeCount;
    map['token'] = token;
    map['social_login'] = socialLogin;
    return map;
  }

}