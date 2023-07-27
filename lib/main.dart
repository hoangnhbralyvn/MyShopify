import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shopify/bloc/shop_item/shop_item_bloc.dart';
import 'package:my_shopify/bloc/shop_item/shop_item_event.dart';
import 'package:my_shopify/pages/list.dart';
import 'package:my_shopify/pages/detail.dart';
import 'package:my_shopify/model/shop_item.dart';
import 'package:my_shopify/model/category.dart';
import 'package:my_shopify/repository/shop_repository.dart';

import 'bloc/shop_item/shop_item_state.dart';
import 'di/injection.dart';

void main() async {
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final repository = injector.get<ShopDataSource>();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) {
                  return ShopItemBloc(repository: repository)
                    ..add(LoadShopItemList());
                }
            )
          ],
          child: const MyHomePage()
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

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
      body: SafeArea(
        child: BlocBuilder<ShopItemBloc, ShopItemState>(
          builder: (context, state) {
            if (state is ShopItemInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ShopItemLoaded) {

              final totalItems = state.items;
              final selectedCategory = state.selectCategory;

              return Column(
                    children: [
                      CategoryHorizontalList(
                        categoryList: getCategories(totalItems, selectedCategory),
                        onCategorySelected: (category) {
                          context.read<ShopItemBloc>().add(UpdateShopItemByCategory(selectedCategory: category));
                        }
                      ),
                      Expanded(
                          child: ShopItemList(
                              items: getItemsByCategory(totalItems, selectedCategory)
                          )
                      )
                    ],
                  );
            } else {
              return const Center(child: Text('something went wrong'));
            }
          },
        )
      )
    );
  }
}

class ItemDetailPage extends StatelessWidget {
  final ShopItem item;

  const ItemDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back, color: Colors.black)),
        backgroundColor: Colors.white,
        title: const Text("My Shopify"),
      ),
      body: ShopItemDetail(item: item),
    );
  }
}
