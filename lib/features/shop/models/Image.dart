// class ImageDTO {
//   final int id;
//   final String imgPath;

//   ImageDTO({
//     required this.id,
//     required this.imgPath,
//   });

//   factory ImageDTO.fromJson(Map<String, dynamic> json) {
//     return ImageDTO(
//       id: json['id'],
//       imgPath: json['imgPath'],
//     );
//   }
// }
class Image {
  final int? id;
  final String imgPath;

  Image({
    this.id,
    required this.imgPath,
  });

  // Factory constructor for creating an instance from a JSON map
  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      id: json['id'] ?? 0,
      imgPath: json['imgPath'] ?? '',
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imgPath': imgPath,
    };
  }
}
