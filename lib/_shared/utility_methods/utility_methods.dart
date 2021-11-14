import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

T fetchViewModel<T>(BuildContext context) => Provider.of<T>(context, listen: false);
