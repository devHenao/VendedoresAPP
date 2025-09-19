import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'item_shopping_cart_model.dart';
export 'item_shopping_cart_model.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/custom_functions.dart' as functions;

class ItemShoppingCartWidget extends StatefulWidget {
  const ItemShoppingCartWidget({
    super.key,
    required this.articulo,
    double? cantidad,
    required this.callbackCantidadCarrito,
    this.callbackEliminarCarrito,
    required this.callbackSeleccionadoCarrito,
  }) : this.cantidad = cantidad ?? 1.0;

  final DetailProductStruct? articulo;
  final double cantidad;
  final Future Function(double? pCantidad)? callbackCantidadCarrito;
  final Future Function()? callbackEliminarCarrito;
  final Future Function(bool state)? callbackSeleccionadoCarrito;

  @override
  State<ItemShoppingCartWidget> createState() => _ItemShoppingCartWidgetState();
}

class _ItemShoppingCartWidgetState extends State<ItemShoppingCartWidget> {
  late ItemShoppingCartModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ItemShoppingCartModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.contador = widget.cantidad;
      _model.updatePage(() {});
      safeSetState(() {
        _model.amountCartTextController?.text = _model.contador.toString();
      });

      if (widget.articulo != null) {
        // Fetch stock for the specific warehouse.
        final apiResult = await ProductsGroup.getListStorageByProductCall.call(
          token: FFAppState().infoSeller.token,
          codprecio: FFAppState().dataCliente.codprecio,
          codproduc: widget.articulo?.codigo,
        );

        if (apiResult.succeeded) {
          final bodegasJson = getJsonField(
            (apiResult.jsonBody ?? ''),
            r'''$.data''',
            true,
          );
          final bodegas = (bodegasJson as List?)
                  ?.map((e) => DetailProductStruct.maybeFromMap(e)!)
                  .toList() ??
              [];
          
          _model.stockLimit = functions.getSaldoPorBodega(
            widget.articulo!.bodega,
            bodegas,
          );
          _model.updatePage(() {});
        }
      }
    });

    _model.amountCartTextController ??= TextEditingController(text: '1');
    _model.amountCartFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Text(
                          valueOrDefault<String>(
                            widget.articulo?.descripcio,
                            'Descripcio',
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Manrope',
                                    fontSize: 20.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                      ),
                    ].divide(SizedBox(width: 2.0)),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Código:',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Manrope',
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  valueOrDefault<String>(
                                    widget.articulo?.codigo,
                                    'codigo',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Manrope',
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 5.0)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Bodega:',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Manrope',
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  valueOrDefault<String>(
                                    widget.articulo?.bodega,
                                    'bodega',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Manrope',
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 5.0)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'Lote:',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Manrope',
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  valueOrDefault<String>(
                                    widget.articulo?.codlote,
                                    'codlote',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Manrope',
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 5.0)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  'C. costo:',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Manrope',
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  valueOrDefault<String>(
                                    widget.articulo?.codcc,
                                    'codcc',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Manrope',
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ].divide(SizedBox(width: 5.0)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Valor unitario:',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Manrope',
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        formatNumber(
                          widget.articulo?.precio ?? 0.0,
                          formatType: FormatType.decimal,
                          decimalType: DecimalType.periodDecimal,
                          currency: '\$',
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Manrope',
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ].divide(SizedBox(width: 5.0)),
                  ),
                  if (_model.stockLimit != null)
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Saldo:',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Manrope',
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          _model.stockLimit.toString(),
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Manrope',
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ].divide(SizedBox(width: 5.0)),
                    ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.contador = 0.0;
                                _model.updatePage(() {});
                                await widget.callbackSeleccionadoCarrito?.call(
                                  false,
                                );
                                await widget.callbackCantidadCarrito?.call(
                                  0.0,
                                );
                                safeSetState(() {
                                  _model.amountCartTextController?.text = '0';
                                });
                                await widget.callbackEliminarCarrito?.call();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Se ha eliminado el producto',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 1500),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).error,
                                  ),
                                );
                              },
                              child: FaIcon(
                                FontAwesomeIcons.solidTrashAlt,
                                color: FlutterFlowTheme.of(context).error,
                                size: 25.0,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 15.0,
                                buttonSize: 30.0,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                disabledColor:
                                    FlutterFlowTheme.of(context).alternate,
                                icon: Icon(
                                  Icons.remove_rounded,
                                  color: FlutterFlowTheme.of(context).info,
                                  size: 15.0,
                                ),
                                onPressed: ((_model.contador ?? 0.0) <= 1.0)
                                    ? null
                                    : () async {
                                        _model.contador =
                                            (_model.contador ?? 1.0) - 1;
                                        _model.updatePage(() {});
                                        safeSetState(() {
                                          _model.amountCartTextController
                                                  ?.text =
                                              _model.contador.toString();
                                        });
                                        await widget.callbackCantidadCarrito
                                            ?.call(
                                          double.tryParse(_model
                                              .amountCartTextController.text),
                                        );
                                      },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: 100.0,
                                child: TextFormField(
                                  controller: _model.amountCartTextController,
                                  focusNode: _model.amountCartFocusNode,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.amountCartTextController',
                                    Duration(milliseconds: 2000),
                                    () async {
                                      final enteredAmount = double.tryParse(_model.amountCartTextController.text) ?? 0.0;
                                      final maxStock = _model.stockLimit ?? double.infinity;

                                      if (enteredAmount > maxStock) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'No se puede superar el saldo de la bodega ${widget.articulo?.bodega}',
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 3000),
                                            backgroundColor: FlutterFlowTheme.of(context).error,
                                          ),
                                        );
                                        _model.contador = maxStock;
                                      } else {
                                        _model.contador = enteredAmount > 0 ? enteredAmount : 1.0;
                                      }

                                      safeSetState(() {
                                        _model.amountCartTextController?.text = _model.contador.toString();
                                      });
                                      await widget.callbackCantidadCarrito?.call(_model.contador);
                                    },
                                  ),
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Manrope',
                                          letterSpacing: 0.0,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Manrope',
                                          letterSpacing: 0.0,
                                        ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(0x00000000),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Manrope',
                                        letterSpacing: 0.0,
                                      ),
                                  textAlign: TextAlign.center,
                                  maxLength: 6,
                                  buildCounter: (context,
                                          {required currentLength,
                                          required isFocused,
                                          maxLength}) =>
                                      null,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  validator: _model
                                      .amountCartTextControllerValidator
                                      .asValidator(context),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9-.]'))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 15.0,
                                buttonSize: 30.0,
                                fillColor: FlutterFlowTheme.of(context).primary,
                                icon: Icon(
                                  Icons.add_rounded,
                                  color: FlutterFlowTheme.of(context).info,
                                  size: 15.0,
                                ),
                                onPressed: (_model.contador ?? 0) >= (_model.stockLimit ?? double.infinity)
                                    ? () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'No se puede superar el saldo de la bodega ${widget.articulo?.bodega}',
                                              style: TextStyle(
                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                              ),
                                            ),
                                            duration: Duration(milliseconds: 3000),
                                            backgroundColor: FlutterFlowTheme.of(context).error,
                                          ),
                                        );
                                      }
                                    : () async {
                                        _model.contador = (_model.contador ?? 0) + 1;
                                        _model.updatePage(() {});
                                        safeSetState(() {
                                          _model.amountCartTextController?.text = _model.contador.toString();
                                        });
                                        await widget.callbackCantidadCarrito?.call(_model.contador);
                                      },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ].divide(SizedBox(height: 10.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
