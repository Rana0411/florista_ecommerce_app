import 'package:florista_ecommerce_app/features/cart/domain/models/cart_item_entity.dart';
import 'package:florista_ecommerce_app/features/cart/presentation/view/widgets/cart_item_card.dart';
import 'package:flutter/material.dart';

class CartAnimatedItemsList extends StatefulWidget {
  const CartAnimatedItemsList({
    super.key,
    required this.items,
    required this.busyProductId,
    required this.isGlobalLoading,
    required this.onDelete,
    required this.onIncrement,
    required this.onDecrement,
  });

  final List<CartItemEntity> items;
  final String? busyProductId;
  final bool isGlobalLoading;
  final void Function(CartItemEntity item) onDelete;
  final void Function(CartItemEntity item) onIncrement;
  final void Function(CartItemEntity item) onDecrement;

  @override
  State<CartAnimatedItemsList> createState() => _CartAnimatedItemsListState();
}

class _CartAnimatedItemsListState extends State<CartAnimatedItemsList> {
  static const _animationDuration = Duration(milliseconds: 350);
  static const _animationCurve = Curves.easeInOutCubic;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<CartItemEntity> _displayedItems = [];

  @override
  void initState() {
    super.initState();
    _displayedItems.addAll(widget.items);
  }

  @override
  void didUpdateWidget(CartAnimatedItemsList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncItems(widget.items);
  }

  void _syncItems(List<CartItemEntity> nextItems) {
    final nextIds = nextItems.map((e) => e.product.productId).toList();
    final currentIds = _displayedItems.map((e) => e.product.productId).toList();

    for (var index = currentIds.length - 1; index >= 0; index--) {
      final id = currentIds[index];
      if (!nextIds.contains(id)) {
        final removedItem = _displayedItems.removeAt(index);
        _listKey.currentState?.removeItem(
          index,
          (context, animation) => _buildAnimatedCard(
            item: removedItem,
            animation: animation,
            isRemoving: true,
          ),
          duration: _animationDuration,
        );
      }
    }

    for (var index = 0; index < nextItems.length; index++) {
      final nextItem = nextItems[index];
      final id = nextItem.product.productId;
      final localIndex = _displayedItems.indexWhere(
        (item) => item.product.productId == id,
      );

      if (localIndex == -1) {
        _displayedItems.insert(index, nextItem);
        _listKey.currentState?.insertItem(
          index,
          duration: _animationDuration,
        );
        continue;
      }

      if (localIndex != index) {
        final moved = _displayedItems.removeAt(localIndex);
        _displayedItems.insert(index, moved);
        setState(() {});
      }

      _displayedItems[index] = nextItem;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      initialItemCount: _displayedItems.length,
      itemBuilder: (context, index, animation) {
        if (index >= _displayedItems.length) {
          return const SizedBox.shrink();
        }

        return _buildAnimatedCard(
          item: _displayedItems[index],
          animation: animation,
        );
      },
    );
  }

  Widget _buildAnimatedCard({
    required CartItemEntity item,
    required Animation<double> animation,
    bool isRemoving = false,
  }) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: _animationCurve,
      reverseCurve: _animationCurve,
    );

    return SizeTransition(
      sizeFactor: curved,
      axisAlignment: -1,
      child: FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: isRemoving ? Offset.zero : const Offset(0.08, 0),
            end: isRemoving ? const Offset(-0.25, 0) : Offset.zero,
          ).animate(curved),
          child: CartItemCard(
            key: ValueKey(item.product.productId),
            item: item,
            isBusy:
                widget.isGlobalLoading ||
                widget.busyProductId == item.product.productId,
            onDelete: () => widget.onDelete(item),
            onIncrement: () => widget.onIncrement(item),
            onDecrement: () => widget.onDecrement(item),
          ),
        ),
      ),
    );
  }
}
