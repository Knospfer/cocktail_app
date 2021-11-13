import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverChipGridHorizontal extends StatelessWidget {
  final List<String> items;
  final int rows;
  const SliverChipGridHorizontal({
    Key? key,
    required this.items,
    this.rows = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 30.0,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: items
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(e),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
