import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_navigation/constants/restaurants.dart';
import 'package:mapbox_navigation/helpers/commons.dart';
import 'package:mapbox_navigation/helpers/shared_prefs.dart';
import 'package:mapbox_navigation/widgets/carousel_card.dart';
import 'package:mapbox_navigation/screens/restaurants_table.dart';

class LocationNavigation extends StatefulWidget {
  const LocationNavigation({Key? key, required int this.locationIndex})
      : super(key: key);

  final int locationIndex;

  @override
  State<LocationNavigation> createState() => _LocationNavigationState();
}

class _LocationNavigationState extends State<LocationNavigation> {
  LatLng latLng = getLatLngFromSharedPrefs();
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;

  void initState() {
    super.initState();
    _initialCameraPosition = CameraPosition(target: latLng, zoom: 15);

    //Calculate the distance and the time from data in SharedPreferences
    num distance = getDistanceFromSharedPrefs(widget.locationIndex) / 1000;
    num duration = getDurationFromSharedPrefs(widget.locationIndex) / 1000;
  }

  _addSourceAndLineLayer(bool removeLayer) async {
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: getLatLngFromRestaurantData(widget.locationIndex))));

    Map geometry = getGeometryFromSharedPrefs(widget.locationIndex);
    final _fills = {
      "type": "FeatureCollection",
      "features": [
        {
          "type": "Feature",
          "id": 0,
          "property": <String, dynamic>{},
          "geometry": geometry,
        }
      ]
    };

    if (removeLayer == true) {
      await controller.removeLayer("lines");
      await controller.removeSource("fills");
    }

    await controller.addSource("fills", GeojsonSourceProperties(data: _fills));
    await controller.addLineLayer(
        "fills",
        "lines",
        LineLayerProperties(
          lineColor: Colors.green.toHexStringRGB(),
          lineCap: "round",
          lineJoin: "round",
          lineWidth: 2,
        ));
  }

  _onMapcreated(MapboxMapController controller) async {
    this.controller = controller;
  }

  _onStyleLoadedCalllBack() async {
    await controller.addSymbol(SymbolOptions(
      geometry: CameraPosition(
              target: getLatLngFromRestaurantData(widget.locationIndex))
          .target,
      iconSize: 0.2,
      iconImage: 'assets/icon/food.png',
    ));

    _addSourceAndLineLayer(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location Map"),
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 1.0,
          child: MapboxMap(
            accessToken: dotenv.env['MAPBOX_ACCESS_TOKEN'],
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: _onMapcreated,
            onStyleLoadedCallback: _onStyleLoadedCalllBack,
            myLocationEnabled: true,
            myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
            minMaxZoomPreference: const MinMaxZoomPreference(14, 17),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.animateCamera(
                CameraUpdate.newCameraPosition(_initialCameraPosition));
          },
          child: const Icon(Icons.my_location)),
    );
  }
}
