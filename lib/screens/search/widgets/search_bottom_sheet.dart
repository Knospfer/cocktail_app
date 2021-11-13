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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("Name"),
              CupertinoTextField(placeholder: "Margarita.."),
              VerticalPadding(padding: 20),
              Text("Categories"),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 30,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widget.filter.categories
                  .map((e) => Chip(label: Text(e)))
                  .toList(),
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
        const SliverToBoxAdapter(child: const Text("Ingredients")),
        // SliverToBoxAdapter(
        //   child: ListView(
        //     scrollDirection: Axis.horizontal,
        //     children: widget.filter.ingredients
        //         .map((e) => Chip(label: Text(e)))
        //         .toList(),
        //   ),
        // ),
        const SliverToBoxAdapter(child: const Text("Alcohol?")),
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
