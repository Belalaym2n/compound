import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../get_all_forRent/rent_details.dart';
import '../notification_screen/notification_screen.dart';

notificationItem({
  required String tittle,
  String? imageUrl,
  required double screenHeight,
  required double screenWidth,
  required String description,
  required BuildContext context,
}) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationScreen(
                tittle: tittle, imageUrl: imageUrl, description: description),
          ));
    },
    child: Material(
      //elevation: 30,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Material(
          borderRadius: BorderRadius.circular(12),
          elevation: 20,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white38,
            ),
            width: screenWidth,
            height: screenHeight * 0.12,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl!,
                      width: screenWidth * 0.3,
                      height: screenHeight * 0.12,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print(error);
                        // Display a placeholder image if the network image fails to load
                        return Icon(
                          Icons.error,
                          size: 50,
                          color: AppColors.primary,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.01,
                  height: screenHeight * 0.02,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      tittle.length > 20 ? tittle.substring(0, 20) : tittle,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                        description.length > 20
                            ? description.substring(0, 20)
                            : description,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.black, fontSize: screenWidth * 0.03))
                  ],
                ),
                SizedBox(
                  width: screenWidth * 0.1,
                ),
                Expanded(
                    child: Icon(
                  Icons.notification_important,
                  color: Colors.red,
                  size: screenWidth * 0.1,
                ))
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

products({
  required String? tittle,
  required String? imageUrl,
  required String? description,
  required BuildContext context,
  required double screenHeight,
  required double screenWidth,
}) =>
    InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RentDetails(
                  tittle: tittle,
                  imageUrl: imageUrl ?? '',
                  description: description),
            ));
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: const EdgeInsets.only(left: 12, top: 16, right: 12),
          child: Material(
            borderRadius: BorderRadius.circular(12),
            elevation: 30,
            //shadowColor: AppColors.primary,
            child: Container(
              width: screenWidth,
              decoration: BoxDecoration(
                  // border: Border.all(color: AppColors.primary,width: 2),
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: screenWidth,
                      height: screenHeight * 0.14,
                      clipBehavior: Clip.antiAlias,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                        ),
                      ),
                      child: CachedNetworkImage(
                        width: screenWidth,
                        // set image not exist
                        imageUrl: imageUrl ?? '',
                        fit: BoxFit.fill,

                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      tittle ?? '',
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          fontSize: screenWidth * 0.03),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: screenWidth * 0.3,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            description!.length < 20
                                ? description ?? ""
                                : description.substring(0, 20) ?? '',
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth * 0.03),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.ads_click,
                        color: AppColors.primary,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
