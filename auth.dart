import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fatwa/sheikh_home.dart';
import 'package:fatwa/sheikh_home_redirect.dart';
import 'package:fatwa/test.dart';
import 'package:fatwa/toggle_pages.dart';
import 'package:fatwa/users.dart';
import 'package:fatwa/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// final _currentUser = FirebaseAuth.instance.currentUser!;

// bool isSheikh = false;

// Future<List<UserModel>> getSuperUser() async {
//   final snapshot = await FirebaseFirestore.instance
//       .collection('users')
//       .where(
//         'sheikh',
//         isEqualTo: true,
//       )
//       .where('email', isEqualTo: _currentUser.email!)
//       .get();

//   final superUser =
//       snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
//   isSheikh = superUser[0].isSheikh;
//   print(superUser[0].isSheikh);
//   return superUser;
// }

// Future getUser() async {
//   await FirebaseFirestore.instance
//       .collection('users')
//       .where(
//         'sheikh',
//         isEqualTo: true,
//       )
//       .where('email', isEqualTo: _currentUser.email!)
//       .get()
//       // ignore: avoid_function_literals_in_foreach_calls
//       .then((snapshot) => snapshot.docs.forEach((document) {
//             print(document['firstname']);
//             if (document['email'] == _currentUser.email!) {
//               //print('Finally Working');
//               isSheikh = true;
//             }
//             //print(isSheikh);
//           }));
// }

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const SheikhHomeRedirect();
            // getSuperUser();
            // if (isSheikh == true) {
            //   print('issheikh');
            //   return const SheikhHome();
            // } else {
            //   print('isnotsheikh');
            //   return const Test();
            // }
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
// for (var i = 0; i < _emails.length; i++) {
            //   if (_emails[i] == 'sabo@gmail.com') {
            //     print('I fixed it ');
            //   } else {
            //     print('Not Yet');
            //   }
            //   print(_emails[i]);
            // }

             //print(document['email'].runtimeType);
            // print(_currentUserEmail.runtimeType);
            // print('The runtime type of _email is ');
            //print(_email.runtimeType);
            // print(isSheikh.runtimeType);
            // print(document['email']);

             // await  FirebaseFirestore.instance
  //     .collection('users')
  //     .where('email', isEqualTo: _currentUserEmail, )
  //     .get()
  //     // ignore: avoid_function_literals_in_foreach_calls
  //     .then((snapshot) => snapshot.docs.where((document) == )
  //     }));