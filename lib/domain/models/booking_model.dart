import 'id_order_model.dart';

class Booking implements IDOrderModel {
  final String? bookingType;
  String? id;
  String? compound;
  String? phoneNumber;
  String? name;
  String? isPaid;
  String? email;
  String? price;
  final List<BookingDate> selectedDates;

  Booking({
    required this.bookingType,
    required this.name,
    required this.price,
    required this.isPaid,
    required this.email,
    required this.phoneNumber,
    required this.compound,
    this.id,
    required this.selectedDates,
  });

  // Convert Booking to JSON
  Map<String, dynamic> toJson() {
    return {
      'bookingType': bookingType,
      'compound': compound,
      'price': price,
      'isPaid': isPaid,
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'selectedDates': selectedDates.map((date) => date.toJson()).toList(),
    };
  }

  // Create Booking from JSON
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      bookingType: json['bookingType'],
      name: json['name'],
      price: json['price'],
      phoneNumber: json['phoneNumber'],
      compound: json['compound'],
      email: json['email'],
      isPaid: json['isPaid'],
      id: json['id'],
      selectedDates: (json['selectedDates'] as List)
          .map((dateJson) => BookingDate.fromJson(dateJson))
          .toList(),
    );
  }

  @override
  void setId(String id) {
    this.id = id;
    // TODO: implement setId
  }
}

class BookingDate {
  final String date;
  final bool isDone;

  BookingDate({required this.date, required this.isDone});

  // Convert BookingDate to JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'isDone': isDone,
    };
  }

  // Create BookingDate from JSON
  factory BookingDate.fromJson(Map<String, dynamic> json) {
    return BookingDate(
      date: json['date'],
      isDone: json['isDone'],
    );
  }
}
