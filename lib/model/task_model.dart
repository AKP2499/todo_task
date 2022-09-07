
import 'dart:io';
class Todo {
  String title;
  String? description;
  bool? isDone;
  String? id;
  String? imageFile;


  Todo({
   required this.title,
    this.description,
    this.id,
    this.isDone =false,
    this.imageFile,
  });

  static Todo fromJson(Map<String,dynamic>json)=> Todo(
    title: json['title'],
    description: json['description'],
    id: json['id'],
    isDone: json['isDone'],
    imageFile: json['imageFile'],

  );
  Map<String, dynamic> toJson() => {
    'title':title,
    'description':description,
    'isDone':isDone,
    'id':id,
    'imageFile':imageFile,
  };
}