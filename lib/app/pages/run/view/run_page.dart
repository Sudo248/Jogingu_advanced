import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:jogingu_advanced/app/base/page_base.dart';
import 'package:jogingu_advanced/app/pages/run/bloc/run_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../../domain/entities/j_map_state.dart';

class RunPage extends PageBase<RunBloc> {
  RunPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<JMapState>(
        stream: bloc.jMapStateStream,
        builder: (context, snapshot) {
          return FlutterMap(
            options: bloc.mapOptions,
            layers: [
              bloc.tileLayerOptions,
              polylineLayer(),
              makerLayer(),
            ],
            mapController: bloc.mapController,
          );
        },
      ),
    );
  }

  PolylineLayerOptions polylineLayer() => PolylineLayerOptions(
        polylines: [
          Polyline(
            points: bloc.listLocation,
            strokeWidth: 3,
          ),
        ],
      );

  MarkerLayerOptions makerLayer() => MarkerLayerOptions(
        markers: [
          Marker(
            point: bloc.currentLocation,
            builder: (context) {
              return const FlutterLogo(
                size: 24,
              );
            },
          )
        ],
      );
}
