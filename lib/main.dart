import 'package:flutter/material.dart';
import 'package:my_shopify/repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Shopify'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: const Column(
        children: [
          CategoryHorizontalList()
        ],
      ),
    );
  }
}

class CategoryHorizontalList extends StatefulWidget {

  const CategoryHorizontalList({super.key});

  @override
  CategoryListState createState() => CategoryListState();
}

class CategoryListState extends State<CategoryHorizontalList> {

  List<String> categoryList = List.empty();
  final repository = RemoteShopDataSource();

  @override
  void initState() {
    super.initState();
    repository.getShopItemList().then((itemList) =>
      setData(itemList)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text("$categoryList");
  }

  void setData(List<ShopItem> list) {
    setState(() {
      categoryList = list.map((e) => e.category).toSet().toList();
    });
  }
}
