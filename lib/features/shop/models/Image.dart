class ImageDTO {
  final int id;
  final String imgPath;

  ImageDTO({
    required this.id,
    required this.imgPath,
  });

  factory ImageDTO.fromJson(Map<String, dynamic> json) {
    return ImageDTO(
      id: json['id'],
      imgPath: json['imgPath'],
    );
  }
}
