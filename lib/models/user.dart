class DataScanned{
  String dataScanned;
  String? id;
  DataScanned(this.dataScanned);

  Map<String,dynamic>toJson(){
    return
      {'dataScanned': dataScanned};
  }

}
