import 'package:flutter/material.dart';

class ServicesModel {
  IconData icon; // Use IconData for the icon type
  String title;
  Color color;

  ServicesModel(this.icon, this.color, this.title);

  static List<ServicesModel> services = [
    ServicesModel(Icons.cleaning_services, Color(0xFFf2eeff), "Cleaning"),
    ServicesModel(Icons.build, Color(0xFFfff7ec), "Repairing"),
    ServicesModel(Icons.format_paint, Color(0xFFeff3ff), "Painting"),
    ServicesModel(Icons.electrical_services, Color(0xFFfffbef), "Electrical"),
    ServicesModel(
        Icons.room_service_outlined, Color(0xFFfef2f2), "Room Service"),
    ServicesModel(Icons.medical_services, Color(0xFFf2f9f1), "Medical"),
    ServicesModel(Icons.plumbing, Color(0xFFe9fbfd), "Plumbing"),
    ServicesModel(Icons.ac_unit, Color(0xFFf4edff), "HVAC"),
  ];
  static List<Color> serviceColors = [
    Colors.black, // Electrical - Yellow
    Colors.black, // Electrical - Yellow
    Colors.black, // Electrical - Yellow
    Colors.black, // Electrical - Yellow
    Colors.black, // Electrical - Yellow
    Colors.black, // Electrical - Yellow
    Colors.black, // Electrical - Yellow
    Colors.black, // Electrical - Yellow
  ];
}
