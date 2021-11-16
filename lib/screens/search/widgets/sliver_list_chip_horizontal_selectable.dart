import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChipItem {
  final String value;
  bool selected = false;

  ChipItem(this.value);
}

class SliverListChipHorizonalSelectable extends StatefulWidget {
  final List<ChipItem> items;
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
  ChipItem? singleSelectionModeItem;

  void _select(ChipItem item) {
    item.selected = !item.selected;
    setState(() {
      singleSelectionModeItem = item.selected ? item : null;
    });
    widget.onSelection([item.value]);
  }

  Color _backgroundColor(ChipItem item) =>
      item.value == singleSelectionModeItem?.value
          ? ColorPalette.deepRed
          : ColorPalette.white;

  Color _textColor(ChipItem item) =>
      item.value == singleSelectionModeItem?.value
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
                (e) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () => _select(e),
                    child: Chip(
                      backgroundColor: _backgroundColor(e),
                      label: Text(
                        e.value,
                        style: TextStyle(color: _textColor(e)),
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
