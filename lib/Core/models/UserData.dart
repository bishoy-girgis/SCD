
class UserData {
  UserData({
      this.name, 
      this.email, 
      this.phone, 
      this.image, 
      this.birthday, 
      this.gender,});

  UserData.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    birthday = json['birthday'];
    gender = json['gender'];
  }
  String? name;
  String? email;
  String? phone;
  dynamic image;
  String? birthday;
  String? gender;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['image'] = image;
    map['birthday'] = birthday;
    map['gender'] = gender;
    return map;
  }

}