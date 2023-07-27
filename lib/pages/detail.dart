import 'package:flutter/material.dart';
import '../model/shop_item.dart';

class ShopItemDetail extends StatelessWidget {
  final ShopItem item;

  const ShopItemDetail({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Center(
                  child: Hero(
                    tag: "tag${item.id}",
                    child: Image.network(
                      item.image,
                      fit: BoxFit.scaleDown,
                    )),
                ),
              )
            ),
            const SizedBox(height: 20),
            Divider(
              color: Colors.grey[300],
              thickness: 1.0,
            ),
            Flexible(flex: 5, child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  item.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[800]
                  ),
                )
              ],
            ),
            ))
          ],
        ));
  }
}
