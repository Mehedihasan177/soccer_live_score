class UserModel {
  String? uid;
  String? name;
  String? image;
  String? email;
  String? phone;
  int? color;
  String? prodiver;
  String? isCompleted;

  UserModel({
    this.uid,
    this.name,
    this.image,
    this.email,
    this.phone,
    this.color,
    this.prodiver,
    this.isCompleted,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    image = json['image'];
    email = json['email'];
    phone = json['phone'];
    color = json['color'];
    prodiver = json['prodiver'];
    isCompleted = json['isCompleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['image'] = image;
    data['email'] = email;
    data['phone'] = phone;
    data['color'] = color;
    data['prodiver'] = prodiver;
    data['isCompleted'] = isCompleted;

    return data;
  }
}
