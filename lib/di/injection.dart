import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:my_shopify/repository/shop_repository.dart';
import 'injection.config.dart';

final GetIt injector = GetIt.I;

@InjectableInit()
Future<void> configureDependencies() async {
  injector.init();
}

@module
abstract class NetworkModule {
  Dio get dio => Dio();
}

void _registerNetworkModule() {
  injector.registerLazySingleton<Dio>(() => Dio());
}

void _registerRepositoryModule() {
  injector.registerLazySingleton<ShopDataSource>(() => RemoteShopDataSource(injector.get<Dio>()));
}