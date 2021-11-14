import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:cocktail_app/_shared/widgets/staggered_sliver_list/staggered_sliver_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///This widget adds item to its lisy asynchronously.
///To do so, use [GlobalKey<StaggeredSliverListState>()]
///to call [addItemsStaggered] method from anywhere.
class StaggeredSliverList<T> extends StatefulWidget {
  final Widget Function(int index, T item) builder;

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

  void removeItem(int index, T item) {
    if (_sliverIndex - 1 >= 0) {
      _key.currentState?.removeItem(
        index,
        (context, animation) {
          _items.removeAt(index);

          return StaggereSliverListItem(
            child: widget.builder(index, item),
            animation: animation,
          );
        },
      );
    }
  }

  void emptyList() {
    for (int i = 0; i <= _items.length - 1; i++) {
      _key.currentState?.removeItem(0,
          (BuildContext context, Animation<double> animation) {
        return StaggereSliverListItem(
          child: Container(color: Colors.grey),
          animation: animation,
        );
      });
    }
    _items.clear();
    _sliverIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SliverAnimatedList(
      key: _key,
      itemBuilder: (context, index, animation) {
        final item = _items.elementAt(index);

        if (item != null) {
          return Padding(
            padding: index == _items.length - 1
                ? const EdgeInsets.only(bottom: 80)
                : EdgeInsets.zero,
            child: StaggereSliverListItem(
              child: widget.builder(index, item),
              animation: animation,
            ),
          );
        }

        return const SliverToBoxAdapter(
            child: Center(
          child: CircularProgressIndicator(
            color: ColorPalette.white,
          ),
        ));
      },
    );
  }
}
