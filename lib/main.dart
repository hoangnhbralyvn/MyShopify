import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:my_shopify/pages/list.dart';
import 'package:my_shopify/pages/detail.dart';
import 'package:my_shopify/model/shop_item.dart';
import 'package:my_shopify/model/category.dart';
import 'package:my_shopify/repository/shop_repository.dart';

import 'di/injection.dart';

void main() async {
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<ShopItem> items = List.empty();
  List<ShopItem> itemsByCategory = List.empty();
  List<Category> categoryList = List.empty();

  final repository = injector.get<ShopDataSource>();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    repository.getShopItemList().then((itemList) => _getShopItemList(itemList));
  }

  //initial states
  void _getShopItemList(List<ShopItem> itemList) {
    setState(() {
      items = itemList;
      categoryList = getCategories(items);
      itemsByCategory = getItemsByCategory(categoryList[0]);
      isLoading = false;
    });
  }

  List<ShopItem> getItemsByCategory(Category category) {
    return items.where((element) => element.category == category.name).toList();
  }

  void setSelectCategory(Category selectedCategory) {
    final updatedCategories = categoryList
        .map((category) => Category(
            name: category.name,
            isSelected: category.name == selectedCategory.name))
        .toList();
    final updatedItemsByCategory = getItemsByCategory(selectedCategory);
    setState(() {
      categoryList = updatedCategories;
      itemsByCategory = updatedItemsByCategory;
    });
  }

  List<Category> getCategories(List<ShopItem> itemList) {
    final categoryNames =
        itemList.map((item) => item.category).toSet().toList();
    return categoryNames
        .mapIndexed(
            (index, element) => Category(name: element, isSelected: index == 0))
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
      body: isLoading ? const Center(child: CircularProgressIndicator()) : ShopList(
          items: items,
          categoryList: categoryList,
          childWidget: Column(
            children: [
              CategoryHorizontalList(onCategorySelected: setSelectCategory),
              Expanded(child: ShopItemList(items: itemsByCategory))
            ],
          )),
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
