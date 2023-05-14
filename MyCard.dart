import 'package:fatwa/ask.dart';
import 'package:flutter/material.dart';

class CardItem {
  final String name;
  final String image;

  CardItem({required this.name, required this.image});
}

class CardList extends StatelessWidget {
  final List<CardItem> items = [
    CardItem(
        name: 'Dr Isa Ali Ibrahim Pantami ', image: 'assets/images/isa.png'),
    CardItem(
        name: 'Dr. Ibrahim Adam Disina', image: 'assets/images/disina.png'),
    CardItem(
        name: 'Sheikh Aminu Ibrahim Daurawa ',
        image: 'assets/images/daurawa.png'),
    CardItem(
        name: 'Sheikh Abubakar Mukhtar Yola ',
        image: 'assets/images/abubakar.png'),
    CardItem(name: 'Sheikh Kabiru Gombe ', image: 'assets/images/kabiru.png'),
    CardItem(name: 'Dr Bashir Sani Ahmad ', image: 'assets/images/bashir.png'),
    CardItem(
        name: 'Sheikh Tijjani Ahmad Yusuf ',
        image: 'assets/images/tijjani.png'),
    CardItem(
        name: 'Sheikh Ibrahim Jalo Jalingo ', image: 'assets/images/jalo.png')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
AskQuestion())) ,
              child: Card(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(items[index].image),
                        radius: 100,
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                items[index].name,
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              const Icon(
                                Icons.verified,
                                color: Colors.blue,
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
