import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:my_shopify/main.dart';
import '../model/category.dart';
import '../model/shop_item.dart';

class CategoryHorizontalList extends StatelessWidget {
  final Function onCategorySelected;
  final List<Category> categoryList;

  const CategoryHorizontalList({
    super.key,
    required this.onCategorySelected,
    required this.categoryList
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: 50,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, position) => Container(
              height: 50,
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: GestureDetector(
                  onTap: () => onCategorySelected(categoryList[position].name),
                  child: Center(
                      child: Text(
                        categoryList[position].name.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: categoryList[position].isSelected
                            ? Colors.amber
                            : Colors.white
                        ),
                      )
                  )
              )
          )
      ),
    );
  }
}

class ShopItemList extends StatelessWidget {
  final List<ShopItem> items;

  const ShopItemList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: List.generate(
            items.length, (index) => ShopItemTile(item: items[index])),
      ),
    );
  }
}

class ShopItemTile extends StatelessWidget {
  final ShopItem item;

  const ShopItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Route route =
            MaterialPageRoute(builder: (context) => ItemDetailPage(item: item));
        Navigator.push(context, route);
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: const Offset(0, 2),
                  blurRadius: 10)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
                flex: 4,
                child: Center(
                  child: Hero(
                      tag: "tag${item.id}",
                      child: Image.network(
                        item.image,
                        fit: BoxFit.scaleDown,
                      )),
                )),
            const SizedBox(height: 10),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      RatingBarIndicator(
                        rating: item.rating.rate.toDouble(),
                        itemBuilder: (context, index) =>
                            const Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 16,
                      ),
                      Text(
                        "\$${item.price}",
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
