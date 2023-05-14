import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String firstname;
  final String lastname;
  final String email;
  final bool isSheikh;


  const UserModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.isSheikh,
  }
  );

   factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        firstname: data['firstname'],
        lastname: data['lastname'],
        email: data['email'],
        isSheikh: data['sheikh']);
  }
}
