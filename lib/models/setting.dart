class Setting {
  bool? status;
  Data? data;

  Setting({this.status, this.data});

  Setting.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? appUniqueId;
  String? appName;
  String? appLogo;
  String? appPublishingControl;
  String? adsControl;
  String? iosShareLink;
  String? iosAppPublishingControl;
  String? iosAdsControl;
  String? privacyPolicy;
  String? facebook;
  String? telegram;
  String? youtube;
  String? enableCountries;

  Data(
      {this.appUniqueId,
      this.appName,
      this.appLogo,
      this.appPublishingControl,
      this.adsControl,
      this.iosShareLink,
      this.iosAppPublishingControl,
      this.iosAdsControl,
      this.privacyPolicy,
      this.facebook,
      this.telegram,
      this.youtube,
      this.enableCountries});

  Data.fromJson(Map<String, dynamic> json) {
    appUniqueId = json['app_unique_id'];
    appName = json['app_name'];
    appLogo = json['app_logo'];
    appPublishingControl = json['app_publishing_control'];
    adsControl = json['ads_control'];
    iosShareLink = json['ios_share_link'];
    iosAppPublishingControl = json['ios_app_publishing_control'];
    iosAdsControl = json['ios_ads_control'];
    privacyPolicy = json['privacy_policy'];
    facebook = json['facebook'];
    telegram = json['telegram'];
    youtube = json['youtube'];
    enableCountries = json['enable_countries'];
  }

 Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_unique_id'] = appUniqueId;
    data['app_name'] = appName;
    data['app_logo'] = appLogo;
    data['app_publishing_control'] = appPublishingControl;
    data['ads_control'] = adsControl;
    data['ios_share_link'] = iosShareLink;
    data['ios_app_publishing_control'] = iosAppPublishingControl;
    data['ios_ads_control'] = iosAdsControl;
    data['privacy_policy'] = privacyPolicy;
    data['facebook'] = facebook;
    data['telegram'] = telegram;
    data['youtube'] = youtube;
    data['enable_countries'] = enableCountries;
    return data;
  }
}
