import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverListChipHorizonalSelectable extends StatefulWidget {
  final List<String> items;
  final void Function(List<String> items) onSelection;

  const SliverListChipHorizonalSelectable({
    Key? key,
    required this.items,
    required this.onSelection,
  }) : super(key: key);

  @override
  State<SliverListChipHorizonalSelectable> createState() =>
      _SliverListChipHorizonalSelectableState();
}

class _SliverListChipHorizonalSelectableState
    extends State<SliverListChipHorizonalSelectable> {
  late Map<String, bool> itemMap;

  @override
  void initState() {
    super.initState();
    itemMap = widget.items.asMap().map((key, value) => MapEntry(value, false));
  }

  void _select(String item) {
    final oldValue = itemMap[item];
    if (oldValue == null) return;

    _updateMapState(item, oldValue);

    widget.onSelection([item]);
  }

  void _updateMapState(String item, bool oldValue) {
    itemMap = itemMap.map((key, value) => MapEntry(key, false));
    setState(() {
      itemMap[item] = !oldValue;
    });
  }

  Color _backgroundColor(String item) => itemMap[item] != null && itemMap[item]!
      ? ColorPalette.deepRed
      : ColorPalette.white;

  Color _textColor(String item) => itemMap[item] != null && itemMap[item]!
      ? ColorPalette.white
      : ColorPalette.black;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 30.0,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: widget.items
              .map(
                (item) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () => _select(item),
                    child: Chip(
                      backgroundColor: _backgroundColor(item),
                      label: Text(
                        item,
                        style: TextStyle(color: _textColor(item)),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
