class DocumentsField {
  String lastMessage;
  String name;
  String DateTime;

  DocumentsField(this.lastMessage, this.name, this.DateTime);

  Map<String,dynamic>toJson(){
    return {
      'name':name,
      'lastMessage':lastMessage,
      'DataTime':DateTime

    };
  }
}