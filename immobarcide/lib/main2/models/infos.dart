import 'package:flutter/material.dart';

class Info {
  String name;
  String job;
  String image;
  Info({
    required this.name,
    required this.job,
    required this.image,
  });
}

List<Info> infos = [
  Info(
      name: "Yahya Chebbi",
      job: "Developer",
      image: "assets/images/person3.jpg"),
  Info(
      name: "Yahya Chebbi",
      job: "Developer",
      image: "assets/images/person2.jpg"),
  Info(
      name: "Yahya Chebbi",
      job: "Developer",
      image: "assets/images/person4.jpg"),
  Info(
      name: "Yahya Chebbi",
      job: "Developer",
      image: "assets/images/person5.jpg"),
];
