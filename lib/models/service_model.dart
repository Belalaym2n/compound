import 'package:flutter/material.dart';

class ServicesModel {
  IconData icon; // Use IconData for the icon type
  String title;

  ServicesModel(this.icon, this.title);

  static List<ServicesModel> services = [
    ServicesModel(Icons.electrical_services, "Electrical"),
    ServicesModel(Icons.cleaning_services, "Cleaning"),
    ServicesModel(Icons.room_service_outlined, "Room Service"),
    ServicesModel(Icons.medical_services, "Medical"),
    ServicesModel(Icons.plumbing, "Plumbing"),
    ServicesModel(Icons.ac_unit, "HVAC"),
    ServicesModel(Icons.landscape, "Landscaping"),
    ServicesModel(Icons.security, "Security"),
    ServicesModel(Icons.format_paint, "Painting"),
    ServicesModel(Icons.construction, "Renovation"),
    ServicesModel(Icons.tune, "Maintenance"),
    ServicesModel(Icons.build, "Repair"),
    ServicesModel(Icons.monitor, "Monitoring"),
  ];
  static List<Color> serviceColors = [
    Colors.black, // Electrical - Yellow
  ];
}
