import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'answers.dart';

String answer = '';
String answered_by = '';

class ViewAnswerPage extends StatelessWidget {
  final String questionId;
  final String ids = 'NujhxJj5kA8Vznhvwlt4';
  const ViewAnswerPage({super.key, required this.questionId});

  Future getAnswer() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Answers')
        .where('question_id', isEqualTo: questionId)
        .get();
    final List<Map<String, dynamic>> answers =
        snapshot.docs.map((doc) => doc.data()).toList();
    answer = answers[0]['answer']!;
    answered_by = answers[0]['answered_by']!;
    return answers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Answer'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FutureBuilder(
                    future: getAnswer(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          print(snapshot);
                          print(questionId);
                          return Padding(
                              padding: const EdgeInsets.all(5),
                              child: Card(
                                  color: Colors.grey.shade200,
                                  child: Column(children: [
                                    ListTile(
                                      trailing: Icon(
                                        Icons.verified,
                                        color: Colors.blueAccent[400],
                                      ),
                                      leading: const CircleAvatar(
                                        backgroundImage: ExactAssetImage(
                                            "assets/images/disina.png"),
                                      ),
                                      title: const Text(
                                        "Amsan Tambaya daga Malam ",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      subtitle: Text("04/05/2023"),
                                    ),
                                    const Divider(
                                      height: 2,
                                      thickness: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Center(child: Text(answer)),
                                    ),
                                  ])));
                        } else {
                          return Text('snapshot does not has data ');
                        }
                      } else {
                        return Text('No Data');
                      }
                    })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
