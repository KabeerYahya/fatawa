//  FutureBuilder<QuerySnapshot>(
//               future: FirebaseFirestore.instance.collection('Questions').get(),
//               builder: (context, questionSnapshot) {
//                 if (questionSnapshot.connectionState ==
//                     ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 final questions = questionSnapshot.data!.docs;
//                 return StreamBuilder<QuerySnapshot>(
//                   stream: FirebaseFirestore.instance
//                       .collection('Answers')
//                       .snapshots(),
//                   builder: (context, answerSnapshot) {
//                     if (answerSnapshot.connectionState ==
//                         ConnectionState.waiting) {
//                       return Center(child: CircularProgressIndicator());
//                     }
//                     final answers = answerSnapshot.data!.docs;
//                     return StreamBuilder<QuerySnapshot>(
//                       stream: FirebaseFirestore.instance
//                           .collection('users')
//                           .snapshots(),
//                       builder: (context, userSnapshot) {
//                         if (userSnapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return Center(child: CircularProgressIndicator());
//                         }
//                         final users = userSnapshot.data!.docs;

//                         return ListView.builder(
//                           itemCount: questions.length,
//                           itemBuilder: (context, index) {
//                             final question = questions[index];
//                             final ask_by = question['ask_by'];
//                             final questionAuthor = users.firstWhere((user) =>
//                                 user['email'] == 'kabeerkb@gmail.com');
//                             final questionText = question['question'];
//                             final questionTime = "gdfg";
//                             final questionId = question.id;
//                             final questionAnswers = answers.where((answer) =>
//                                 answer['question_id'] == questionId);
//                             return Column(
//                               children: [
//                                 ListTile(
//                                   leading: CircleAvatar(
//                                     backgroundImage:
//                                         AssetImage('assets/images/disina.png'),
//                                   ),
//                                   title: Text(questionAuthor['firstname']),
//                                   subtitle: Text(questionTime.toString()),
//                                   trailing: Text(
//                                       questionAnswers.length.toString() +
//                                           ' answers'),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 16.0),
//                                   child: Text(questionText),
//                                 ),
//                                 Divider(),
//                                 ...questionAnswers.map((answer) {
//                                   final answerAuthorId = answer['answer'];
//                                   final answerAuthor = users.firstWhere(
//                                       (user) =>
//                                           user['email'] == answerAuthorId);
//                                   final answerText = answer['text'];
//                                   final answerTime = answer['time'];
//                                   return Column(
//                                     children: [
//                                       ListTile(
//                                         leading: CircleAvatar(
//                                           backgroundImage: AssetImage(
//                                               'assets/images/disina.png'),
//                                         ),
//                                         title: Text(answerAuthor['name']),
//                                         subtitle: Text(answerTime.toString()),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 16.0),
//                                         child: Text(answerText),
//                                       ),
//                                       Divider(),
//                                     ],
//                                   );
//                                 }),
//                               ],
//                             );
//                           },
//                         );
//                       },
//                     );
//                   },
//                 );
//               },
//             ),



 //     child: FutureBuilder(
            //   future: getDocId(),
            //   builder: (context, snapshot) {
            //     return ListView.builder(
            //         itemCount: docIds.length,
            //         itemBuilder: (context, index) {
            //           return Container(
            //             decoration: const BoxDecoration(
            //               color: Colors.white,
            //               border: Border(
            //                 bottom: BorderSide(
            //                   color: Colors.grey,
            //                   width: 1.0,
            //                 ),
            //               ),
            //             ),
            //             padding: const EdgeInsets.all(16.0),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Row(
            //                   children: [
            //                     const CircleAvatar(
            //                       radius: 20.0,
            //                       backgroundImage:
            //                           AssetImage("assets/images/disina.png"),
            //                     ),
            //                     const SizedBox(width: 8.0),
            //                     const Text(
            //                       "Dr. Ibrahim Adam Disina ",
            //                       style: TextStyle(
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: 16.0,
            //                       ),
            //                     ),
            //                     const Icon(
            //                       Icons.verified,
            //                       color: Colors.blue,
            //                     ),
            //                     const Spacer(),
            //                     Text(
            //                       "10 mins ago",
            //                       style: TextStyle(
            //                         color: Colors.grey[600],
            //                         fontSize: 14.0,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 const Divider(),
            //                 const SizedBox(height: 16.0),
            //                 const Text(
            //                   "TA YI BAKANCE, AMMA TA KASA CIKAWA, YAYA ZA TA YI?",
            //                   style: TextStyle(
            //                       fontSize: 16.0, fontWeight: FontWeight.bold),
            //                 ),
            //                 const SizedBox(height: 16.0),
            //                 Row(
            //                   children: const [
            //                     Text("Tambaya Daga: "),
            //                     SizedBox(
            //                       width: 30,
            //                     ),
            //                     CircleAvatar(
            //                       backgroundImage: AssetImage(
            //                         'assets/images/download.png',
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       width: 10,
            //                     ),
            //                     Text("Muhammad Isa Umar"),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           );
            //           // return Padding(
            //           //   padding: const EdgeInsets.all(15),
            //           //   child: Card(
            //           //       child: Column(children: [
            //           //     const SizedBox(
            //           //       height: 10,
            //           //     ),
            //           //     ListTile(
            //           //       title: Text(user.email!),
            //           //       subtitle: Text("02/05/2023"),
            //           //     ),
            //           //     const Divider(
            //           //       height: 5,
            //           //       thickness: 2,
            //           //     ),
            //           //     Padding(
            //           //       padding: const EdgeInsets.all(16.0),
            //           //       child: GetQuestions(questionDocId: docIds[index]),
            //           //     ),
            //           //   ])),
            //           // );
            //         });
            //   },
            // ),


            // Column(
                            //   children: [
                            //     ListTile(
                            //       leading: CircleAvatar(
                            //         backgroundImage:
                            //             AssetImage('assets/images/disina.png'),
                            //       ),
                            //       title: Text(fullname),
                            //       subtitle: Text(questionTime.toString()),
                            //       trailing: Text(
                            //           questionAnswers.length.toString() +
                            //               ' answers'),
                            //     ),
                            //     Padding(
                            //       padding: const EdgeInsets.symmetric(
                            //           horizontal: 16.0),
                            //       child: Text(questionText),
                            //     ),
                            //     Divider(),
                            //     ...questionAnswers.map((answer) {
                            //       final answerAuthorId = answer['answered_by'];
                            //       final answerAuthor = users.where((user) =>
                            //           user['email'] == answerAuthorId);
                            //       final answerText = "kb ";
                            //       final answerTime = "04/05/2022";
                            //       return Column(
                            //         children: [
                            //           ListTile(
                            //             leading: CircleAvatar(
                            //               backgroundImage: AssetImage(
                            //                   'assets/images/disina.png'),
                            //             ),
                            //             title: Text("kbkbs"),
                            //             subtitle: Text(answerTime.toString()),
                            //           ),
                            //           Padding(
                            //             padding: const EdgeInsets.symmetric(
                            //                 horizontal: 16.0),
                            //             child: Text(answerText),
                            //           ),
                            //           Divider(),
                            //         ],
                            //       );
                            //     }),
                            //   ],
                            // );