class TaskModel {
  String tittle;
  String description;
  String id;
  bool isDone;
  int date;
  String userUid;


  TaskModel(
      {required this.tittle,
        required this.description,
        required this.userUid,
        this.id = '',
        this.isDone = false,
        required this.date});

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
    description: json['description'],
    tittle: json['tittle'],
    userUid: json['userUid'],
    date: json['date'],
    id: json['id'],
    isDone: json['isDone'],
  );

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'tittle': tittle,
      'userUid': userUid,
      'date': date,
      'id': id,
      'isDone': isDone,
    };
  }
}