import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/constants.dart';

Widget add_note_widget(BuildContext context) {
  final FocusNode _focusNode = FocusNode();

  return SafeArea(
    // Ensures the widget isn't covered by system UI
    child: SingleChildScrollView(
      // Allow scrolling when keyboard appears
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      // Dismiss keyboard on drag
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context)
              .viewInsets
              .bottom, // Automatically adjusts to the keyboard's height
        ),
        child: Material(
          borderRadius: BorderRadius.circular(Constants.screenWidth * 0.015),
          elevation: 8,
          child: Container(
            padding: EdgeInsets.all(Constants.screenWidth * 0.05),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.primary, width: 1.5),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.edit_note,
                  color: AppColors.subTitleTextColor,
                  size: Constants.screenWidth * 0.07,
                ),
                SizedBox(
                  width: Constants.screenWidth * 0.03,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Focus the TextField when tapped
                      FocusScope.of(context).requestFocus(_focusNode);
                    },
                    child: TextField(
                      focusNode: _focusNode, // Assign the FocusNode
                      decoration: const InputDecoration(
                        hintText: "Add Note",
                        hintStyle: TextStyle(
                          color: AppColors.subTitleTextColor,
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                      maxLines: 5,
                      style: TextStyle(
                        color: AppColors.lightBlack,
                        fontSize: Constants.screenWidth * 0.041,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
