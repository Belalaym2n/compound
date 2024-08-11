import 'package:flutter/material.dart';
import 'package:qr_code/screens/login/autoLogin.dart';
import 'package:qr_code/screens/login/login_screen.dart';
import 'package:qr_code/utils/app_colors.dart';



import 'onBageView.dart';
import 'onBoardModel.dart';

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  double screenHeight = 0;
  double screenWidth = 0;
  int currentPage = 0;

  late PageController controller;
  List<OnBoardModel> items = OnBoardModel.items;

  onPageChange(int value){
    currentPage=value;
    setState(() {

    });
  }

  getNextPage(){
    if(currentPage<items.length-1){
      controller.nextPage(duration: const Duration(
        microseconds: 300
      ), curve: Curves.ease, );
    }
    else{
      next();
    }
  }

  next() {

 Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder:
     (context) =>   LoginScreen()),(route) => false,);
}


  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {

    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    String user="belal";
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.white ,
        elevation: 0,
        toolbarHeight: 0,
      ),


      backgroundColor:Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: PageView.builder(
                onPageChanged: onPageChange,
                itemCount: items.length,
                controller: controller,
                itemBuilder: (context, index) {
                  return OnboardingView(
                    data: items[index],
                  );
                },
              ),
            ),
            const Spacer(),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                TweenAnimationBuilder(
                  duration: const Duration(
                    milliseconds: 300
                  ),
                  tween: Tween<double>(
                      begin: 0, end: (1 / items.length) * (currentPage + 1)),
                  curve: Curves.easeInOutBack,
                  builder: (context, double value, _) => SizedBox(
                    height: screenHeight*0.08,
                    width: screenWidth*0.18,
                    child: CircularProgressIndicator(
                      value: value,
                      strokeWidth: 6,
                      backgroundColor:  const Color(0xFFF2F2F2),
                      color:  const Color(0xFF000000),
                    ),
                  ),
                ),
                ElevatedButton(

                  onPressed: getNextPage,
                  style: ElevatedButton.styleFrom(

                      shape: const CircleBorder()),
                  child:const Icon(Icons.arrow_forward,color: Colors.black,size: 22,)
                ),
              ],
            ),
             SizedBox(height:
             screenHeight*0.029
                ),
          ],
        ),
      ),
    );
  }
}
