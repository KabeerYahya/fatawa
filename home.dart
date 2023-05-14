// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fatwa/get_questions.dart';
import 'package:fatwa/profile.dart';
import 'package:fatwa/questions.dart';
import 'package:fatwa/view_answer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fatwa/ask.dart';

import 'CustomCard.dart';
import 'MyCard.dart';
import 'answer_questions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  final user = FirebaseAuth.instance.currentUser!;
  //final question = FirebaseFirestore.instance.collection('Questions').get().
  //Map<String, dynamic> pendingQuestions =[];
  List<String> docIds = [];

  String fullname = '';

  // get Documents ids
  Future getDocId() async {
    final questionsFuture = FirebaseFirestore.instance
        .collection('Questions')
        .where('answered_by', isEqualTo: 'a')
        .where('ask_by', isEqualTo: 'usman@gmail.com')
        .get();
    final answersFuture = FirebaseFirestore.instance
        .collection('Answers')
        //.where('answered_by ', isEqualTo: 'kabeerkb@gmail.com')
        .get();
    final userFuture = FirebaseFirestore.instance.collection('users').get();

    // Wait for both futures to complete
    final results = await Future.wait([questionsFuture, answersFuture]);

    results.forEach((snapshot) {
      snapshot.docs.forEach((document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        print(data['question']);
      });
    });

    await FirebaseFirestore.instance
        .collection('Questions')
        .get()
        // ignore: avoid_function_literals_in_foreach_calls
        .then((snapshot) => snapshot.docs.forEach((document) {
              docIds.add(document.reference.id);
            }));
  }

  Future fetchUserName() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user.email!)
        .get();
    final List<Map<String, dynamic>> name =
        snapshot.docs.map((doc) => doc.data()).toList();
    fullname = name[0]['firstname']! + ' ' + name[0]['lastname']!;
    return name;
  }

  Future<List<QuestionsModel>> getPendingQuestions() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Questions')
        .where('status', isEqualTo: 'pending')
        .where('ask_by', isEqualTo: user.email!)
        .get();

    final snapshots = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user.email!)
        .get();
    final List<Map<String, dynamic>> name =
        snapshots.docs.map((doc) => doc.data()).toList();
    fullname = name[0]['firstname']! + ' ' + name[0]['lastname']!;

    final pendingQuestions =
        snapshot.docs.map((e) => QuestionsModel.fromSnapshot(e)).toList();
    return pendingQuestions;
  }

  Future<List<QuestionsModel>> getAnsweredQuestions() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Questions')
        .where('status', isEqualTo: 'answered')
        .where('ask_by', isEqualTo: user.email!)
        .get();

    final answeredQuestions =
        snapshot.docs.map((e) => QuestionsModel.fromSnapshot(e)).toList();
    return answeredQuestions;
  }

  Future getFeed() async {
    final users = await FirebaseFirestore.instance.collection('users').get();
    final questions = FirebaseFirestore.instance.collection('Questions').get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Fatawa',
          textAlign: TextAlign.center,
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Home'),
            Tab(
              text: 'Scholars',
            ),
            Tab(text: 'Pending'),
            Tab(text: 'Answered'),
          ],
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('Questions')
                  .where('status', isEqualTo: 'answered')
                  .get(),
              builder: (context, questionSnapshot) {
                if (questionSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final questions = questionSnapshot.data!.docs;
                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Answers')
                      .snapshots(),
                  builder: (context, answerSnapshot) {
                    if (answerSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final answers = answerSnapshot.data!.docs;
                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .snapshots(),
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        final users = userSnapshot.data!.docs;

                        return ListView.builder(
                          itemCount: questions.length,
                          itemBuilder: (context, index) {
                            final question = questions[index];
                            final ask_by = question['ask_by'];
                            final ask_by_name = users
                                .firstWhere((user) => user['email'] == ask_by);
                            final questionAuthor = users.firstWhere((user) =>
                                user['email'] == 'kabeerkb@gmail.com');
                            final questionText = question['question'];
                            final questionTitle = question['title'];
                            final questionTime = "gdfg";
                            final questionId = question.id;
                            final questionAnswers = answers.where((answer) =>
                                answer['question_id'] == questionId);
                            final ask_by_fullname = ask_by_name['firstname'] +
                                ' ' +
                                ask_by_name['lastname'];
                            final fullname = questionAuthor['firstname'] +
                                ' ' +
                                questionAuthor['lastname'];
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 20.0,
                                        backgroundImage: AssetImage(
                                            "assets/images/disina.png"),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        fullname,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5.0,
                                      ),
                                      const Icon(
                                        Icons.verified,
                                        color: Colors.blue,
                                      ),
                                      const Spacer(),
                                      Text(
                                        "10 mins ago",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  const SizedBox(height: 16.0),
                                  Text(
                                    questionTitle,
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  GestureDetector(
                                    child: Text(questionText),
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ViewAnswerPage(
                                                    questionId: questionId))),
                                  ),
                                  const SizedBox(height: 16.0),
                                  Row(
                                    children: [
                                      const Text("Tambaya Daga: "),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      const CircleAvatar(
                                        backgroundImage: AssetImage(
                                          'assets/images/download.png',
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(ask_by_fullname),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Center(child: CardList()),
          Center(
              child: FutureBuilder(
                  // get the specific question id
                  future: getPendingQuestions(),
                  // pass it to the builder method
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        print('snapshot has data ');
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Card(
                                      color: Colors.grey.shade200,
                                      child: Column(children: [
                                        ListTile(
                                          trailing: const Icon(
                                            Icons.schedule,
                                          ),
                                          leading: const CircleAvatar(
                                            backgroundImage: ExactAssetImage(
                                                "assets/images/disina.png"),
                                          ),
                                          title: Text(fullname),
                                          subtitle: const Text("04/05/2023"),
                                        ),
                                        const Divider(
                                          height: 2,
                                          thickness: 1,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Center(
                                              child: Text(snapshot
                                                  .data![index].question)),
                                        ),
                                      ])),
                                ),
                              );
                            });
                      } else {
                        print("snapshot does not have data ");
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }

                    // when the documents are fully loaded
                    return const Text("Loading");
                  }))),
          Center(
              child: FutureBuilder(
                  // get the specific question id
                  future: getAnsweredQuestions(),
                  // pass it to the builder method
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: GestureDetector(
                                    onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ViewAnswerPage(
                                                    questionId: snapshot
                                                        .data![index].id
                                                        .toString()))),
                                    child: Card(
                                        color: Colors.grey.shade200,
                                        child: Column(children: [
                                          ListTile(
                                            trailing: const Icon(
                                              Icons.verified,
                                              color: Colors.blue,
                                            ),
                                            leading: const CircleAvatar(
                                              backgroundImage: ExactAssetImage(
                                                  "assets/images/disina.png"),
                                            ),
                                            title: Text(fullname),
                                            subtitle: const Text("04/05/2023"),
                                          ),
                                          const Divider(
                                            height: 2,
                                            thickness: 1,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Center(
                                                child: Text(snapshot
                                                    .data![index].question)),
                                          ),
                                        ])),
                                  ),
                                ),
                              );
                            });
                      } else {}

                      print('snapshot has data');
                    } else {
                      print('snapshot doesnt have data');
                    }

                    // when the documents are fully loaded
                    return const Text("Loading");
                  }))),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person_4),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AboutPage(
                              developerName: " Kabir Yahya ",
                              developerEmail: 'kbkb051@gmail.com',
                            )));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AskQuestion()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
