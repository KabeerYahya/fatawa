import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetQuestions extends StatelessWidget {
  final String questionDocId;
  const GetQuestions({super.key, required this.questionDocId});

  @override
  Widget build(BuildContext context) {
    // get the Question Collection
    CollectionReference questions =
        FirebaseFirestore.instance.collection('Questions');

    // return future builder method
    return FutureBuilder<DocumentSnapshot>(
        // get the specific question id
        future: questions.doc(questionDocId).get(),
        // pass it to the builder method
        builder: ((context, snapshot) {
          // when the documents are fully loaded
          if (snapshot.connectionState == ConnectionState.done) {
            // convert them to map data type
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text('Questions: ${data['question']}');
          }

          return const Text("Loading");
        }));
  }
}
