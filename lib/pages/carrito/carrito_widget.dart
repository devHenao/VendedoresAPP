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
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'carrito_model.dart';
export 'carrito_model.dart';

class CarritoWidget extends StatefulWidget {
  const CarritoWidget({super.key});

  @override
  State<CarritoWidget> createState() => _CarritoWidgetState();
}

class _CarritoWidgetState extends State<CarritoWidget> {
  late CarritoModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CarritoModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.total = functions.calculateTotal(
          FFAppState().shoppingCart.map((e) => e.precio).toList().toList(),
          FFAppState().shoppingCart.map((e) => e.cantidad).toList().toList());
      safeSetState(() {});
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: Drawer(
          elevation: 16.0,
          child: wrapWithModel(
            model: _model.menuModel,
            updateCallback: () => safeSetState(() {}),
            child: MenuWidget(),
          ),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.menu,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: Visibility(
            visible: FFAppState().dataCliente.nombre != null &&
                FFAppState().dataCliente.nombre != '',
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'Cliente:',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: 'Outfit',
                              color: Colors.white,
                              fontSize: 22.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ].divide(SizedBox(width: 5.0)),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        FFAppState().dataCliente != null
                            ? valueOrDefault<String>(
                                FFAppState().dataCliente.nombre,
                                'Cliente',
                              )
                            : 'Cliente',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: 'Outfit',
                              color: Colors.white,
                              fontSize: 22.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ].divide(SizedBox(width: 5.0)),
                ),
              ],
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 12.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(12.0, 10.0, 12.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Mi carrito',
                                  style: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .override(
                                        fontFamily: 'Outfit',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 30.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed('Productos');
                                },
                                child: Icon(
                                  Icons.inventory,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 30.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ].divide(SizedBox(height: 8.0)),
                  ),
                ),
                Divider(
                  thickness: 2.0,
                  color: FlutterFlowTheme.of(context).alternate,
                ),
                if (_model.total! > 0.0)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Total:',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Manrope',
                              color: FlutterFlowTheme.of(context).primary,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        formatNumber(
                          _model.total,
                          formatType: FormatType.decimal,
                          decimalType: DecimalType.periodDecimal,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Manrope',
                              color: FlutterFlowTheme.of(context).primary,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ].divide(SizedBox(width: 5.0)),
                  ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (!(FFAppState().shoppingCart.isNotEmpty))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/17568902.png',
                                      width: 200.0,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    'No tienes productos agregados',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Manrope',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 20.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(),
                            child: Visibility(
                              visible: FFAppState().shoppingCart.isNotEmpty,
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 10.0),
                                child: Builder(
                                  builder: (context) {
                                    final articulos =
                                        FFAppState().shoppingCart.toList();

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: articulos.length,
                                      itemBuilder: (context, articulosIndex) {
                                        final articulosItem =
                                            articulos[articulosIndex];
                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 10.0),
                                              child: wrapWithModel(
                                                model: _model
                                                    .itemShoppingCartModels
                                                    .getModel(
                                                  articulosIndex.toString(),
                                                  articulosIndex,
                                                ),
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                updateOnChange: true,
                                                child: Hero(
                                                  tag: 'cart',
                                                  transitionOnUserGestures:
                                                      true,
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child:
                                                        ItemShoppingCartWidget(
                                                      key: Key(
                                                        'Keyarb_${articulosIndex.toString()}',
                                                      ),
                                                      articulo: articulosItem,
                                                      cantidad: articulosItem
                                                          .cantidad,
                                                      callbackCantidadCarrito:
                                                          (pCantidad) async {
                                                        _model.apiResultBodegaCarrito =
                                                            await ProductsGroup
                                                                .getListStorageByProductCall
                                                                .call(
                                                          token: FFAppState()
                                                              .infoSeller
                                                              .token,
                                                          codprecio:
                                                              FFAppState()
                                                                  .dataCliente
                                                                  .codprecio,
                                                          codproduc:
                                                              articulosItem
                                                                  .codigo,
                                                        );

                                                        if ((_model
                                                                .apiResultBodegaCarrito
                                                                ?.succeeded ??
                                                            true)) {
                                                          _model.resultadoCantidadBodega =
                                                              await actions
                                                                  .actualizarListaProductosBodega(
                                                            (getJsonField(
                                                              (_model.apiResultBodegaCarrito
                                                                      ?.jsonBody ??
                                                                  ''),
                                                              r'''$.data''',
                                                              true,
                                                            )!
                                                                        .toList()
                                                                        .map<DetailProductStruct?>(DetailProductStruct
                                                                            .maybeFromMap)
                                                                        .toList()
                                                                    as Iterable<
                                                                        DetailProductStruct?>)
                                                                .withoutNulls
                                                                .toList(),
                                                            FFAppState()
                                                                .shoppingCart
                                                                .toList(),
                                                          );
                                                          _model.listBodega = _model
                                                              .resultadoCantidadBodega!
                                                              .toList()
                                                              .cast<
                                                                  DetailProductStruct>();
                                                          safeSetState(() {});
                                                          if (FFAppState()
                                                                  .infoSeller
                                                                  .storageDefault !=
                                                              articulosItem
                                                                  .bodega) {
                                                            _model.cantidadStore =
                                                                await actions
                                                                    .modificarCantidadBodega(
                                                              articulosItem,
                                                              FFAppState()
                                                                  .store
                                                                  .toList(),
                                                              pCantidad,
                                                            );
                                                            FFAppState().store = _model
                                                                .cantidadStore!
                                                                .toList()
                                                                .cast<
                                                                    DetailProductStruct>();
                                                            FFAppState()
                                                                .update(() {});
                                                          } else {
                                                            _model.resultadoCantidadBodegaCarrito =
                                                                await actions
                                                                    .modificarCantidadBodega(
                                                              articulosItem,
                                                              _model.listBodega
                                                                  .toList(),
                                                              pCantidad,
                                                            );
                                                            _model.listBodega = _model
                                                                .resultadoCantidadBodegaCarrito!
                                                                .toList()
                                                                .cast<
                                                                    DetailProductStruct>();
                                                            safeSetState(() {});
                                                            _model.resultadoBodega =
                                                                await actions
                                                                    .agregarProductoCarrito(
                                                              FFAppState()
                                                                  .shoppingCart
                                                                  .toList(),
                                                              DataProductStruct(
                                                                codproduc:
                                                                    articulosItem
                                                                        .codigo,
                                                                precio:
                                                                    articulosItem
                                                                        .precio,
                                                                descripcio:
                                                                    articulosItem
                                                                        .descripcio,
                                                                saldo:
                                                                    articulosItem
                                                                        .saldo,
                                                                unidadmed:
                                                                    articulosItem
                                                                        .unidadmed,
                                                                codtariva:
                                                                    articulosItem
                                                                        .codtariva,
                                                                iva:
                                                                    articulosItem
                                                                        .iva,
                                                                cantidad:
                                                                    articulosItem
                                                                        .cantidad,
                                                                selected: true,
                                                                codbarras: '',
                                                              ),
                                                              articulosItem
                                                                  .bodega,
                                                              articulosItem
                                                                  .codcc,
                                                              articulosItem
                                                                  .codlote,
                                                              articulosItem
                                                                  .cantidad,
                                                            );
                                                            FFAppState()
                                                                    .shoppingCart =
                                                                _model
                                                                    .resultadoBodega!
                                                                    .toList()
                                                                    .cast<
                                                                        DetailProductStruct>();
                                                            FFAppState()
                                                                .update(() {});
                                                            _model.total = functions.calculateTotal(
                                                                FFAppState()
                                                                    .shoppingCart
                                                                    .map((e) => e
                                                                        .precio)
                                                                    .toList(),
                                                                FFAppState()
                                                                    .shoppingCart
                                                                    .map((e) =>
                                                                        e.cantidad)
                                                                    .toList());
                                                            safeSetState(() {});
                                                          }
                                                        }

                                                        safeSetState(() {});
                                                      },
                                                      callbackEliminarCarrito:
                                                          () async {
                                                        if (FFAppState()
                                                                .infoSeller
                                                                .storageDefault !=
                                                            articulosItem
                                                                .bodega) {
                                                          _model.eliminarProductoCarrito =
                                                              await actions
                                                                  .eliminarProductoCarrito(
                                                            articulosItem
                                                                .bodega,
                                                            articulosItem.codcc,
                                                            articulosItem
                                                                .codlote,
                                                            articulosItem
                                                                .codigo,
                                                            FFAppState()
                                                                .shoppingCart
                                                                .toList(),
                                                          );
                                                          FFAppState()
                                                                  .shoppingCart =
                                                              _model
                                                                  .eliminarProductoCarrito!
                                                                  .toList()
                                                                  .cast<
                                                                      DetailProductStruct>();
                                                          safeSetState(() {});
                                                        } else {
                                                          _model.eliminarProductoCarritoDefaultd =
                                                              await actions
                                                                  .eliminarProductoCarrito(
                                                            FFAppState()
                                                                .infoSeller
                                                                .storageDefault,
                                                            '0',
                                                            '0',
                                                            articulosItem
                                                                .codigo,
                                                            FFAppState()
                                                                .shoppingCart
                                                                .toList(),
                                                          );
                                                          FFAppState()
                                                                  .shoppingCart =
                                                              _model
                                                                  .eliminarProductoCarritoDefaultd!
                                                                  .toList()
                                                                  .cast<
                                                                      DetailProductStruct>();
                                                          safeSetState(() {});
                                                        }

                                                        _model.deleteProduct =
                                                            await actions
                                                                .deleteProduct(
                                                          FFAppState()
                                                              .store
                                                              .toList(),
                                                          articulosItem.codigo,
                                                        );
                                                        FFAppState().store = _model
                                                            .deleteProduct!
                                                            .toList()
                                                            .cast<
                                                                DetailProductStruct>();
                                                        FFAppState()
                                                            .update(() {});

                                                        safeSetState(() {});
                                                      },
                                                      callbackSeleccionadoCarrito:
                                                          (state) async {
                                                        _model.resultad =
                                                            await actions
                                                                .seleccionarProducto(
                                                          DataProductStruct(
                                                            codproduc:
                                                                articulosItem
                                                                    .codigo,
                                                            precio:
                                                                articulosItem
                                                                    .precio,
                                                            descripcio:
                                                                articulosItem
                                                                    .descripcio,
                                                            saldo: articulosItem
                                                                .saldo,
                                                            unidadmed:
                                                                articulosItem
                                                                    .unidadmed,
                                                            codbarras: '',
                                                            codtariva:
                                                                articulosItem
                                                                    .codtariva,
                                                            iva: articulosItem
                                                                .iva,
                                                            selected: true,
                                                            cantidad:
                                                                articulosItem
                                                                    .cantidad,
                                                          ),
                                                          articulosItem.codigo,
                                                        );

                                                        safeSetState(() {});
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if ((FFAppState().shoppingCart.isNotEmpty) == true)
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Builder(
                          builder: (context) => FFButtonWidget(
                            onPressed: () async {
                              if (FFAppState().shoppingCart.isNotEmpty) {
                                _model.apiResultCreateOrder =
                                    await ProductsGroup.createOrderClientCall
                                        .call(
                                  token: FFAppState().infoSeller.token,
                                  nit: FFAppState().dataCliente.nit,
                                  listProductsJson: FFAppState()
                                      .shoppingCart
                                      .map((e) => e.toMap())
                                      .toList(),
                                );

                                if ((_model.apiResultCreateOrder?.succeeded ??
                                    true)) {
                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0)
                                                .resolve(
                                                    Directionality.of(context)),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(dialogContext)
                                                .unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: RegisterOrderWidget(),
                                        ),
                                      );
                                    },
                                  );

                                  FFAppState().shoppingCart = [];
                                  FFAppState().store = [];
                                  FFAppState().update(() {});
                                  _model.total = 0.0;
                                  safeSetState(() {});
                                  FFAppState().store = [];
                                  FFAppState().update(() {});
                                } else {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: Text('Error'),
                                        content: Text(getJsonField(
                                          (_model.apiResultCreateOrder
                                                  ?.jsonBody ??
                                              ''),
                                          r'''$.data''',
                                        ).toString()),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                alertDialogContext),
                                            child: Text('Ok'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('¡Oh no!'),
                                      content: Text('Tu carrito esta vacío '),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }

                              safeSetState(() {});
                            },
                            text: 'Realizar pedido',
                            icon: Icon(
                              Icons.move_to_inbox_rounded,
                              size: 15.0,
                            ),
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Manrope',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            var confirmDialogResponse = await showDialog<bool>(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('Cancelar pedido'),
                                      content:
                                          Text('¿Deseas cancelar el pedido?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, false),
                                          child: Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, true),
                                          child: Text('Confirmar'),
                                        ),
                                      ],
                                    );
                                  },
                                ) ??
                                false;
                            if (confirmDialogResponse) {
                              FFAppState().shoppingCart = [];
                              FFAppState().store = [];
                              safeSetState(() {});
                              FFAppState().addToProductList(DataProductStruct(
                                selected: false,
                              ));
                              safeSetState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Se ha cancelado tu pedido',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 3000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).error,
                                  action: SnackBarAction(
                                    label: '',
                                    onPressed: () async {
                                      safeSetState(() {});
                                    },
                                  ),
                                ),
                              );
                              _model.total = 0.0;
                              safeSetState(() {});
                              FFAppState().store = [];
                              FFAppState().update(() {});
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Continua con tu pedido',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 5000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).tertiary,
                                ),
                              );
                            }
                          },
                          text: 'Cancelar pedido',
                          icon: Icon(
                            Icons.cancel_rounded,
                            size: 15.0,
                          ),
                          options: FFButtonOptions(
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).error,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Manrope',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ].divide(SizedBox(width: 20.0)),
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
