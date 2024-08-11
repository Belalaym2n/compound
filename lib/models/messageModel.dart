class MessageModel{
  String message;
  String image;
  String name;
  String senderId;
  String timestamp;
  MessageModel({required this.message,
    required this.timestamp,
    required this.image,
    required this.name,required this.senderId});

  Map<String,dynamic>toJson(){
    return {
      'message':message,
      'image':image,
      'name':name,
      "senderId":senderId,
      "timestamp":timestamp,
    };
  }


}
