
class Todo {
  String title;
  String? description;
  bool? isDone;
  String? id;

  Todo({
   required this.title,
    this.description,
    this.id,
    this.isDone =false,
  });
  static Todo fromJson(Map<String,dynamic>json)=> Todo(
    title: json['title'],
    description: json['description'],
    id: json['id'],
    isDone: json['isDone'],

  );
  Map<String, dynamic> toJson() => {
    'title':title,
    'description':description,
    'isDone':isDone,
    'id':id,
  };
}