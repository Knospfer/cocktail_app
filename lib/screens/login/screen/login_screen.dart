import 'package:cocktail_app/_core/colors/color_palette.dart';
import 'package:cocktail_app/_core/routes/routes.dart';
import 'package:cocktail_app/_core/theme/text_styles/text_styles.dart';
import 'package:cocktail_app/_shared/utility_methods/utility_methods.dart';
import 'package:cocktail_app/_shared/widgets/utility/paddings.dart';
import 'package:cocktail_app/screens/login/view_model/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
 const LoginScreen({Key? key}) : super(key: key);

  Future<void> _authenticate(BuildContext context) async {
    final authenticated =
        await fetchViewModel<LoginViewModel>(context).authenticate();
    if (authenticated) {
      Navigator.pushReplacementNamed(context, Routes.root);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("login_image.jpg"),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(30),
            color: ColorPalette.black.withAlpha(100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome to\nCocktailz!",
                  style: ExtarLargeTextStyle(),
                ),
                const VerticalPadding(padding: 30),
                const Expanded(flex: 2, child: SizedBox()),
                Expanded(
                  child: Center(
                    child: CupertinoButton.filled(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      onPressed: () {
                        _authenticate(context);
                      },
                      child: const Text("Start"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
