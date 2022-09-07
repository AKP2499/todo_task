import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  addTodo(Todo todo) async{
   await FirebaseFirestore.instance.collection("todo").doc(_titleController.text).set(todo.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: const Text("TODO TASK APP"),
        ),
        body:  ListOfTask(),
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
                      height: MediaQuery.of(context).size.height * 0.5,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Column(
                        children: [
                          TextField(
                            controller: _titleController
                            ,
                          ),
                          TextField(
                            controller: _decriptionController,
                          ),

                        ],

                      ),
                    ),
                    actions: <Widget>[
                      TextButton(onPressed: (){
                        print("+++++++++++++++++++++++++++++++++++");
                        addTodo(
                            Todo(
                              title: _titleController.text,
                              description: _decriptionController.text,
                              isDone: false,
                            )
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
