import 'package:cloud_firestore/cloud_firestore.dart';

class AnswerModel {
  final String? id;
  final String answered_by;
  final String answer;
  final String question_id;
  

  const AnswerModel(
      {this.id,
      required this.answered_by,
      required this.answer,
      required this.question_id,
      });

  factory AnswerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return AnswerModel(
        id: document.id,
        answer: data['answer'],
        answered_by: data['answered_by'],
        question_id: data['question_id']
        );
  }
}
