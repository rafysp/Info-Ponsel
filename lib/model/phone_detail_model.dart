
class DetailPhone {
  final Map<String, List<AllSpec>> allSpecs;

  DetailPhone({
    required this.allSpecs,
  });
}

class AllSpec {
  final String title;
  final String info;

  AllSpec({
    required this.title,
    required this.info,
  });
}

class PhoneDetailModel {
  final String? phoneId;
  final String? imageUrl;
  final String? phoneName;
  final String? description;
  final String? brandName;
  final Map<String, List<AllSpec>> allSpecs;

  PhoneDetailModel({
    this.phoneId,
    this.imageUrl,
    this.phoneName,
    this.description,
    this.brandName,
    this.allSpecs = const {},
  });

  PhoneDetailModel.fromJson(Map<String, dynamic>? json)
      : phoneId = json?['phoneId'],
        imageUrl = json?['imageUrl'],
        phoneName = json?['phoneName'],
        description = json?['description'],
        brandName = json?['brandName'],
        allSpecs = Map<String, List<AllSpec>>.from(json?['allSpecs'] ?? {});
}
