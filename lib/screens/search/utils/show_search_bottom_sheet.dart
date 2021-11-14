import 'package:cocktail_app/_domain/filter/filter_entities.dart';
import 'package:cocktail_app/dependency_injection.dart';
import 'package:cocktail_app/screens/search/screen/search_bottom_sheet_screen.dart';
import 'package:cocktail_app/screens/search/view_model/search_bottom_sheet_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<ApllyingFilterEntity> showSearchBottomSheet(
        BuildContext context) async =>
    await showModalBottomSheet(
      isDismissible: false,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) => ChangeNotifierProvider(
        create: (_) => getIt<SearchBottomSheetViewModel>(),
        child: const SearchBottomSheetScreen(),
      ),
    );
