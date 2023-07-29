// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    MyHomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MyHomePage(),
      );
    },
    ItemDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ItemDetailRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ItemDetailPage(
          key: args.key,
          item: args.item,
        ),
      );
    },
  };
}

/// generated route for
/// [MyHomePage]
class MyHomeRoute extends PageRouteInfo<void> {
  const MyHomeRoute({List<PageRouteInfo>? children})
      : super(
          MyHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyHomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ItemDetailPage]
class ItemDetailRoute extends PageRouteInfo<ItemDetailRouteArgs> {
  ItemDetailRoute({
    Key? key,
    required ShopItem item,
    List<PageRouteInfo>? children,
  }) : super(
          ItemDetailRoute.name,
          args: ItemDetailRouteArgs(
            key: key,
            item: item,
          ),
          initialChildren: children,
        );

  static const String name = 'ItemDetailRoute';

  static const PageInfo<ItemDetailRouteArgs> page =
      PageInfo<ItemDetailRouteArgs>(name);
}

class ItemDetailRouteArgs {
  const ItemDetailRouteArgs({
    this.key,
    required this.item,
  });

  final Key? key;

  final ShopItem item;

  @override
  String toString() {
    return 'ItemDetailRouteArgs{key: $key, item: $item}';
  }
}
