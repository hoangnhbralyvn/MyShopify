part of 'shop_item_cubit.dart';

@immutable
abstract class ShopItemState extends Equatable {
  const ShopItemState();
}

class ShopItemInitial extends ShopItemState {
  @override
  List<Object?> get props => [];
}

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

  @override
  List<Object?> get props => [exception];
}