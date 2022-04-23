import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_navigation/constants/restaurants.dart';
import 'package:mapbox_navigation/helpers/shared_prefs.dart';
import 'package:mapbox_navigation/screens/circle_subscreen.dart';
import 'package:mapbox_navigation/screens/location_navigation.dart';
import 'package:mapbox_navigation/screens/circle_subscreen.dart';

class CircleScreen extends StatefulWidget {
  const CircleScreen({Key? key}) : super(key: key);

  @override
  State<CircleScreen> createState() => _CircleScreenState();
}

class _CircleScreenState extends State<CircleScreen> {
  List<Map> circles = List.from(restaurants);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Circle'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: circles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Card(
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
                                imageUrl: circles[index]['image'],
                              ),
                              Expanded(
                                child: Container(
                                  height: 175,
                                  padding: const EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        circles[index]['name'],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(circles[index]['items']),
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
                        ),
                        onTap: () => Navigator.pushNamed(
                          context,
                          CircleSubscreen.routeName,
                          arguments: CircleSubscreenArgurment(circles[index], index)
                        )
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
