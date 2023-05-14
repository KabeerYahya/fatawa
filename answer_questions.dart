import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fatwa/questions.dart';
import 'package:fatwa/sheikh_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

List<String> categories = ["General", "Sallah", "Tsarki", "Aure", "Others"];
String? selectedCategory = '';

// ignore: must_be_immutable
class AnswerQuestion extends StatefulWidget {
  //final QuestionsModel questionId;
  final String? questionI;
  AnswerQuestion({super.key, required this.questionI});

  @override
  State<AnswerQuestion> createState() => _AnswerQuestionState();
}

class _AnswerQuestionState extends State<AnswerQuestion> {
  final _formKey = GlobalKey<FormState>();

  final user = FirebaseAuth.instance.currentUser!;

  String _description = '';

  String _title = '';

  Future _submitForm() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await FirebaseFirestore.instance.collection('Answers').add({
        'answered_by': user.email!,
        'answer': _description,
        'question_id': widget.questionI
      });
      updateQuestion();
      Navigator.pop(context);

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Center(
                    child: Icon(
                  Icons.verified,
                  color: Colors.green,
                )),
                content: const Text("Thank You for your answer ya sheikh "),
                actions: [
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SheikhHome()));
                    },
                  ),
                ],
              ));
    }
  }

  Future updateQuestion() async {
    await FirebaseFirestore.instance
        .collection('Questions')
        .doc(widget.questionI)
        .update({
      'status': 'answered',
      'title': _title,
      'category': selectedCategory,
      'answere_by': user.email!
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference questions =
        FirebaseFirestore.instance.collection('Questions');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Answer Question'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FutureBuilder(
                    future: questions.doc(widget.questionI).get(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        Map<String, dynamic> question =
                            snapshot.data!.data() as Map<String, dynamic>;
                        return Card(
                            child: Column(children: [
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            title: Text('${question['ask_by']}'),
                            subtitle: const Text("02/04/2023"),
                          ),
                          const Divider(
                            height: 5,
                            thickness: 2,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(child: Text(question['question'])),
                          ),
                        ]));
                      } else {
                        return const CircularProgressIndicator();
                      }
                    })),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Write Your answer here...',
                        ),
                        maxLines: 6,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Answer before submitting.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _description = value!;
                        },
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: const [
                          Text("Please Select a Category : "),
                          SizedBox(
                            width: 20,
                          ),
                          CategorySelection(),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText:
                              'What is this Question for (Title of the Question)',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Summerise the question';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _title = value!;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            )),
      ),
    );
  }
}

class CategorySelection extends StatefulWidget {
  const CategorySelection({super.key});

  @override
  State<CategorySelection> createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
  String dropDownValue = categories.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropDownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? value) {
        selectedCategory = value;
        // This is called when the user selects an item.
        setState(() {
          dropDownValue = value!;
        });
      },
      items: categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
