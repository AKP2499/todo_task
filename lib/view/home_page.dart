

import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_task_misha_infotech/view/widgets/list_widget.dart';

import '../model/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _decriptionController  = TextEditingController();
  ImagePicker picker = ImagePicker();

  addTodo(Todo todo) async{
    await FirebaseFirestore.instance.collection("todo").doc(_titleController.text).set(todo.toJson());
  }
  File selectedProductImage = File("");
  Future<File?> pickImage() async {
    final selected = await picker.getImage(source: ImageSource.gallery);
    if(selected == null){
      return File("");
    }else{
      selectedProductImage = File(selected.path);
    }
  }



  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: const Text("TODO TASK APP"),
        ),
        body:  const ListOfTask(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    title: const Text("Add TODO"),
                    content: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Column(
                        children: [
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: TextField(
                              decoration: const InputDecoration.collapsed(hintText: "Title"),
                              controller: _titleController
                              ,
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: TextField(
                              decoration: const InputDecoration.collapsed(hintText: "Description"),
                              controller: _decriptionController,
                            ),
                          ),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width * 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: (){
                                pickImage();
                              },
                                child: Center(child: const Text("Select Image"))),

                          )
                        ],

                      ),
                    ),
                    actions: <Widget>[
                      TextButton(onPressed: (){
                        addTodo(
                            Todo(
                              title: _titleController.text,
                              description: _decriptionController.text,
                              isDone: false,
                              imageFile: selectedProductImage.path.toString(),
                            ),
                        );
                        Navigator.of(context).pop();
                      }, child: const Text("Add"))
                    ],
                  );
                });
          },
        ),
    );
  }
}
