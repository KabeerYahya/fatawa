import 'package:fatwa/answer_questions.dart';
import 'package:flutter/material.dart';

class SocialMediaFeedPage extends StatefulWidget {
  @override
  _SocialMediaFeedPageState createState() => _SocialMediaFeedPageState();
}

class _SocialMediaFeedPageState extends State<SocialMediaFeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.grey,
          //     border: Border(
          //       bottom: BorderSide(
          //         color: Colors.grey,
          //         width: 1.0,
          //       ),
          //     ),
          //   ),
          //   padding: EdgeInsets.all(16.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       CircleAvatar(
          //         radius: 30.0,
          //         backgroundImage: AssetImage("assets/images/fatawa.png"),
          //       ),
          //       SizedBox(width: 16.0),
          //       Expanded(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text(
          //               "John Doe",
          //               style: TextStyle(
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 18.0,
          //               ),
          //             ),
          //             SizedBox(height: 4.0),
          //             Text(
          //               "Software Developer",
          //               style: TextStyle(
          //                 color: Colors.grey[600],
          //                 fontSize: 16.0,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       IconButton(
          //         icon: Icon(Icons.edit),
          //         onPressed: () {},
          //       ),
          //     ],
          //   ),
          // ),
          const CategorySelection(),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
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
                            backgroundImage:
                                AssetImage("assets/images/disina.png"),
                          ),
                          const SizedBox(width: 8.0),
                          const Text(
                            "Dr. Ibrahim Adam Disina ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
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
                      const Text(
                        "TA YI BAKANCE, AMMA TA KASA CIKAWA, YAYA ZA TA YI?",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: const [
                          Text("Tambaya Daga: "),
                          SizedBox(
                            width: 30,
                          ),
                          CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/download.png',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Muhammad Isa Umar"),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
