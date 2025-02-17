import 'package:app_vendedores/backend/api_requests/_/api_manager.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/componentes/recovery_password/recovery_password_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'dart:ui';
import 'login_widget.dart' show LoginWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginModel extends FlutterFlowModel<LoginWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for nit widget.
  FocusNode? nitFocusNode;
  TextEditingController? nitTextController;
  String? Function(BuildContext, String?)? nitTextControllerValidator;
  String? _nitTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Debe ingresar el Nit de su empresa';
    }

    return null;
  }

  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  String? _passwordTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Debe ingresar la contraseña';
    }

    if (val.length < 3) {
      return 'La contraseña debe ser de al menos 6 carácteres';
    }

    return null;
  }

  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // Stores action output result for [Backend Call - API (loginSeller)] action in btnLogin widget.
  ApiCallResponse? apiResultLogin;

  @override
  void initState(BuildContext context) {
    nitTextControllerValidator = _nitTextControllerValidator;
    passwordVisibility = false;
    passwordTextControllerValidator = _passwordTextControllerValidator;
  }

  @override
  void dispose() {
    nitFocusNode?.dispose();
    nitTextController?.dispose();

    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();
  }
}
