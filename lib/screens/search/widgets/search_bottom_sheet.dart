import 'package:cocktail_app/_core/enums/alcohol_presence.dart';
import 'package:cocktail_app/_domain/filter/filter_entities.dart';
import 'package:cocktail_app/_shared/widgets/utility/paddings.dart';
import 'package:cocktail_app/screens/search/widgets/alcohol_presence_radio_group/alcohol_presence_radio_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBottomSheet extends StatefulWidget {
  final FilterDataEntity filter;
  const SearchBottomSheet({Key? key, required this.filter}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchBottomSheetState();
}

class _SearchBottomSheetState extends State<SearchBottomSheet> {
  AlcoholPresence _alcoholPresence = AlcoholPresence.present;

  void _updateRadioState(AlcoholPresence? value) {
    if (value == null) return;
    setState(() {
      _alcoholPresence = value;
    });
  }

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
              children: const [
                Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                VerticalPadding(padding: 10),
                CupertinoTextField(placeholder: "Margarita.."),
                VerticalPadding(padding: 20),
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                VerticalPadding(padding: 10),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 30,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: widget.filter.categories
                  .map((e) => Chip(label: Text(e)))
                  .toList(),
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
        const SliverToBoxAdapter(
          child: Padding(
            child: Text(
              "Ingredients",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 30,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: widget.filter.ingredients
                  .map((e) => Chip(label: Text(e)))
                  .toList(),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            child: Text(
              "Alcohol?",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
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
