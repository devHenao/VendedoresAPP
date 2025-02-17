import 'package:app_vendedores/backend/api_requests/_/api_manager.dart';

import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/componentes/item_shopping_cart/item_shopping_cart_widget.dart';
import '/componentes/mensajes/register_order/register_order_widget.dart';
import '/componentes/menu/menu_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'carrito_widget.dart' show CarritoWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CarritoModel extends FlutterFlowModel<CarritoWidget> {
  ///  Local state fields for this page.

  List<DetailProductStruct> listBodega = [];
  void addToListBodega(DetailProductStruct item) => listBodega.add(item);
  void removeFromListBodega(DetailProductStruct item) =>
      listBodega.remove(item);
  void removeAtIndexFromListBodega(int index) => listBodega.removeAt(index);
  void insertAtIndexInListBodega(int index, DetailProductStruct item) =>
      listBodega.insert(index, item);
  void updateListBodegaAtIndex(
          int index, Function(DetailProductStruct) updateFn) =>
      listBodega[index] = updateFn(listBodega[index]);

  double? total;

  ///  State fields for stateful widgets in this page.

  // Model for Menu component.
  late MenuModel menuModel;
  // Models for ItemShoppingCart dynamic component.
  late FlutterFlowDynamicModels<ItemShoppingCartModel> itemShoppingCartModels;
  // Stores action output result for [Custom Action - eliminarProductoCarrito] action in ItemShoppingCart widget.
  List<DetailProductStruct>? cartEliminarProducto;
  // Stores action output result for [Custom Action - seleccionarProducto] action in ItemShoppingCart widget.
  DataProductStruct? resultado;
  // Stores action output result for [Custom Action - eliminarProductoCarrito] action in ItemShoppingCart widget.
  List<DetailProductStruct>? resultadoEliminarProductoCarritoBodega;
  // Stores action output result for [Custom Action - eliminarProductoCarrito] action in ItemShoppingCart widget.
  List<DetailProductStruct>? resultadoEliminarProductoCarrito;
  // Stores action output result for [Backend Call - API (getListStorageByProduct)] action in ItemShoppingCart widget.
  ApiCallResponse? apiResultBodegaCarrito;
  // Stores action output result for [Custom Action - actualizarListaProductosBodega] action in ItemShoppingCart widget.
  List<DetailProductStruct>? resultadoCantidadBodega;
  // Stores action output result for [Custom Action - modificarCantidadBodega] action in ItemShoppingCart widget.
  List<DetailProductStruct>? cantidadStore;
  // Stores action output result for [Custom Action - modificarCantidadBodega] action in ItemShoppingCart widget.
  List<DetailProductStruct>? resultadoCantidadBodegaCarrito;
  // Stores action output result for [Custom Action - agregarProductoCarrito] action in ItemShoppingCart widget.
  List<DetailProductStruct>? resultadoBodega;
  // Stores action output result for [Custom Action - eliminarProductoCarrito] action in ItemShoppingCart widget.
  List<DetailProductStruct>? eliminarProductoCarrito;
  // Stores action output result for [Custom Action - eliminarProductoCarrito] action in ItemShoppingCart widget.
  List<DetailProductStruct>? eliminarProductoCarritoDefaultd;
  // Stores action output result for [Custom Action - deleteProduct] action in ItemShoppingCart widget.
  List<DetailProductStruct>? deleteProduct;
  // Stores action output result for [Custom Action - seleccionarProducto] action in ItemShoppingCart widget.
  DataProductStruct? resultad;
  // Stores action output result for [Backend Call - API (createOrderClient)] action in btnRealizarPedido widget.
  ApiCallResponse? apiResultCreateOrder;

  @override
  void initState(BuildContext context) {
    menuModel = createModel(context, () => MenuModel());
    itemShoppingCartModels =
        FlutterFlowDynamicModels(() => ItemShoppingCartModel());
  }

  @override
  void dispose() {
    menuModel.dispose();
    itemShoppingCartModels.dispose();
  }
}
