import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_images.dart';
import 'getAllUsersViewModel.dart';

class AllUsersSentMessage extends StatefulWidget {
  const AllUsersSentMessage({super.key});

  @override
  State<AllUsersSentMessage> createState() => _AllUsersSentMessageState();
}

double screenHeight = 0;
double screenWidth = 0;

class _AllUsersSentMessageState extends State<AllUsersSentMessage> {
  GetAllUserViewModel viewModel = GetAllUserViewModel();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_forward_sharp,
          color: Colors.white,
          size: 0,
        ),
        centerTitle: true,
        toolbarHeight: screenHeight * 0.09,
        flexibleSpace: Center(
          child: search(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: viewModel.getMessage(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                          child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(),
                      ));
                    }
                    if (!snapshot.hasData) {
                      return const Center(child: Text('No messages yet.'));
                    }

                    final name =
                        snapshot.data!.docs.map((doc) => doc['name']).toList();
                    final lastMessage = snapshot.data!.docs
                        .map((e) => e['lastMessage'])
                        .toList();

                    final dateTimeNow =
                        snapshot.data!.docs.map((e) => e['DataTime']).toList();

                    return ListView.builder(
                      reverse: false,
                      itemCount: name.length,
                      itemBuilder: (context, index) {
                        return Expanded(
                            child: UsersMessages(
                                lastMessage: lastMessage[index].toString(),
                                screenWidth: screenWidth,
                                screenHeight: screenHeight,
                                userid: name[index].toString(),
                                function: () {}));
                      },
                    );
                  })),
        ],
      ),
    );
  }

  UsersMessages({
    required double screenWidth,
    required Function function,
    required double screenHeight,
    required String userid,
    required String lastMessage,
  }) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        child: InkWell(
          onTap: () {
            function();
          },
          child: Container(
            width: screenWidth,
            height: screenHeight * 0.1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                color: const Color(0xFFF1F1F1)),
            child: Row(children: [
              SizedBox(
                width: screenWidth * 0.02,
              ),
              Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Icon(
                    Icons.person,
                    size: screenWidth * 0.15,
                  ),
                ),
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
                      userid.length > 10 ? userid.substring(0, 10) : userid,
                      style: TextStyle(
                          color: const Color(0xFF000000),
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w800),
                      maxLines: 1,
                    ),
                    Text(
                      lastMessage.length > 10
                          ? lastMessage.substring(0, 10)
                          : lastMessage,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: screenWidth * 0.03,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),
                      Center(
                        child: Text(
                          "12:00 PM   ",
                          style: TextStyle(
                              color: const Color(0xFF000000),
                              fontSize: screenWidth * 0.03,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ),
        ));
  }

  search() {
    return Column(
      children: [
        SizedBox(
          height: screenHeight * 0.05,
        ),
        Row(
          children: [
            SizedBox(
              width: screenWidth * 0.07,
            ),
            Center(
              child: SizedBox(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.05,
                  child: Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          //filled: true,
                          //fillColor: Colors.grey,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: screenHeight / 60,
                          ),
                          border: InputBorder.none,
                          hintText: "Search For User",

                          //  hintTextDirection: TextDirection.ltr,
                          hintStyle: const TextStyle(
                            color: Colors.black,
                          )),

                      //   maxLines: 1,
                      obscureText: false,
                    ),
                  )),
            ),
            Image.asset(
              AppImages.logoImage,
              width: screenWidth * 0.1,
              color: Colors.black,
              fit: BoxFit.cover,
              height: screenHeight * 0.07,
            )
          ],
        ),
      ],
    );
  }
}
