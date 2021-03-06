import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:cocktail_app/_core/enums/alcohol_presence.dart';
import 'package:cocktail_app/_core/theme/text_styles/text_styles.dart';
import 'package:cocktail_app/_domain/filter/filter_entities.dart';
import 'package:cocktail_app/_shared/utility_methods/utility_methods.dart';
import 'package:cocktail_app/_shared/widgets/utility/paddings.dart';
import 'package:cocktail_app/screens/search/view_model/search_bottom_sheet_view_model.dart';
import 'package:cocktail_app/screens/search/widgets/alcohol_presence_radio_group/alcohol_presence_radio_group.dart';
import 'package:cocktail_app/screens/search/widgets/sliver_list_chip_horizontal_selectable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBottomSheet extends StatefulWidget {
  final FilterDataEntity filter;
  final bool showRangeSelection;

  const SearchBottomSheet({
    Key? key,
    required this.filter,
    this.showRangeSelection = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  final _controller = TextEditingController();
  AlcoholPresence _alcoholPresence = AlcoholPresence.present;

  double _sliderValue = 25;
  String get _sliderLabel =>
      _sliderValue < 25 ? "${_sliderValue.toInt()}" : "MAX (may be slow)";

  void _updateRadioState(AlcoholPresence? value) {
    if (value == null) return;
    setState(() {
      _alcoholPresence = value;
    });
    _updateFilterState(alcoholPresence: _alcoholPresence);
  }

  void _updateFilterState({
    String? name,
    String? category,
    AlcoholPresence? alcoholPresence,
    List<String>? ingredients,
    int? itemPerSearch,
  }) =>
      fetchViewModel<SearchBottomSheetViewModel>(context).updateFilter(
        name: name,
        category: category,
        alcoholPresence: alcoholPresence,
        ingredients: ingredients,
        itemPerSearch: itemPerSearch,
      );

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalPadding(padding: 10),
                const Text(
                  "Name",
                  style: SmallTextStyle(),
                ),
                const VerticalPadding(padding: 10),
                CupertinoTextField(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ColorPalette.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  placeholder: "Margarita..",
                  controller: _controller,
                  cursorColor: ColorPalette.black,
                  onChanged: (_) {
                    final name = _controller.text;
                    _updateFilterState(name: name);
                  },
                  onSubmitted: (_) {
                    final name = _controller.text;
                    _updateFilterState(name: name);
                    final filter =
                        fetchViewModel<SearchBottomSheetViewModel>(context)
                            .filter;
                    Navigator.pop(context, filter);
                  },
                ),
                const VerticalPadding(padding: 30),
                const Divider(color: ColorPalette.white),
                const VerticalPadding(padding: 10),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Advanced Search",
                    style: const ExtraSmallTextStyle().copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const VerticalPadding(padding: 10),
                const Text(
                  "Category",
                  style: SmallTextStyle(),
                ),
                const VerticalPadding(padding: 10),
              ],
            ),
          ),
        ),
        SliverListChipHorizonalSelectable(
          items: widget.filter.categories,
          onSelection: (items) {
            _updateFilterState(category: items.first);
          },
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
        const SliverToBoxAdapter(
          child: Padding(
            child: Text("Ingredient", style: SmallTextStyle()),
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
          ),
        ),
        SliverListChipHorizonalSelectable(
          items: widget.filter.ingredients,
          onSelection: (items) {
            _updateFilterState(ingredients: items);
          },
        ),
        const SliverToBoxAdapter(
          child: Padding(
            child: Text("Alcohol?", style: SmallTextStyle()),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          ),
        ),
        SliverToBoxAdapter(
          child: AlcoholPresenceRadioGroup(
            groupValue: _alcoholPresence,
            onChanged: _updateRadioState,
          ),
        ),
        if (widget.showRangeSelection)
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 20,
                    bottom: 10,
                  ),
                  child: FittedBox(
                    child: Text(
                      "Cocktail per Search: $_sliderLabel",
                      style: const SmallTextStyle(),
                    ),
                  ),
                ),
                Slider(
                  thumbColor: ColorPalette.white,
                  value: _sliderValue,
                  min: 0,
                  max: 25,
                  label: _sliderLabel,
                  divisions: 5,
                  onChanged: (value) {
                    if (value >= 5) {
                      setState(() {
                        _sliderValue = value;
                      });
                      _updateFilterState(itemPerSearch: _sliderValue.toInt());
                    }
                  },
                ),
                const VerticalPadding(padding: 20),
              ],
            ),
          )
      ],
    );
  }
}
