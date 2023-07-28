import 'package:firebase_auth/firebase_auth.dart';
import 'database.dart';
class AuthService {
  // sign up
  Future<String> signUp(String email, String password, String username) async {
    DatabaseService db = DatabaseService();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      db.createUser(FirebaseAuth.instance.currentUser!.uid, email, username);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "0";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  // sign in
  Future<String> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "0";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  // sign out
  Future<String> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return "0";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }
}
