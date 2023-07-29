import 'package:equatable/equatable.dart';
import '../../model/shop_item.dart';

abstract class ShopItemState extends Equatable {
  const ShopItemState();

  @override
  List<Object> get props => [];
}

class ShopItemInitial extends ShopItemState {}

class ShopItemLoaded extends ShopItemState {
  final List<ShopItem> items;
  final String selectCategory;

  const ShopItemLoaded({required this.items, required this.selectCategory});

  @override
  List<Object> get props => [items, selectCategory];
}

class ShopItemError extends ShopItemState {
  final Exception exception;

  const ShopItemError({required this.exception});
}