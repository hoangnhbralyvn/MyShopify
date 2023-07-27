import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_shopify/model/shop_item.dart';

abstract class ShopDataSource {
  Future<List<ShopItem>> getShopItemList();
}

@Injectable(as: ShopDataSource)
class RemoteShopDataSource implements ShopDataSource {

  final Dio _dio;

  RemoteShopDataSource(this._dio);

  @override
  Future<List<ShopItem>> getShopItemList() async {
    try {
      Response response = await _dio.get("https://fakestoreapi.com/products");
      return (response.data as List)
                .map((item) => ShopItem.fromJson(item))
                .toList();
    } catch (err) {
      throw Exception("$err");
    }
  }
}