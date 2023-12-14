import 'dart:math';

import 'package:api_train/model/test_api_model.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatefulWidget {
  final TestApiModel testApiModel;
  final int index;
  const UserDetailsScreen(
      {super.key, required this.testApiModel, required this.index});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getDistances();
    super.initState();
  }
  Widget detailsWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 400,
            height: 200,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                    widget.testApiModel.results![widget.index].picture!.large!),
                const SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.testApiModel.results![widget.index].name!.title} ${widget.testApiModel.results![widget.index].name!.first} ${widget.testApiModel.results![widget.index].name!.last}",
                        // softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Address : ${widget.testApiModel.results![widget.index].location!.city}, ${widget.testApiModel.results![widget.index].location!.country}askcjbakscjaksjbckajsbckjabsckjabsckjasbcjabc",
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                          "coordinates :\n${widget.testApiModel.results![widget.index].location!.coordinates!.latitude} - ${widget.testApiModel.results![widget.index].location!.coordinates!.longitude}"),
                      Text(
                          "Email Id : ${widget.testApiModel.results![widget.index].email}")
                    ],
                  ),
                ),

              ],
            ),
          ),
          SizedBox(
            height: 400,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.testApiModel.results!.length,
              itemBuilder: (BuildContext context, index) {
                return Container(
                  child:index == widget.index ? Container() : Text(widget.testApiModel.results![index].distance.toString()),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  num calculateDistance(double latitude, double longitude) {
    return pow(
        pow(
                (latitude -
                    double.parse(widget.testApiModel.results![widget.index]
                        .location!.coordinates!.latitude!)),
                2) +
            pow(
                (longitude -
                    double.parse(widget.testApiModel.results![widget.index]
                        .location!.coordinates!.longitude!)),
                2),
        0.5);
  }

  void getDistances() {
    for (int i = 0; i < widget.testApiModel.results!.length; i++) {
      if (i != widget.index) {
        widget.testApiModel.results![i].distance = calculateDistance(
            double.parse(widget
                .testApiModel.results![i].location!.coordinates!.latitude!),
            double.parse(widget
                .testApiModel.results![i].location!.coordinates!.longitude!));
        print("----------->>>>>>>>>> $i ${widget.testApiModel.results![i].distance!.toDouble()}");
      }
    }
    // return widget.testApiModel;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: widget.testApiModel != null
            ? detailsWidget()
            : const Center(
                child: Text("Null model received"),
              ),
      ),
    );
  }
}
