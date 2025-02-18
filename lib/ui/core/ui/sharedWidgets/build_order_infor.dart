import 'package:flutter/material.dart';

Widget buildOrderInfoRow({
  required IconData icon,
  required String label,
  required String value,
  required bool idDone,
  bool? redText,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon,
            size: 20, color: idDone == true ? Colors.white : Colors.blueGrey),
        const SizedBox(width: 8),
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: idDone == true ? Colors.white : Colors.black87,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: idDone == true && redText == true
                  ? Colors.pink
                  : idDone == true
                      ? Colors.white
                      : Colors.black54,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
