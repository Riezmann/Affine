import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_navigation/constants/restaurants.dart';
import 'package:mapbox_navigation/helpers/shared_prefs.dart';
import 'package:mapbox_navigation/screens/location_navigation.dart';
import 'package:flutter/src/widgets/framework.dart';

class CircleSubscreenArgurment {
  final Map restaurant;
  final int index;

  CircleSubscreenArgurment(this.restaurant, this.index);
}

class CircleSubscreen extends StatelessWidget {
  const CircleSubscreen({Key? key}) : super(key: key);

  static const routeName = '/circleSubscreen';

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute
        .of(context)!
        .settings
        .arguments as CircleSubscreenArgurment;


    return Scaffold(
        appBar: AppBar(
            title: const Text('Details')
        ),
        body: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(arg.restaurant['image'])
                    )
                ),
              ),
              Text(
                arg.restaurant['name'],
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text(arg.restaurant['items']),
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
                                      locationIndex: arg.index,
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
                      '${(getDistanceFromSharedPrefs(arg.index) / 1000)
                          .toStringAsFixed(
                          2)}km'),

                ],
              )
            ]
        )
    );
  }
}