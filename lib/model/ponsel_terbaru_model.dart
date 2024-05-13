class PonselTerbaruModel {
  int? brandId;
  String? brandName;
  String? id;
  String? phoneName;
  String? imageUrl;
  String? description;

  PonselTerbaruModel({
    required this.brandId,
    required this.brandName,
    required this.id,
    required this.phoneName,
    required this.imageUrl,
    required this.description,
  });

  PonselTerbaruModel.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    id = json['id'];
    phoneName = json['phone_name'];
    imageUrl = json['image_url'];
    description = json['description'];
  }
}
