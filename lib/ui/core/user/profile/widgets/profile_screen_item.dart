import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:qr_code/config/routes.dart';
import 'package:qr_code/data/services/shared_pref_helper.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/constants.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileScreenItem extends StatefulWidget {
  const ProfileScreenItem({super.key});

  @override
  State<ProfileScreenItem> createState() => _ProfileScreenItemState();
}

class _ProfileScreenItemState extends State<ProfileScreenItem> {
  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper.init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5), // خلفية فاتحة ومريحة للعين
      height: Constants.screenHeight,
      child: Padding(
        padding: EdgeInsets.all(Constants.screenWidth * 0.05),
        child: AnimationLimiter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: AnimationConfiguration.toStaggeredList(
              duration: const Duration(milliseconds: 700),
              childAnimationBuilder: (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: widget,
                ),
              ),
              children: [
                SizedBox(height: Constants.screenHeight * 0.04),
                drawerData(
                    onTap: () {},
                    name: SharedPreferencesHelper.name.toString(),
                    icon: Icons.people,
                    iconColor: AppColors.primary),
                SizedBox(height: Constants.screenHeight * 0.04),
                drawerData(
                    onTap: () {},
                    name: SharedPreferencesHelper.email.toString(),
                    icon: Icons.mark_email_unread_outlined,
                    iconColor: AppColors.primary),
                SizedBox(height: Constants.screenHeight * 0.04),
                drawerData(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.addProblem);
                    },
                    name: "Send Problem",
                    icon: Icons.report_problem,
                    iconColor: Colors.red),
                SizedBox(height: Constants.screenHeight * 0.04),
                drawerData(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.login);
                      SharedPreferencesHelper.clearAll();
                    },
                    widgetIcon: icon_widget(icon: Icons.login_outlined),
                    name: "Logout",
                    iconColor: Colors.red),
                SizedBox(height: Constants.screenHeight * 0.04),
                drawerData(
                    widgetIcon: icon_widget(icon: Icons.login_outlined),
                    name: "Delete Account",
                    onTap: () async {
                      await deleteAccount();
                      Navigator.pushNamed(context, AppRoutes.login);
                      SharedPreferencesHelper.clearAll();
                    },
                    iconColor: Colors.red),
                SizedBox(height: Constants.screenHeight * 0.04),
                drawerData(
                  onTap: () {
                    Scaffold.of(context).closeDrawer();
                  },
                  name: "Close",
                  iconColor: Colors.red,
                  widgetIcon: icon_widget(icon: Icons.close),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> deleteAccount() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String uid = user.uid;
        await FirebaseFirestore.instance.collection('Owners').doc(uid).delete();
        await user.delete();
      }
    } catch (e) {
      print("Error deleting account: $e");
    }
  }

  icon_widget({required IconData icon}) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
      child: Icon(
        textDirection: TextDirection.ltr,
        weight: 23,
        icon,
        color: Colors.white,
        size: Constants.screenWidth * 0.05,
      ),
    );
  }

  Widget drawerData({
    IconData? icon,
    required String name,
    required Color iconColor,
    Widget? widgetIcon,
    Function? onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Row(
        children: [
          icon != null
              ? Icon(
                  icon,
                  size: Constants.screenWidth * 0.07,
                  color: iconColor,
                )
              : widgetIcon!,
          SizedBox(width: Constants.screenWidth * 0.05),
          (name.toString() ?? '').isEmpty
              ? textLoading()
              : Text(
                  name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: Constants.screenWidth * 0.045,
                  ),
                ),
        ],
      ),
    );
  }

  textLoading() {
    return const Skeletonizer(child: Text("Belal Ayman"));
  }
}
