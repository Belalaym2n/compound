import 'package:flutter/material.dart';

class StoresScreen extends StatelessWidget {
  StoresScreen({super.key});

  double screenHeight = 0;

  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("All Stores"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return stores_widget();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget stores_widget() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        child: InkWell(
            onTap: () {},
            child: Material(
              elevation: 5,
              child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      color: Colors.white),
                  child: Row(children: [
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Icon(
                            Icons.store,
                            size: screenWidth * 0.1,
                          )),
                    ),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: screenHeight * 0.02,
                            ),
                            Text(
                              "@Go Super Market",
                              style: TextStyle(
                                  color: const Color(0xFF000000),
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.w800),
                              maxLines: 1,
                            ),
                          ],
                        ))
                  ])),
            )));
  }
}
