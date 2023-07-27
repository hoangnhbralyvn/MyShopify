import 'rating.dart';

class ShopItem {
  final int id;
  final String title;
  final num price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  const ShopItem({
    this.id = 0,
    this.title = "",
    this.price = 0,
    this.description = "",
    this.category = "",
    this.image = "",
    this.rating = const Rating()
  });

  factory ShopItem.fromJson(Map<String, dynamic> json) => ShopItem(
      id: json["id"],
      title: json["title"],
      price: json["price"],
      description: json["description"],
      category: json["category"],
      image: json["image"],
      rating: Rating.fromJson(json["rating"])
  );
}