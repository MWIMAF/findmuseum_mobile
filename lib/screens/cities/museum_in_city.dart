import 'package:findmuseum_mobile/models/museum_in_city_response_model.dart';
import 'package:findmuseum_mobile/screens/home/detail_museum.dart';
import 'package:findmuseum_mobile/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MuseumInCity extends StatefulWidget {
  final String name;
  final int cityId;
  MuseumInCity({
    required this.name,
    required this.cityId,
  });
  @override
  State<MuseumInCity> createState() => _MuseumInCityState();
}

class _MuseumInCityState extends State<MuseumInCity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Museum in ${widget.name}"),
      ),
      body: ListView(
        children: [
          FutureBuilder<List<MuseumInCityResponseModel>>(
            future: APIService.getMuseumInCity(widget.cityId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<MuseumInCityResponseModel> museumInCity =
                    snapshot.requireData;
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  // width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: museumInCity.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailMuseum(
                                          name: museumInCity[index].name!,
                                          desc: museumInCity[index].desc!,
                                          img: museumInCity[index].image!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 2.0),
                                    width: 170,
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            museumInCity[index].image!),
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.5),
                                            BlendMode.darken),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        museumInCity[index].name!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        museumInCity[index].excerpt!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        height: 25.0,
                                      ),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            primary: Colors.white,
                                            backgroundColor: Colors.black),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailMuseum(
                                                name: museumInCity[index].name!,
                                                desc: museumInCity[index].desc!,
                                                img: museumInCity[index].image!,
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text("See More"),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          )
                        ],
                      );
                    },
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    const Text(
                      "No Museum found!",
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
      ),
    );
  }
}
