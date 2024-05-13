class BrandModel {
   String? name;
   int? id;

  BrandModel({
    required this.name,
    required this.id,
  });

   BrandModel.fromJson(Map<String, dynamic> json) {
      name= json['name'];
      id= json['id'];
    
  }
}
