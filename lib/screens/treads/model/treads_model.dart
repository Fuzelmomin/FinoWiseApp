class TreadsModel {
  TreadsModel({
      this.status, 
      this.message, 
      this.data, 
      this.newTrades,});

  TreadsModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    newTrades = json['new_trades'];
  }
  int? status;
  String? message;
  List<Data>? data;
  int? newTrades;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['new_trades'] = newTrades;
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.mentorId, 
      this.type, 
      this.entryPrice, 
      this.name, 
      this.stock, 
      this.exitPrice, 
      this.exitHigh, 
      this.stopLossPrice, 
      this.action, 
      this.result, 
      this.status, 
      this.postedDate, 
      this.fee, 
      this.isSubscribe, 
      this.user,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    mentorId = json['mentor_id'];
    type = json['type'];
    entryPrice = json['entry_price'];
    name = json['name'];
    stock = json['stock'];
    exitPrice = json['exit_price'];
    exitHigh = json['exit_high'];
    stopLossPrice = json['stop_loss_price'];
    action = json['action'];
    result = json['result'];
    status = json['status'];
    postedDate = json['posted_date'];
    fee = json['fee'];
    isSubscribe = json['is_subscribe'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  int? id;
  int? mentorId;
  String? type;
  int? entryPrice;
  String? name;
  String? stock;
  int? exitPrice;
  int? exitHigh;
  int? stopLossPrice;
  String? action;
  String? result;
  String? status;
  String? postedDate;
  String? fee;
  int? isSubscribe;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['mentor_id'] = mentorId;
    map['type'] = type;
    map['entry_price'] = entryPrice;
    map['name'] = name;
    map['stock'] = stock;
    map['exit_price'] = exitPrice;
    map['exit_high'] = exitHigh;
    map['stop_loss_price'] = stopLossPrice;
    map['action'] = action;
    map['result'] = result;
    map['status'] = status;
    map['posted_date'] = postedDate;
    map['fee'] = fee;
    map['is_subscribe'] = isSubscribe;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

class User {
  User({
      this.id, 
      this.name, 
      this.profileImage,});

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    profileImage = json['profile_image'];
  }
  int? id;
  String? name;
  String? profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['profile_image'] = profileImage;
    return map;
  }

}