import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListOfTask extends StatelessWidget {
  const ListOfTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("todo").snapshots(),
      builder: (context, snapshot) {
        print("======================");
        if (snapshot.hasError) {
          return Text('Something went wrong');
          print("======================");
        } else if (snapshot.hasData || snapshot.data != null) {
          print("======>AAAAAAA>>>>>>>>>${snapshot.data?.docs.length}");
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
                            title: Text((documentSnapshot != null) ? (documentSnapshot["title"].toString()) : ""),
                            subtitle: Text((documentSnapshot != null)
                                ? ((documentSnapshot["description"] != null)
                                ? documentSnapshot["description"]
                                : "") : ""),
                            trailing: IconButton(
                              color: Colors.red,
                              icon: const Icon(Icons.delete),
                              onPressed: () {

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
