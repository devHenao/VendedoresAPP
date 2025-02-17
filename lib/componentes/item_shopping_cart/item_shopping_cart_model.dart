import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:ui';
import 'item_shopping_cart_widget.dart' show ItemShoppingCartWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ItemShoppingCartModel extends FlutterFlowModel<ItemShoppingCartWidget> {
  ///  Local state fields for this component.

  double? contador = 1.0;

  ///  State fields for stateful widgets in this component.

  // State field(s) for amountCart widget.
  FocusNode? amountCartFocusNode;
  TextEditingController? amountCartTextController;
  String? Function(BuildContext, String?)? amountCartTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    amountCartFocusNode?.dispose();
    amountCartTextController?.dispose();
  }
}
