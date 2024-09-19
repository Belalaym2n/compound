import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_code/screens/common_screen/chat/viewModel_shat.dart';

import '../../../utils/widgets.dart';

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
    viewModelChat.checkIsUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        toolbarHeight: screenHeight * 0.11,
        flexibleSpace: gotToChat(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            userid: viewModelChat.checkIsUser() != null
                ? "Admin"
                : widget.id.toString(),
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
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No messages yet.'));
                  }

                  final messages = snapshot.data!.docs;

                  return Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final messageData =
                            messages[index].data() as Map<String, dynamic>;
                        String timestamp = messageData['timestamp'];
                        DateTime dateTime = DateTime.parse(timestamp);
                        String formattedTime = DateFormat.Hm().format(dateTime);
                        return Row(
                            mainAxisAlignment:
                                widget.senderId == messageData['senderId']
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Row(children: [
                                  ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: screenWidth * 0.8,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: widget.senderId ==
                                                    messageData['senderId']
                                                ? const Color(0xFFF1F1F1)
                                                : Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            messageData['image']
                                                    .toString()
                                                    .isNotEmpty
                                                ? CachedNetworkImage(
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                progress) =>
                                                            const CircularProgressIndicator(),
                                                    imageUrl:
                                                        "${messageData['image']}",
                                                  )
                                                : Text(
                                                    "  ${messageData['message']}  ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize:
                                                            screenWidth * 0.046,
                                                        color: widget
                                                                    .senderId ==
                                                                messageData[
                                                                    'senderId']
                                                            ? Colors.black
                                                            : Colors.black),
                                                  ),
                                            Text(
                                              "  $formattedTime  ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: screenWidth * 0.03,
                                                  color: widget.senderId ==
                                                          messageData[
                                                              'senderId']
                                                      ? Colors.black
                                                      : Colors.black),
                                            ),
                                          ],
                                        ),
                                      )),
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
    return Row(
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
                      controller.text.isNotEmpty
                          ? viewModelChat.sendMessageToDatabase(
                              context: context,
                              senderId: widget.senderId.toString(),
                              message: controller.text,
                              id: widget.id.toString(),
                              image: '',
                              // image: ''
                            )
                          : print("is empty");
                      controller.clear();
                    },
                    icon: const Icon(Icons.send, color: Colors.blue)),
                filled: true,
                fillColor: const Color(0xFFF1F1F1),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white)),
                contentPadding: EdgeInsets.symmetric(
                  vertical: screenHeight / 35,
                ),
                border: InputBorder.none,
                hintText: "  Type Your message",
                hintStyle: const TextStyle(
                  color: Colors.black,
                )),

            //   maxLines: 1,
            obscureText: false,
          ),
        ),
        IconButton(
            onPressed: () async {
              viewModelChat.openGallery(widget.id, widget.senderId);
            },
            icon: const Icon(Icons.image)),
        //   IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.mic)),
      ],
    );
  }
}
