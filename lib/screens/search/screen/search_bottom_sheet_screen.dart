import 'package:cocktail_app/_shared/utility_methods/utility_methods.dart';
import 'package:cocktail_app/screens/search/view_model/search_bottom_sheet_view_model.dart';
import 'package:cocktail_app/screens/search/widgets/search_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBottomSheetScreen extends StatefulWidget {
  const SearchBottomSheetScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBottomSheetScreen> createState() =>
      _SearchBottomSheetScreenState();
}

class _SearchBottomSheetScreenState extends State<SearchBottomSheetScreen> {
  @override
  void initState() {
    fetchViewModel<SearchBottomSheetViewModel>(context).createSearchFilter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text("Search"),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  final viewModel =
                      fetchViewModel<SearchBottomSheetViewModel>(context);
                  viewModel.updateFilter();
                  Navigator.pop(context, viewModel.filter);
                },
                icon: const Icon(Icons.search),
              )
            ],
          ),
          body: Consumer<SearchBottomSheetViewModel>(
            builder: (context, viewModel, child) {
              final filter = viewModel.filterData;

              if (filter == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SearchBottomSheet(filter: filter);
            },
          ),
        ),
      ),
    );
  }
}
