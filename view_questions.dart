import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fatwa/answers.dart';

class ViewAnswer extends StatelessWidget {
  final String? questionId;
  const ViewAnswer({super.key, required this.questionId});

  Future<List<AnswerModel>> getAnswer() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Answers')
        .where('question_id', isEqualTo: questionId)
        .get();
    final answer =
        snapshot.docs.map((e) => AnswerModel.fromSnapshot(e)).toList();
    return answer;
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FutureBuilder(
                  future: getAnswer(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      print(snapshot.data);
                      Map<String, dynamic> answer =
                          snapshot.data! as Map<String, dynamic>;
                      return Card(
                          child: Column(children: [
                        const SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          title: Text(''),
                          subtitle: const Text("02/04/2023"),
                        ),
                        const Divider(
                          height: 5,
                          thickness: 2,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(child: Text("")),
                        ),
                      ]));
                    } else {
                      return Text('No Data');
                    }
                  })),
            ],
          ),
        ),
      ),
    );
  }
}
