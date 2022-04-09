class Payment {
  bool? status;
  List<Payments>? payments;

  Payment({this.status, this.payments});

  Payment.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['payments'] != null) {
      payments = <Payments>[];
      json['payments'].forEach((v) {
        payments?.add(Payments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (payments != null) {
      data['payments'] = payments?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payments {
  String? title;
  String? productId;
  String? amount;
  String? method;
  String? createdAt;

  Payments(
      {this.title, this.productId, this.amount, this.method, this.createdAt});

  Payments.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    productId = json['product_id'];
    amount = json['amount'];
    method = json['method'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['title'] = title;
    data['product_id'] = productId;
    data['amount'] = amount;
    data['method'] = method;
    data['created_at'] = createdAt;
    return data;
  }
}
