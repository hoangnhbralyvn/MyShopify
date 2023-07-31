import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../model/shop_item.dart';
import '../repository/shop_repository.dart';

part 'shop_item_state.dart';

class ShopItemCubit extends Cubit<ShopItemState> {
  ShopItemCubit({required this.repository}) : super(ShopItemInitial());

  final ShopDataSource repository;

  void loadShopItems() async {
    try {
      final itemList = await repository.getShopItemList();
      emit(ShopItemLoaded(
          items: itemList,
          selectCategory: itemList[0].category
      ));
    } catch (ex) {
      emit(ShopItemError(exception: ex as Exception));
    }
  }

  void updateShopCategory(String category) {
    if (state is ShopItemLoaded) {
      final state = this.state as ShopItemLoaded;
      emit(ShopItemLoaded(
          items: state.items,
          selectCategory: category
      ));
    }
  }
}
