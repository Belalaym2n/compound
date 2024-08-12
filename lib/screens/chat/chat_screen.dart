import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/screens/chat/viewModel_shat.dart';

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
        elevation: 0,
        backgroundColor: Colors.white,
         scrolledUnderElevation: 0,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        toolbarHeight: screenHeight * 0.11,
        flexibleSpace: gotToChat(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            userid: widget.id.toString(),
            function: () {

            }),
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

                  return Expanded(
                    child: ListView.builder(

                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {

                        final messageData =
                            messages[index].data()
                            as Map<String, dynamic>;
                        String timestamp=messageData['timestamp'];
                        DateTime dateTime=DateTime.parse(timestamp);
                        String formattedTime = DateFormat.Hm().
                        format(dateTime);
                        return Row(
                          mainAxisAlignment: widget.senderId==
                              messageData['senderId']?
                          MainAxisAlignment.end:MainAxisAlignment.start,
                                    children: [


                                      Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: Row(
                                            children: [

                                              ConstrainedBox(
                                                  constraints: BoxConstraints(
                                                    maxWidth: screenWidth * 0.8,
                                                  ),

                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color:widget.senderId==
                                                            messageData['senderId']?Color(0xFFF1F1F1):
                                                        Colors.blue,
                                                        borderRadius:
                                                        BorderRadius.circular(10)),
                                                    child:

                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                    messageData['image'].toString().isNotEmpty?
                                                        Container(
                                                          child: Image.network(

                                                            messageData['image'],
                                                            loadingBuilder:(context, child, loadingProgress) {
                                                              if(loadingProgress==null)return child;
                                                              return Center(
                                                                child: CircularProgressIndicator(
                                                                  
                                                                ),
                                                              );
                                                            },),
                                                        ):Text(
                                                      "  ${messageData['message']}  ",
                                                      style:
                                                      TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: screenWidth*0.046,

                                                          color:widget.senderId==

                                                              messageData['senderId']?Colors.black:
                                                          Colors.black),
                                                    ),
                                                        Text(
                                                          "  $formattedTime  ",
                                                          style:
                                                          TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: screenWidth*0.03,

                                                              color:widget.senderId==

                                                                  messageData['senderId']?Colors.black:
                                                              Colors.black),
                                                        ),
                                                      ],
                                                    ),

                                                  )

                                              ),

                                            ]),
                                      )
                                    ]);
                      },
                    ),
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

      //eight: screenHeight * 0.07,
    //  width: screenWidth,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              maxLines: null,

        scribbleEnabled: true,


              //scrollPhysics: AlwaysScrollableScrollPhysics(),
              textAlign: TextAlign.center,
              //autofocus: true,
              controller: controller,

              decoration: InputDecoration(
                  icon: IconButton(
                      onPressed: () {
                        controller.text.isNotEmpty?
                      viewModelChat.sendMessageTo(

                            senderId: widget.senderId.toString(),
                            message: controller.text,
                            id: widget.id.toString(), image: '',
                         // image: ''
                        ):print("is empty");
                        controller.clear();
                        },
                      icon:
                      Icon(Icons.send,color:

                      Colors.blue)),
                  filled: true,

                  fillColor: Color(0xFFF1F1F1),

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
                  )
              ),

              //   maxLines: 1,
              obscureText: false,
            ),
          ),
          IconButton(onPressed: () async {
            viewModelChat.openGallery(widget.id,widget.senderId);
          }, icon: Icon(Icons.image)),
       //   IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.mic)),
        ],
      ),
    );
  }
}
