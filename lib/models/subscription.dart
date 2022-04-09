class Subscription {
  bool? status;
  List<Subscriptions>? subscriptions;

  Subscription({this.status, this.subscriptions});

  Subscription.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['subscriptions'] != null) {
      subscriptions = <Subscriptions>[];
      json['subscriptions'].forEach((v) {
        subscriptions?.add(Subscriptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (subscriptions != null) {
      data['subscriptions'] = subscriptions?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subscriptions {
  String? productId;
  String? title;
  String? durationType;
  int? duration;
  String? description;
  int? position;
  int? status;

  Subscriptions(
      {this.productId,
      this.title,
      this.durationType,
      this.duration,
      this.description,
      this.position,
      this.status});

  Subscriptions.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    title = json['title'];
    durationType = json['duration_type'];
    duration = json['duration'];
    description = json['description'];
    position = json['position'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['title'] = title;
    data['duration_type'] = durationType;
    data['duration'] = duration;
    data['description'] = description;
    data['position'] = position;
    data['status'] = status;
    return data;
  }
}
