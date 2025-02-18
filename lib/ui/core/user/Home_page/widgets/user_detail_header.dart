import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../data/services/shared_pref_helper.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/constants.dart';

class UserDetailHeader extends StatefulWidget {
  const UserDetailHeader({super.key});

  @override
  State<UserDetailHeader> createState() => _UserDetailHeaderState();
}

class _UserDetailHeaderState extends State<UserDetailHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Constants.screenWidth * 0.067),
          bottomRight: Radius.circular(Constants.screenWidth * 0.067),
        ),
      ),
      height: Constants.screenHeight * 0.2,
      width: Constants.screenWidth,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.04),
        child: Column(
          children: [
            SizedBox(
              height: Constants.screenHeight * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TweenAnimationBuilder(
                      tween: Tween<Offset>(
                        begin: const Offset(-1, 0), // Start from left
                        end: const Offset(0, 0), // End at original position
                      ),
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeOut,
                      builder: (context, offset, child) {
                        return Transform.translate(
                          offset: Offset(Constants.screenWidth * offset.dx, 0),
                          // Animation
                          child: child,
                        );
                      },
                      child: Text(
                        'Hello Owner :',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Constants.screenWidth * 0.032,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Constants.screenHeight * 0.007,
                    ),
                    TweenAnimationBuilder(
                      tween: Tween<Offset>(
                        begin: const Offset(-1, 0),
                        end: const Offset(0, 0),
                      ),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeOut,
                      builder: (context, offset, child) {
                        return Transform.translate(
                          offset: Offset(Constants.screenWidth * offset.dx, 0),
                          // Animation
                          child: child,
                        );
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: Constants.screenWidth * 0.02),
                        child: (SharedPreferencesHelper.name ?? "").isEmpty
                            ? textLoading()
                            : Text(
                                SharedPreferencesHelper.name.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Constants.screenWidth * 0.036,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),

                // Right Side Animations (Profile Icon)
                TweenAnimationBuilder(
                  tween: Tween<Offset>(
                    begin: const Offset(1, 0), // Start from right
                    end: const Offset(0, 0), // End at original position
                  ),
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeOut,
                  builder: (context, offset, child) {
                    return Transform.translate(
                      offset: Offset(
                          Constants.screenWidth * offset.dx, 0), // Animation
                      child: child,
                    );
                  },
                  child: InkWell(
                    onTap: () async {
                      Scaffold.of(context).openDrawer();
                      //await SharedPreferencesHelper.clearAll();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ProfileScreenItem(),
                      //   ),
                      // );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        size: Constants.screenWidth * 0.075,
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Constants.screenHeight * 0.02,
            ),

            // Bottom Text Animation
            TweenAnimationBuilder(
              tween: Tween<Offset>(
                begin: const Offset(1, 0), // Start from right
                end: const Offset(0, 0), // End at original position
              ),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOut,
              builder: (context, offset, child) {
                return Transform.translate(
                  offset: Offset(Constants.screenWidth * offset.dx, 0),
                  child: child,
                );
              },
              child: Container(
                height: Constants.screenHeight * 0.05,
                width: Constants.screenWidth * 0.8,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Constants.screenWidth * 0.033),
                  color: const Color(0xFFf3f7fa),
                ),
                child: Center(
                  child: Text(
                    "MAS Facility Management",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      fontSize: Constants.screenWidth * 0.036,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  textLoading() {
    return const Skeletonizer(child: Text("Belal Ayman"));
  }
}
