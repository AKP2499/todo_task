
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_task_misha_infotech/model/task_model.dart';

class ListOfTask extends StatelessWidget {
  const ListOfTask({Key? key}) : super(key: key);

  deleteTodo(item){
    DocumentReference documentReference = FirebaseFirestore.instance.collection("todo").doc(item);
    documentReference.delete().whenComplete(() => print("Deleled"));

  }
  updateTodo(update){
    DocumentReference documentReference = FirebaseFirestore.instance.collection('todo').doc(update);
    documentReference.update({'isDone':true});

  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("todo").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData || snapshot.data != null) {
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                QueryDocumentSnapshot<Object?>? documentSnapshot = snapshot.data?.docs[index];
                return Dismissible(key: Key(index.toString()),
                    child: Column(
                      children: [
                        Card(
                          elevation: 3,
                          child: ListTile(
                            title: Text(
                                (documentSnapshot != null) ? (documentSnapshot["title"].toString()) : "", style:  TextStyle(
                              decoration: documentSnapshot!["isDone"]== true?TextDecoration.lineThrough:TextDecoration.none
                              )),
                            subtitle: Column(
                              children: [
                                Text((documentSnapshot != null)
                                    ? ((documentSnapshot["description"] != null)
                                    ? documentSnapshot["description"]
                                    : "") : ""),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10, 0, 10, 0),
                                  child: Image.file(File(documentSnapshot['imageFile'])),
                                )
                              ],
                            ),
                            trailing: IconButton(
                              color: Colors.red,
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                deleteTodo((documentSnapshot!=null?(documentSnapshot['title']):""));
                              },
                            ),
                            leading: Checkbox(
                              value: documentSnapshot['isDone'],
                              onChanged: (bool? value) {
                                updateTodo((documentSnapshot!=null?(documentSnapshot['title']):""));
                              },
                            ),
                          ),
                        ),
                      ],
                    ));
              });

        }
        return const Center(
          child: Text("data"),
        );
      });


      }
  }
