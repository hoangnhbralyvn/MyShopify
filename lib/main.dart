import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shopify/cubit/shop_item_cubit.dart';
import 'package:my_shopify/pages/list.dart';
import 'package:my_shopify/pages/detail.dart';
import 'package:my_shopify/model/shop_item.dart';
import 'package:my_shopify/model/category.dart';
import 'package:my_shopify/repository/shop_repository.dart';
import 'package:my_shopify/router/app_router.dart';
import 'di/injection.dart';

void main() async {
  await configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      routerDelegate: AutoRouterDelegate(
        appRouter,
        navigatorObservers: () => [AutoRouteObserver()],
      ),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}

@RoutePage()
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  final repository = injector.get<ShopDataSource>();

  List<ShopItem> getItemsByCategory(List<ShopItem> items, String category) {
    return items.where((element) => element.category == category).toList();
  }

  List<Category> getCategories(List<ShopItem> itemList, String selectedCategory) {
    final categoryNames =
        itemList.map((item) => item.category).toSet().toList();
    return categoryNames
        .map((element) => Category(name: element, isSelected: element == selectedCategory))
        .toList();
  }

  MyHomePageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("My Shopify"),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) => ShopItemCubit(repository: repository),
          child: BlocBuilder<ShopItemCubit, ShopItemState>(
            builder: (context, state) {
              if (state is ShopItemInitial) {
                context.read<ShopItemCubit>().loadShopItems();
                return const Center(child: CircularProgressIndicator());
              } else if (state is ShopItemLoaded) {

                final totalItems = state.items;
                final selectedCategory = state.selectCategory;

                return SafeArea(
                  child: Column(
                    children: [
                      CategoryHorizontalList(
                          categoryList: getCategories(totalItems, selectedCategory)
                      ),
                      Expanded(
                          child: ShopItemList(
                              items: getItemsByCategory(totalItems, selectedCategory)
                          )
                      )
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('something went wrong'));
              }
            },
          ),
        )
    );
  }
}

@RoutePage()
class ItemDetailPage extends StatelessWidget {
  final ShopItem item;

  const ItemDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => AutoRouter.of(context).pop(),
            icon: const Icon(Icons.arrow_back, color: Colors.black)),
        backgroundColor: Colors.white,
        title: const Text("My Shopify"),
      ),
      body: ShopItemDetail(item: item),
    );
  }
}
