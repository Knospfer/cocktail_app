import 'package:cocktail_app/_shared/widgets/staggered_sliver_list/staggered_sliver_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///This widget adds item to its lisy asynchronously.
///To do so, use [GlobalKey<StaggeredSliverListState>()]
///to call [addItemsStaggered] method from anywhere.
class StaggeredSliverList<T> extends StatefulWidget {
  final Widget Function(T item) builder;

  const StaggeredSliverList({Key? key, required this.builder})
      : super(key: key);

  @override
  State<StaggeredSliverList<T>> createState() => StaggeredSliverListState<T>();
}

class StaggeredSliverListState<T> extends State<StaggeredSliverList<T>> {
  final _key = GlobalKey<SliverAnimatedListState>();

  final List<T> _items = [];
  int _sliverIndex = 0;

  void addItemsStaggered(List<T> incomingItems) {
    Future.forEach(incomingItems, (item) async {
      if (_sliverIndex > 0) {
        await Future.delayed(const Duration(milliseconds: 200));
      }

      _items.add(item as T);
      _key.currentState?.insertItem(
        _sliverIndex,
        duration: const Duration(milliseconds: 300),
      );
      _sliverIndex++;
    });
  }

  void removeItem(T item) {
    if (_sliverIndex - 1 > 0) {
      _sliverIndex--;
      _key.currentState?.removeItem(
        _sliverIndex,
        (context, animation) {
          final item = _items[_sliverIndex];

          return StaggereSliverListItem(
            child: widget.builder(item),
            animation: animation,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
      key: _key,
      itemBuilder: (context, index, animation) {
        final item = _items[index];

        if (item != null) {
          return StaggereSliverListItem(
            child: widget.builder(item),
            animation: animation,
          );
        }

        return const SliverToBoxAdapter(
            child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ));
      },
    );
  }
}
