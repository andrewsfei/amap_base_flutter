import 'dart:convert';

import 'package:amap_base/amap_base.dart';
import 'package:amap_base/src/map/model/marker_options.dart';
import 'package:amap_base/src/map/model/my_location_style.dart';
import 'package:amap_base/src/map/model/route_plan_param.dart';
import 'package:amap_base/src/map/model/ui_settings.dart';
import 'package:amap_base/src/utils/log.dart';
import 'package:flutter/services.dart';

class AMapController {
  final MethodChannel _mapChannel;

  AMapController.withId(int id)
      : _mapChannel = MethodChannel('me.yohom/map$id');

  void setMyLocationStyle(MyLocationStyle style) {
    final _styleJson =
        jsonEncode(style?.toJson() ?? MyLocationStyle().toJson());

    L.p('方法setMyLocationStyle dart端参数: styleJson -> $_styleJson');
    _mapChannel.invokeMethod(
      'map#setMyLocationStyle',
      {'myLocationStyle': _styleJson},
    );
  }

  void setUiSettings(UiSettings uiSettings) {
    final _uiSettings = jsonEncode(uiSettings.toJson());

    L.p('方法setUiSettings dart端参数: _uiSettings -> $_uiSettings');
    _mapChannel.invokeMethod(
      'map#setUiSettings',
      {'uiSettings': _uiSettings},
    );
  }

  Future calculateDriveRoute(RoutePlanParam param) {
    final _routePlanParam = param.toJsonString();
    L.p('方法calculateDriveRoute dart端参数: _routePlanParam -> $_routePlanParam');
    return _mapChannel.invokeMethod(
      'map#calculateDriveRoute',
      {'routePlanParam': _routePlanParam},
    );
  }

  void addMarker(MarkerOptions options) {
    final _optionsJson = options.toJsonString();
    L.p('方法addMarker dart端参数: _optionsJson -> $_optionsJson');
    _mapChannel.invokeMethod(
      'marker#addMarker',
      {'markerOptions': _optionsJson},
    );
  }

  void addMarkers(List<MarkerOptions> optionsList, {bool moveToCenter = true}) {
    final _optionsListJson =
        jsonEncode(optionsList.map((it) => it.toJson()).toList());
    L.p('方法addMarkers dart端参数: _optionsListJson -> $_optionsListJson');
    _mapChannel.invokeMethod(
      'marker#addMarkers',
      {
        'moveToCenter': moveToCenter,
        'markerOptionsList': _optionsListJson,
      },
    );
  }
}