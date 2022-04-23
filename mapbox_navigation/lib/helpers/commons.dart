import 'package:mapbox_gl/mapbox_gl.dart';

import '../constants/restaurants.dart';

LatLng getLatLngFromRestaurantData(int index) {
  return LatLng(double.parse(allRestaurant[index].coordinates.latitude),
      double.parse(allRestaurant[index].coordinates.longitude));
}
