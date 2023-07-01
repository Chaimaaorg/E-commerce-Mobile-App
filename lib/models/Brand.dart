import 'package:equatable/equatable.dart';

class Brand extends Equatable {
  final String imageUrl;

  const Brand({
    required this.imageUrl,
  });

  static List<Brand> Brands = [
    Brand(
      imageUrl:
      "assets/images/about.jpg",
    ),
    Brand(
      imageUrl:
      "assets/images/brands/Bosch.jpg",
    ),
    Brand(
      imageUrl:
      "assets/images/brands/Dynacord.jpg",
    ),
    Brand(
      imageUrl:
      "assets/images/brands/Alcad.jpg",
    ),
    Brand(
      imageUrl:
      "assets/images/brands/Electro_voice.jpg",
    ),
    Brand(
      imageUrl:
      "assets/images/brands/Finsecur.jpg",
    ),
    Brand(
      imageUrl:
      "assets/images/brands/Fracarro.jpg",
    ),
    Brand(
      imageUrl:
      "assets/images/brands/Hikvision.jpg",
    ),
    Brand(
      imageUrl:
      "assets/images/brands/Interm.jpg",
    ),
    Brand(
      imageUrl:
      "assets/images/brands/Lumens.jpg",
    ),
    Brand(
      imageUrl:
      "assets/images/brands/Omerin.jpg",
    ),
    Brand(
      imageUrl:
      "assets/images/brands/Panasonic.jpg",
    ),
    Brand(
      imageUrl:
      "assets/images/brands/Satel.jpg",
    ),
    Brand(
      imageUrl:
      "assets/images/brands/Unv.jpg",
    ),
  ];

  @override
  List<Object?> get props => [
    imageUrl,
  ];
}