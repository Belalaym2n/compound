import 'package:flutter/material.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/constants.dart';
import '../../../ui/sharedWidgets/success_widget.dart';
import 'buildInputField.dart';
import 'buildSubmitProblem.dart';

class AddProblemItem extends StatefulWidget {
  AddProblemItem(
      {super.key,
      required this.problemController,
      required this.isLoading,
      required this.isDone,
      required this.submitProblem});

  TextEditingController problemController;
  Function submitProblem;
  bool isLoading;
  bool isDone;

  @override
  State<AddProblemItem> createState() => _AddProblemItemState();
}

class _AddProblemItemState extends State<AddProblemItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..forward();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(0.0, 0.1), end: Offset.zero)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  )),
              title: Text(
                "Problems",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: Constants.screenWidth * 0.062,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: AppColors.primary,
              elevation: 0,
            ),
            body: widget.isDone == false
                ? Padding(
                    padding: EdgeInsets.all(Constants.screenWidth * 0.04),
                    child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                            position: _slideAnimation,
                            child: SingleChildScrollView(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                  Text(
                                    "Write  down your  problem  details :",
                                    style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: Constants.screenWidth * 0.047,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                      height: Constants.screenHeight * 0.012),
                                  buildInputField(
                                      position: _slideAnimation,
                                      controller: widget.problemController,
                                      hint: "Enter your problem",
                                      label: "Enter your problem"),
                                  SizedBox(
                                      height: Constants.screenHeight * 0.012),
                                  buildSubmitButton(
                                      isLoading: widget.isLoading,
                                      position: _slideAnimation,
                                      submitProblem: () {
                                        widget.submitProblem();
                                      })
                                ])))))
                : done_order_widget(context)));
  }
}
