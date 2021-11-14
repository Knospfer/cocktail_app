import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:cocktail_app/_core/enums/alcohol_presence.dart';
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
  const SearchBottomSheet({Key? key, required this.filter}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  final _controller = TextEditingController();
  AlcoholPresence _alcoholPresence = AlcoholPresence.present;

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
  }) =>
      fetchViewModel<SearchBottomSheetViewModel>(context).updateFilter(
        name: name,
        category: category,
        alcoholPresence: alcoholPresence,
        ingredients: ingredients,
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
                const Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorPalette.white,
                  ),
                ),
                const VerticalPadding(padding: 10),
                CupertinoTextField(
                  placeholder: "Margarita..",
                  controller: _controller,
                  cursorColor: ColorPalette.black,
                  onSubmitted: (_) {
                    final name = _controller.text;
                    _updateFilterState(name: name);
                  },
                ),
                const VerticalPadding(padding: 20),
                const Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorPalette.white,
                  ),
                ),
                const VerticalPadding(padding: 10),
              ],
            ),
          ),
        ),
        SliverListChipHorizonalSelectable(
          items: widget.filter.categories.map((e) => ChipItem(e)).toList(),
          singleSlectionEnabled: true,
          onSelection: (items) {
            _updateFilterState(category: items.first);
          },
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
        const SliverToBoxAdapter(
          child: Padding(
            child: Text(
              "Ingredients",
              style: TextStyle(
                fontSize: 18,
                color: ColorPalette.white,
              ),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
          ),
        ),
        SliverListChipHorizonalSelectable(
          items: widget.filter.ingredients.map((e) => ChipItem(e)).toList(),
          onSelection: (items) {
            _updateFilterState(ingredients: items);
          },
        ),
        const SliverToBoxAdapter(
          child: Padding(
            child: Text(
              "Alcohol?",
              style: TextStyle(
                fontSize: 18,
                color: ColorPalette.white,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          ),
        ),
        SliverToBoxAdapter(
          child: AlcoholPresenceRadioGroup(
            groupValue: _alcoholPresence,
            onChanged: _updateRadioState,
          ),
        )
      ],
    );
  }
}
