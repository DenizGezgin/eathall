import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future addUserAutoID(String name, String surname, String mail, String token) async {
    userCollection.add({
      'name': name,
      'surname': surname,
      'userToken': token,
      'email': mail
    })
        .then((value) => print('User added'))
        .catchError((error) => print('Error: ${error.toString()}'));
  }

  Future addUser(String name, String surname, String mail, String token) async {
    userCollection.doc(token).set({
      'name': name,
      'surname': surname,
      'userToken': token,
      'email': mail
    });
  }
}