import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionsModel {
  final String? id;
  final String question;
  final String ask_by;
  final String answered_by;
  final String status;
  final String title;
  final String category;
  final DateTime time;

  const QuestionsModel(
      {this.id,
      required this.question,
      required this.ask_by,
      required this.category,
      required this.title,
      required this.answered_by,
      required this.status,
      required this.time});

  toJson() {
    return {
      "question": question,
      "ask_by": ask_by,
      "answered_by": answered_by,
      "status": status,
      "time": time
    };
  }

  factory QuestionsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return QuestionsModel(
        id: document.id,
        question: data['question'],
        ask_by: data['ask_by'],
        title: data['title'],
        category: data['category'],
        answered_by: data['answered_by'],
        status: data['status'],
        time: data['time'].toDate());
  }
}
