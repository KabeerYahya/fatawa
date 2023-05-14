import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fatwa/sheikh_home.dart';
import 'package:fatwa/test.dart';
import 'package:fatwa/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _currentUser = FirebaseAuth.instance.currentUser!;

//bool isSheikh = false;

// Future<List<UserModel>?> getSuperUser() async {
//   final snapshot = await FirebaseFirestore.instance
//       .collection('users')
//       .where(
//         'sheikh',
//         isEqualTo: true,
//       )
//       .where('email', isEqualTo: _currentUser.email!)
//       .get();
//   if (snapshot.docs.isNotEmpty) {
//     final superUser =
//         snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
//     isSheikh = superUser[0].isSheikh;
//     print(superUser[0].isSheikh);
//     return superUser;
//   }
//   return null;
// }

class SheikhHomeRedirect extends StatefulWidget {
  const SheikhHomeRedirect({super.key});

  @override
  State<SheikhHomeRedirect> createState() => _SheikhHomeRedirectState();
}

class _SheikhHomeRedirectState extends State<SheikhHomeRedirect> {
  @override
  void initState() {
    getSuperUser();
    super.initState();
  }

  bool isSheikh = false;

  Future<List<UserModel>?> getSuperUser() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where(
          'sheikh',
          isEqualTo: true,
        )
        .where('email', isEqualTo: _currentUser.email!)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final superUser =
          snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
      setState(() {
        isSheikh = superUser[0].isSheikh;
      });
      print(superUser[0].isSheikh);
      return superUser;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (isSheikh == true) {
      print("is sheikh is true");
      return SheikhHome();
    } else {
      print('is sheikh is false');
      return Test();
    }
  }
}
 // return FutureBuilder(
    //     future: getSuperUser(),

    //         return SheikhHome();
    //       } else {
    //         return Test();
    //       }
    //   });