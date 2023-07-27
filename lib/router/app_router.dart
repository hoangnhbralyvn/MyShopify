import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import '../main.dart';
import '../model/shop_item.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    /// routes go here
    AutoRoute(page: MyHomeRoute.page, initial: true),
    AutoRoute(page: ItemDetailRoute.page)
  ];
}