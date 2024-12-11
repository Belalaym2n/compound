import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';
import '../../get_all_forRent/widgets/rent_details.dart';

products({
  required String? tittle,
  required String? imageUrl,
  required String? description,
  required BuildContext context,
  required double screenHeight,
  required double screenWidth,
}) =>
    SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black54, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.only(left: 12, top: 16, right: 12),
        child: Material(
          borderRadius: BorderRadius.circular(12),
          // elevation: 30,
          //shadowColor: AppColors.primary,
          child: Container(
            width: screenWidth,
            decoration: BoxDecoration(
                // border: Border.all(color: AppColors.primary,width: 2),
                borderRadius: BorderRadius.circular(screenWidth * 0.016)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: screenWidth,
                    height: screenHeight * 0.12,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.016),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Text(
                        tittle ?? '',
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.04),
                      ),
                    ),
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
                      child: Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(screenWidth * 0.36, 10),
                                backgroundColor: AppColors.primary,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RentDetails(
                                          tittle: tittle,
                                          imageUrl: imageUrl ?? '',
                                          description: description),
                                    ));
                              },
                              child: Text(
                                "See Details",
                                style: TextStyle(color: Colors.white),
                              ))),
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
