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
              Container(
                height: 10,
              ),
              Text(
                arg.restaurant['name'],
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Container(
                height: 10,
              ),
              Text(arg.restaurant['items'], style: TextStyle(fontSize: 18),),
              const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.'),
              ),
              const Text('Waiting time: 2hrs'),
              Text(
                'Closes at 10PM',
                style:
                TextStyle(color: Colors.redAccent[100]),
              ),
              Padding(padding: const EdgeInsets.only(top: 50)),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:30, right: 10),
                    child: ElevatedButton(
                      onPressed: () => log("Hello World"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(5),
                        minimumSize: Size.zero,
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.call, size: 20),
                          SizedBox(width: 5),
                          Text("Call", style: TextStyle(fontSize: 18))
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
                          Icon(Icons.map, size: 20),
                          SizedBox(width: 5),
                          Text("Map", style: TextStyle(fontSize: 17))
                        ],
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 150)),
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