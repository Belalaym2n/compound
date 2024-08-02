class MessageModel{
  String message;
  String name;
  String senderId;
  String timestamp;
  MessageModel({required this.message,
    required this.timestamp,required this.name,required this.senderId});

  Map<String,dynamic>toJson(){
    return {
      'message':message,
      'name':name,
      "senderId":senderId,
      "timestamp":timestamp,
    };
  }


}
