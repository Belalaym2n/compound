class ForRentmodel{
  final  image;
  String tittle;
  String description;

  ForRentmodel({required this.image,required this.tittle,required this.description});
  Map<String,dynamic>toJson(){
    return{
      'image':image,
      'tittle':tittle,
      'description':description,
    };
  }
  ForRentmodel.fromJson(Map<String, dynamic> json)
      : this(
    tittle: json['tittle'] as String,
    image: json['image'] ,
    description: json['description'] as String,
  );

}