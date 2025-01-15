import 'package:flutter/material.dart';
import 'package:qr_code/domain/models/showCatModel.dart';
import 'package:qr_code/utils/app_colors.dart';
import 'package:qr_code/utils/constants.dart';

class CatItem extends StatefulWidget {
  const CatItem({Key? key}) : super(key: key);

  @override
  State<CatItem> createState() => _CatItemState();
}

class _CatItemState extends State<CatItem> with TickerProviderStateMixin {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final List<ShowCatModel> data = ShowCatModel.getData(context);

    return Column(
      children: [
        SizedBox(
          height: Constants.screenHeight * 0.24,
          child: GridView.builder(
            itemCount: data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisExtent: 90, // Height of each grid item
              crossAxisSpacing: 0,
            ),
            itemBuilder: (context, index) {
              return _buildServiceWidget(
                onTap: () {
                  data[index].function();
                },
                serviceName: data[index].text,
                icon: data[index].iconData,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildServiceWidget({
    // required bool isSelected,
    required String serviceName,
    required IconData icon,
    required Function onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: SizedBox(
          height: 100, // Fixed height
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIcon(icon: icon),
              SizedBox(
                height: Constants.screenHeight * 0.01,
              ),
              _buildText(serviceName: serviceName),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText({
    required String serviceName,
  }) {
    return Text(
      serviceName,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w700,
        fontSize: Constants.screenWidth * 0.03,
        fontFamily: 'Roboto',
      ),
    );
  }

  Widget _buildIcon({required IconData icon}) {
    return Container(
      width: Constants.screenWidth * 0.14,
      height: Constants.screenHeight * 0.07,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        // boxShadow: [
        //   if (isSelected)
        //     const BoxShadow(
        //       color: Colors.black26,
        //       blurRadius: 10,
        //       offset: Offset(0, 4),
        //     ),
        // ],
      ),
      child: Icon(icon,
          size: Constants.screenWidth * 0.1, color: AppColors.primary),
    );
  }
}
