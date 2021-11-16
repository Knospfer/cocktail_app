import 'package:cocktail_app/_shared/utility_methods/utility_methods.dart';
import 'package:cocktail_app/_shared/widgets/main_screen_scaffold/view_model/main_screen_scaffold_view_model.dart';
import 'package:flutter/cupertino.dart';

showLoading(BuildContext context) =>
    fetchViewModel<MainScreenScaffoldViewModel>(context).setLoadingState(true);

dismissLoading(BuildContext context) =>
    fetchViewModel<MainScreenScaffoldViewModel>(context).setLoadingState(false);
