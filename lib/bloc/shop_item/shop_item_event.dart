import 'package:equatable/equatable.dart';

abstract class ShopItemEvent extends Equatable {
  const ShopItemEvent();

  @override
  List<Object> get props => [];
}

class LoadShopItemList extends ShopItemEvent {}

class UpdateShopItemByCategory extends ShopItemEvent {
  final String selectedCategory;

  const UpdateShopItemByCategory({required this.selectedCategory});
}