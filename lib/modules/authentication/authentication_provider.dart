import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationProvider extends ChangeNotifier {
  late final StreamSubscription<User?> _authStateChangesSubscription;

  AuthenticationProvider() {
    notifyListeners();
    _authStateChangesSubscription = FirebaseAuth.instance.authStateChanges().asBroadcastStream().listen((event) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _authStateChangesSubscription.cancel();
    super.dispose();
  }
}
