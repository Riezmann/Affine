import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_navigation/constants/restaurants.dart';
import 'package:mapbox_navigation/helpers/shared_prefs.dart';
import 'package:mapbox_navigation/screens/location_navigation.dart';
import 'package:mapbox_navigation/screens/restaurants_map.dart';
import 'package:mapbox_navigation/screens/home_management.dart';

class RestaurantsTable extends StatefulWidget {
  const RestaurantsTable({Key? key}) : super(key: key);

  @override
  State<RestaurantsTable> createState() => _RestaurantsTableState();
}

class _RestaurantsTableState extends State<RestaurantsTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants Table'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CupertinoTextField(
                prefix: Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Icon(Icons.search),
                ),
                padding: EdgeInsets.all(15),
                placeholder: 'Search dish or restaurant name',
                style: TextStyle(color: Colors.white),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              const SizedBox(height: 5),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: allRestaurant.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          height: 175,
                          width: 140,
                          fit: BoxFit.cover,
                          imageUrl: allRestaurant[index].image,
                        ),
                        Expanded(
                          child: Container(
                            height: 175,
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  allRestaurant[index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(allRestaurant[index].items),
                                const Spacer(),
                                const Text('Waiting time: 2hrs'),
                                Text(
                                  'Closes at 10PM',
                                  style:
                                      TextStyle(color: Colors.redAccent[100]),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: ElevatedButton(
                                        onPressed: () => log("Hello World"),
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(5),
                                          minimumSize: Size.zero,
                                        ),
                                        child: Row(
                                          children: const [
                                            Icon(Icons.call, size: 16),
                                            SizedBox(width: 2),
                                            Text("Call")
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LocationNavigation(
                                                        locationIndex: index,
                                                      )));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(5),
                                          minimumSize: Size.zero,
                                        ),
                                        child: Row(
                                          children: const [
                                            Icon(Icons.map, size: 16),
                                            SizedBox(width: 2),
                                            Text("Map")
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                        '${(getDistanceFromSharedPrefs(index) / 1000).toStringAsFixed(2)}km'),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
