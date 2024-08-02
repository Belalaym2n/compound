import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/models/messageModel.dart';
import 'package:qr_code/screens/chat/viewModel_shat.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/widgets.dart';

class ChatScreen extends StatefulWidget {
  String id;
  String senderId;

  ChatScreen({
    super.key,
    required this.id,
    required this.senderId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

double screenHeight = 0;
double screenWidth = 0;
TextEditingController controller = TextEditingController();

class _ChatScreenState extends State<ChatScreen> {
  ViewModelChat viewModelChat = ViewModelChat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    double screen = screenHeight * 0.8;
    final firestore = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        toolbarHeight: screenHeight * 0.11,
        flexibleSpace: gotToChat(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            userid: widget.id.toString(),
            function: () {}),
      ),
      body: ChangeNotifierProvider(
        create: (context) => viewModelChat,
        builder: (context, child) => Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: viewModelChat.getMessage(
                    conversationId: widget.id.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No messages yet.'));
                  }

                  final messages = snapshot.data!.docs;

                  return ListView.builder(

                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final messageData =
                          messages[index].data() as Map<String, dynamic>;
                      return
                        ListTile(
                        title: widget.senderId == messageData['senderId']
                            ?
                        Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.
                                    circular(12)),
                                child: Text(
                                  messageData['message'],
                                  style: TextStyle(color:
                                  Colors.black),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Text(
                                  messageData['message'],
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),

                        subtitle: Text('Sent by: ${messageData['senderId']}'),
                      );
                    },
                  );
                },
              ),
            ),
            keyBoardMessage(),
            SizedBox(
              height: screenHeight * 0.02,
            )
          ],
        ),
      ),
    );
  }

  keyBoardMessage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: screenHeight * 0.07,
      width: screenWidth,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,

              decoration: InputDecoration(
                  icon: IconButton(
                      onPressed: () {
                        viewModelChat.sendMessageTo(
                            senderId: widget.senderId.toString(),
                            message: controller.text,
                            id: widget.id.toString());
                        controller.clear();
                      },
                      icon: Icon(Icons.send)),
                  filled: true,
                  fillColor: Colors.grey,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.white)),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: screenHeight / 35,
                  ),
                  border: InputBorder.none,
                  hintText: "  Type Your message",
                  hintStyle: TextStyle(
                    color: Colors.black,
                  )),

              //   maxLines: 1,
              obscureText: false,
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.image)),
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.mic)),
        ],
      ),
    );
  }
}
