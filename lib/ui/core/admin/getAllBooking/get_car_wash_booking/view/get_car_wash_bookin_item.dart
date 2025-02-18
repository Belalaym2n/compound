import 'package:flutter/material.dart';
import 'package:qr_code/ui/core/ui/sharedWidgets/build_order_infor.dart';

import '../../../../../../domain/models/booking_model.dart';
import '../../../../../../utils/app_colors.dart';

class GetCarWashBookingItem extends StatefulWidget {
  GetCarWashBookingItem(
      {super.key,
      required this.bookingModel,
      required this.makeOrderDone,
      required this.isDone});

  Booking bookingModel;

  Function() makeOrderDone;
  bool isDone;

  // List<BookingDate> selectedDates;
  @override
  State<GetCarWashBookingItem> createState() => _GetCarWashBookingItemState();
}

class _GetCarWashBookingItemState extends State<GetCarWashBookingItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Container(
          decoration: BoxDecoration(
            gradient: widget.isDone == true
                ? LinearGradient(
                    colors: [Colors.green, Colors.green],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : LinearGradient(
                    colors: [Colors.white, Colors.grey[200]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Text(
                widget.bookingModel.bookingType.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widget.isDone == true ? Colors.white : Colors.black87,
                ),
              ),
            ),
            Divider(
                thickness: 1,
                color: widget.isDone == true ? Colors.white : Colors.grey),

            // Compound Name
            buildOrderInfoRow(
              icon: Icons.location_city,
              label: 'Compound',
              value: widget.bookingModel.compound ?? 'un known',
              idDone: widget.isDone,
            ),
            buildOrderInfoRow(
                idDone: widget.isDone,
                icon: Icons.email,
                label: 'Email',
                value: widget.bookingModel.email ?? 'un known'),

            // User Phone
            buildOrderInfoRow(
              icon: Icons.phone,
              label: 'Phone',
              value: widget.bookingModel.phoneNumber ?? 'un known',
              idDone: widget.isDone,
            ),
            buildOrderInfoRow(
              icon: Icons.phone,
              label: 'name',
              value: widget.bookingModel.name ?? 'un known',
              idDone: widget.isDone,
            ),
            buildOrderInfoRow(
              redText: true,
              icon: Icons.phone,
              label: 'price',
              value: widget.bookingModel.price ?? 'un known',
              idDone: widget.isDone,
            ),
            buildOrderInfoRow(
              redText: true,
              icon: Icons.phone,
              label: 'is paid ?',
              value: widget.bookingModel.isPaid ?? 'un known',
              idDone: widget.isDone,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {
                  widget.isDone == true ? SizedBox() : widget.makeOrderDone();
                },
                //  onPressed:
                icon: Icon(
                  Icons.account_balance_wallet,
                  size: 16,
                  color:
                      widget.isDone == true ? AppColors.primary : Colors.white,
                ),
                label: Text(
                  'Mark as Done',
                  style: TextStyle(
                      color: widget.isDone == true
                          ? AppColors.primary
                          : Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      widget.isDone == true ? Colors.white : AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ])),
    );
  }
}
