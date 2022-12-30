import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  final _firebase = FirebaseAuth.instance;

  User getProfile() {
    return _firebase.currentUser!;
  }

  Future<void> logout() async {
    await _firebase.signOut();
  }
}
