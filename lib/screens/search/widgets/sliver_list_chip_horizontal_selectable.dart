import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChipItem {
  final String value;
  bool selected = false;

  ChipItem(this.value);
}

///This widget shows an horizontal list of chips
///It has 2 selection mode: multiple (default) and single
///If multiple selection is enabled, onSelection will return a list of selected widget
///Otherwise it will return only the selected item
class SliverListChipHorizonalSelectable extends StatefulWidget {
  final List<ChipItem> items;
  final bool singleSlectionEnabled;
  final void Function(List<String> items) onSelection;

  const SliverListChipHorizonalSelectable({
    Key? key,
    required this.items,
    required this.onSelection,
    this.singleSlectionEnabled = false,
  }) : super(key: key);

  @override
  State<SliverListChipHorizonalSelectable> createState() =>
      _SliverListChipHorizonalSelectableState();
}

class _SliverListChipHorizonalSelectableState
    extends State<SliverListChipHorizonalSelectable> {
  ChipItem? singleSelectionModeItem;
  Map<String, bool> _multiSelectionModeItems = {};

  @override
  void initState() {
    _multiSelectionModeItems =
        widget.items.asMap().map((key, chip) => MapEntry(chip.value, false));
    super.initState();
  }

  void _select(ChipItem item) => widget.singleSlectionEnabled
      ? _singleSelectionSelect(item)
      : _multiSelectionSelect(item);

  void _multiSelectionSelect(ChipItem item) {
    setState(() {
      item.selected = !item.selected;
    });
    _multiSelectionModeItems.update(item.value, (_) => item.selected);
    final list = _populateResultList();
    widget.onSelection(list);
  }

  List<String> _populateResultList() {
    final List<String> list = [];
    _multiSelectionModeItems.forEach((key, value) {
      if (value) list.add(key);
    });
    return list;
  }

  void _singleSelectionSelect(ChipItem item) {
    item.selected = !item.selected;
    setState(() {
      singleSelectionModeItem = item.selected ? item : null;
    });
    widget.onSelection([item.value]);
  }

  bool _elementTrueOrNull(String element) =>
      _multiSelectionModeItems[element] != null &&
      _multiSelectionModeItems[element]!;

  Color _backgroundColor(ChipItem item) => widget.singleSlectionEnabled
      ? _singleSelectionBackground(item)
      : _multiSelecitonBackgroundColor(item);

  Color _singleSelectionBackground(ChipItem item) =>
      item.value == singleSelectionModeItem?.value
          ? ColorPalette.deepRed
          : ColorPalette.white;
  Color _multiSelecitonBackgroundColor(ChipItem item) =>
      _elementTrueOrNull(item.value)
          ? ColorPalette.deepRed
          : ColorPalette.white;

  Color _textColor(ChipItem item) => widget.singleSlectionEnabled
      ? _singleSelectionTextColor(item)
      : _multiSelecitonTextColor(item);

  Color _singleSelectionTextColor(ChipItem item) =>
      item.value == singleSelectionModeItem?.value
          ? ColorPalette.white
          : ColorPalette.black;

  Color _multiSelecitonTextColor(ChipItem item) =>
      _elementTrueOrNull(item.value) ? ColorPalette.white : ColorPalette.black;

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
