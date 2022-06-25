import 'package:findmuseum_mobile/models/city_response_model.dart';
import 'package:findmuseum_mobile/screens/cities/museum_in_city.dart';
import 'package:findmuseum_mobile/screens/home/detail_museum.dart';
import 'package:findmuseum_mobile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

Future<List<CityData>> fetchDestination() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/city'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => CityData.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class CityData {
  late final int id;
  late final String name;
  late final String slug;

  CityData({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory CityData.fromJson(Map<String, dynamic> json) {
    return CityData(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}

class CityPage extends StatefulWidget {
  const CityPage({Key? key}) : super(key: key);

  @override
  State<CityPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CityPage> {
  late Future<List<CityData>> futureData;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    futureData = fetchDestination();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("All Cities"),
      ),
      body: SafeArea(
          child: ListView(
        children: [
          FutureBuilder<List<CityResponseModel>>(
            future: APIService.getCities(),
            builder: (context, snapshot) {
              print(snapshot.hasData);
              if (snapshot.hasData) {
                List<CityResponseModel> cityData = snapshot.requireData;
                print(cityData);
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cityData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MuseumInCity(
                                        name: cityData[index].name,
                                        cityId: cityData[index].id,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cityData[index].name,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        Text(
                                          cityData[index].slug,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 16.0,
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    const Text(
                      "No city found!",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      )),
    );
  }
}
