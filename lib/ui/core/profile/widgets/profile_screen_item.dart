import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/constants.dart';

class ProfileScreenItem extends StatefulWidget {
  const ProfileScreenItem({super.key});

  @override
  State<ProfileScreenItem> createState() => _ProfileScreenItemState();
}

class _ProfileScreenItemState extends State<ProfileScreenItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: Constants.screenHeight * 0.22,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(Constants.screenWidth * 0.06),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Constants.screenHeight * 0.1),
                Center(child: _buildProfileIcon()),
                SizedBox(height: Constants.screenHeight * 0.01),
                _buildUserName(),
                SizedBox(height: Constants.screenHeight * 0.01),
                _buildEmail(),
                SizedBox(height: Constants.screenHeight * 0.02),
                _buildDataProfile(
                  icon: Icons.phone,
                  dataName: 'Phone Number',
                  nameColor: AppColors.textPrimary,
                  existExpanded: true,
                  index: 1,
                ),
                _buildDataProfile(
                  icon: Icons.location_on,
                  dataName: 'Address',
                  nameColor: AppColors.textPrimary,
                  existExpanded: true,
                  index: 2,
                ),
                _buildDataProfile(
                  icon: Icons.support_agent,
                  dataName: 'Support',
                  nameColor: AppColors.textPrimary,
                  existExpanded: true,
                  index: 3,
                ),
                _buildDataProfile(
                  icon: Icons.delete,
                  dataName: 'Delete Account',
                  nameColor: Colors.red,
                  existExpanded: false,
                  index: 4,
                ),
                _buildDataProfile(
                  icon: Icons.logout,
                  dataName: 'Logout',
                  nameColor: Colors.red,
                  existExpanded: false,
                  index: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserName() {
    return Text(
      "Belal Ayman",
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: Constants.screenWidth * 0.065,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildProfileIcon() {
    return Container(
      width: Constants.screenWidth * 0.4,
      height: Constants.screenWidth * 0.4,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 4),
        color: AppColors.lightBlack,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        Icons.person,
        size: Constants.screenWidth * 0.2,
        color: Colors.white,
      ),
    );
  }

  Widget _buildEmail() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Constants.screenWidth * 0.05,
        vertical: Constants.screenHeight * 0.008,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(Constants.screenWidth * 0.03),
      ),
      child: Text(
        "belalscg@gmail.com",
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: Constants.screenWidth * 0.04,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildDataProfile({
    required int index,
    required Color nameColor,
    required bool existExpanded,
    required IconData icon,
    required String dataName,
  }) {
    return SlideInUp(
      duration: Duration(milliseconds: 400 + index * 100),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(
          vertical: Constants.screenHeight * 0.01,
          horizontal: Constants.screenWidth * 0.05,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: Constants.screenWidth * 0.04,
        ),
        height: Constants.screenHeight * 0.075,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: nameColor, size: Constants.screenWidth * 0.065),
            SizedBox(width: Constants.screenWidth * 0.04),
            Expanded(
              child: Text(
                dataName,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Constants.screenWidth * 0.045,
                  color: nameColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (existExpanded)
              Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.primary,
                size: Constants.screenWidth * 0.06,
              ),
          ],
        ),
      ),
    );
  }
}
