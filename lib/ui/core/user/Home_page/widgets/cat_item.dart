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
  int selectedIndex = -1; // لتحديد العنصر المختار

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _controller.forward(); // بدء الأنيميشن فور الدخول
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<ShowCatModel> data = ShowCatModel.getData(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeTransition(
          opacity: _controller,
          child: SizedBox(
            height: Constants.screenHeight * 0.26,
            child: GridView.builder(
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: Constants.screenHeight * 0.112,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                return _buildCategoryCard(
                  onTap: data[index].function,
                  serviceName: data[index].text,
                  icon: data[index].iconData,
                  index: index,
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard({
    required Function onTap,
    required String serviceName,
    required IconData icon,
    required int index,
  }) {
    final Animation<double> animation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.1 * index, 1.0, curve: Curves.easeOut),
    ));

    return ScaleTransition(
      scale: animation,
      child: InkWell(
        onTap: () => onTap(),
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Constants.screenWidth * 0.03),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildIcon(icon),
                SizedBox(height: Constants.screenHeight * 0.01),
                _buildServiceText(serviceName),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// تصميم الأيقونة مع تأثيرات
  Widget _buildIcon(IconData icon) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: Constants.screenWidth * 0.2,
      height: Constants.screenHeight * 0.07,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        icon,
        size: Constants.screenWidth * 0.12,
        color: AppColors.primary,
      ),
    );
  }

  /// تصميم النص الخاص بالخدمة
  Widget _buildServiceText(String serviceName) {
    return Text(
      serviceName,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w700,
        fontSize: Constants.screenWidth * 0.03,
        fontFamily: 'Roboto',
      ),
    );
  }
}
