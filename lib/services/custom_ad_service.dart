class CustomAdService {}

class CustomAd {
  bool? status;
  Data? data;

  CustomAd({this.status, this.data});

  CustomAd.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? adsType;
  String? image;
  String? title;
  String? shortDescription;
  String? buttonText;
  String? actionUrl;

  Data(
      {this.id,
      this.adsType,
      this.image,
      this.title,
      this.shortDescription,
      this.buttonText,
      this.actionUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adsType = json['ads_type'];
    image = json['image'];
    title = json['title'];
    shortDescription = json['short_description'];
    buttonText = json['button_text'];
    actionUrl = json['action_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ads_type'] = adsType;
    data['image'] = image;
    data['title'] = title;
    data['short_description'] = shortDescription;
    data['button_text'] = buttonText;
    data['action_url'] = actionUrl;
    return data;
  }
}
