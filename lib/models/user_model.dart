class UserModel {
  final String businessName;
  final String businessType;
  final String gstNo;
  final String address;
  final String pincode;
  final String name;
  final String mobile;
  final String state;
  final String city;
  final String regionId;
  final String areaId;
  final String appPk;
  final String image;
  final String userId;
  final String bankAccountId;
  final String type;
  final String parentId;
  final String brandIds;
  final String id;

  UserModel({
    required this.businessName,
    required this.businessType,
    required this.gstNo,
    required this.address,
    required this.pincode,
    required this.name,
    required this.mobile,
    required this.state,
    required this.city,
    required this.regionId,
    required this.areaId,
    required this.appPk,
    required this.image,
    required this.userId,
    required this.bankAccountId,
    required this.type,
    required this.parentId,
    required this.brandIds,
    required this.id,
  });

  /// Factory constructor for JSON parsing
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      businessName: json["business_name"] ?? "",
      businessType: json["business_type"] ?? "",
      gstNo: json["gst_no"] ?? "",
      address: json["address"] ?? "",
      pincode: json["pincode"] ?? "",
      name: json["name"] ?? "",
      mobile: json["mobile"] ?? "",
      state: json["state"] ?? "",
      city: json["city"] ?? "",
      regionId: json["region_id"] ?? "",
      areaId: json["area_id"] ?? "",
      appPk: json["app_pk"] ?? "",
      image: json["image"] ?? "",
      userId: json["user_id"] ?? "",
      bankAccountId: json["bank_account_id"] ?? "",
      type: json["type"] ?? "",
      parentId: json["parent_id"] ?? "",
      brandIds: json["brand_ids"] ?? "",
      id: json["id"] ?? "",
    );
  }

  /// Convert object back to JSON
  Map<String, dynamic> toJson() {
    return {
      "business_name": businessName,
      "business_type": businessType,
      "gst_no": gstNo,
      "address": address,
      "pincode": pincode,
      "name": name,
      "mobile": mobile,
      "state": state,
      "city": city,
      "region_id": regionId,
      "area_id": areaId,
      "app_pk": appPk,
      "image": image,
      "user_id": userId,
      "bank_account_id": bankAccountId,
      "type": type,
      "parent_id": parentId,
      "brand_ids": brandIds,
      "id": id,
    };
  }
}
