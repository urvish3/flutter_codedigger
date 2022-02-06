import 'dart:typed_data';
class Category {
  final int? catId;
  final String? catName;
  final Uint8List? catImage;
  final Uint8List? catIcon;

  Category({
    this.catId,
    this.catName,
    this.catImage,
    this.catIcon,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      catId: map['cat_id'],
      catName: map['cat_name'],
      catImage: map['cat_img'],
      catIcon: map['cat_icon'],
    );
  }
}

class AnimalData {
  final int? catId;
  final int? animalId;
  final String? animalName;
  final String? animalDetails;
  final Uint8List? animalImage;

  AnimalData({
    this.catId,
    this.animalId,
    this.animalName,
    this.animalDetails,
    this.animalImage,
  });

  factory AnimalData.fromMap(Map<String, dynamic> map) {
    return AnimalData(
      catId: map['cat_id'],
      animalId: map['animal_id'],
      animalName: map['animal_name'],
      animalDetails: map['animal_description'],
      animalImage: map['animal_image'],
    );
  }
}

List favourite=[];
List markAsRead = [];
