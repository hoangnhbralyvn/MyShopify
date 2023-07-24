import 'package:dio/dio.dart';

final dio = Dio();

class ShopItem {
  final int id;
  final String title;
  final num price;
  final String category;
  final String image;
  final Rating rating;

  const ShopItem({
    this.id = 0,
    this.title = "",
    this.price = 0,
    this.category = "",
    this.image = "",
    this.rating = const Rating()
  });

  factory ShopItem.fromJson(Map<String, dynamic> json) => ShopItem(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    category: json["category"],
    image: json["image"],
  );
}

class Rating {
  final num rate;
  final num count;

  const Rating({this.rate = 0, this.count = 0});

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rate: json["rate"],
    count: json["count"],
  );
}

abstract class ShopDataSource {
  Future<List<ShopItem>> getShopItemList();
}

class RemoteShopDataSource implements ShopDataSource {
  @override
  Future<List<ShopItem>> getShopItemList() async {
    try {
      Response response = await dio.get("https://fakestoreapi.com/products");
      return (response.data as List)
                .map((item) => ShopItem.fromJson(item))
                .toList();
    } catch (err) {
      throw Exception("$err");
    }
  }
}