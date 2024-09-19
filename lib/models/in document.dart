class LastMessageModel {
  String lastMessage;
  String name;
  String DateTime;

  LastMessageModel(this.lastMessage, this.name, this.DateTime);

  Map<String, dynamic> toJson() {
    return {'name': name, 'lastMessage': lastMessage, 'DataTime': DateTime};
  }
}
