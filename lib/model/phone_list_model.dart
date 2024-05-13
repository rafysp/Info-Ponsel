import 'dart:convert';

class PhoneListModel {
  String? id;
  String? phoneName;
  String? description;
  String? imageUrl;

  PhoneListModel({
    this.id,
    this.phoneName,
    this.description,
    this.imageUrl,
  });

  PhoneListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneName = json['phone_name'];
    description = json['description'];
    imageUrl = json['image_url'];
  }
}
