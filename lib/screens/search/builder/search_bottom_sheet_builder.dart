import 'package:cocktail_app/dependency_injection.dart';
import 'package:cocktail_app/screens/search/screen/search_bottom_sheet_screen.dart';
import 'package:cocktail_app/screens/search/view_model/search_bottom_sheet_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

///Use this widget to crate [SearchBottomSheetScreen] and provide its [ViewModel]
class SearchBottomSheetBuilder extends StatelessWidget {
  const SearchBottomSheetBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<SearchBottomSheetViewModel>(),
      child: const SearchBottomSheetScreen(),
    );
  }
}
