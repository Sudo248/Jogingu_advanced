import 'package:jogingu_advanced/app/base/bloc_base.dart';
import 'package:jogingu_advanced/data/services/location_service.dart';
import 'package:jogingu_advanced/domain/common/constants.dart';
import 'package:jogingu_advanced/domain/common/run_state.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../domain/common/logger.dart';
import '../../../../domain/entities/j_map_state.dart';

class RunBloc extends BlocBase {
  double currentZoom = Constants.defaultZoom;

  final MapController mapController = MapControllerImpl();

  final tileLayerOptions = TileLayerOptions(
    urlTemplate: Constants.baseMapBoxUrl + dotenv.get("MAP_BOX"),
    additionalOptions: {
      "accessToken": dotenv.get("ACCESS_TOKEN"),
      "id": Constants.idMapBox
    },
  );

  final MapOptions mapOptions = MapOptions(
    center: LatLng(Constants.haNoiLatitude, Constants.haNoiLongtitude),
    zoom: Constants.defaultZoom,
    enableMultiFingerGestureRace: true,
    maxZoom: Constants.maxZoom,
    minZoom: Constants.minZoom,
  );

  final LocationService locationService;

  RunBloc({required this.locationService});

  BehaviorSubject<JMapState> jMapState =
      BehaviorSubject.seeded(JMapState.init());
  Stream<JMapState> get jMapStateStream => jMapState.stream;
  Sink<JMapState> get jMapStateSink => jMapState.sink;

  final List<LatLng> listLocation = List.empty(growable: true);

  LatLng currentLocation =
      LatLng(Constants.haNoiLatitude, Constants.haNoiLongtitude);

  @override
  void onInit() async {
    if (await locationService.checkAndRequestLocationService()) {
      if (await locationService.checkAndRequestPermissionForUpdateLocation()) {
        currentLocation = await locationService.getLatLngCurrentPosition();
        mapController.move(currentLocation, currentZoom);
        subcriptionUpdateLocation();
      } else {
        /// TODO: show dialog required permission for position.
      }
    } else {
      /// TODO: show dialog this device don't have position service or it busy.
    }
  }

  void subcriptionUpdateLocation() async {
    locationService.subcriptionUpdateLocation();
    locationService.onChangedLatLngLocation((newestLocation) {
      currentLocation = newestLocation;
      mapController.mapEventStream.listen((event) {
        Logger.success(message: "mapEventStream: ${event.source.name}");
      });

	  mapController.move(newestLocation, currentZoom);

      if (jMapState.value.runstate == RunState.running) {
        mapController.move(newestLocation, currentZoom);
        listLocation.add(newestLocation);
      }
    //   jMapStateSink.add(jMapState.value.copyWith(isUpdateLocation: true));
    });
  }

  void unSubcriptionUpdateLocation() async {
    locationService.unSubcriptionUpdateLocation();
    listLocation.clear();
  }

  void onStartClick() =>
      jMapStateSink.add(jMapState.value.copyWith(runstate: RunState.running));

  void onPauseOrResumeClick() async {
    if (jMapState.value.runstate == RunState.running) {
      jMapStateSink.add(jMapState.value.copyWith(runstate: RunState.pause));
    } else {
      jMapStateSink.add(jMapState.value.copyWith(runstate: RunState.running));
    }
  }

  void onFinish() =>
      jMapStateSink.add(jMapState.value.copyWith(runstate: RunState.finish));

  @override
  void onDispose() {
    unSubcriptionUpdateLocation();
    jMapState.close();
  }
}
