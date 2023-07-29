import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_shopify/bloc/shop_item/shop_item_event.dart';
import 'package:my_shopify/bloc/shop_item/shop_item_state.dart';
import '../../repository/shop_repository.dart';

class ShopItemBloc extends Bloc<ShopItemEvent, ShopItemState> {
  final ShopDataSource repository;

  ShopItemBloc({required this.repository}) : super(ShopItemInitial()) {
    on<LoadShopItemList>(
      (event, emit) async {
        try {
          final itemList = await repository.getShopItemList();
          emit(ShopItemLoaded(
              items: itemList,
              selectCategory: itemList[0].category
          ));
        } catch (ex) {
          emit(ShopItemError(exception: ex as Exception));
        }
      },
    );
    on<UpdateShopItemByCategory>((event, emit) {
      if (state is ShopItemLoaded) {
        final state = this.state as ShopItemLoaded;
        final category = event.selectedCategory;
        emit(ShopItemLoaded(
            items: state.items,
            selectCategory: category
        ));
      }
    });
  }
}