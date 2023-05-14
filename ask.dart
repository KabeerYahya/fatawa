import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fatwa/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AskQuestion extends StatefulWidget {
  const AskQuestion({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _AskQuestionState createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  final _formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser!;
  String _description = '';

  Future _submitForm() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await FirebaseFirestore.instance.collection('Questions').add({
        'ask_by': user.email!,
        'question': _description,
        'answered_by': 'a',
        'time': DateTime.now(),
        'status': 'pending',
        'title': '',
        'category': ''
      });

      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }

    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Center(
                  child: Icon(
                Icons.verified,
                color: Colors.green,
              )),
              content: Text(
                  "Your Question has been submitted successfully, you will get your answer shortly."),
              actions: [
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage()));
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ask Your Question'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'What is your question ?',
                          border: OutlineInputBorder(),
                        ),
                        maxLength: 180,
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Question.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _description = value!;
                        },
                      ),
                      const SizedBox(height: 32),
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
