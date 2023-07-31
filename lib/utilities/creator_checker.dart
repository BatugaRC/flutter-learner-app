import 'package:firebase_auth/firebase_auth.dart';

bool checkCreator(creator) {
  if (creator == FirebaseAuth.instance.currentUser?.uid) {
    return true;
  } else {
    return false;
  }
}