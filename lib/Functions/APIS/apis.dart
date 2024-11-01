import 'package:amenda_cuts/Models/service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Apis {
  static final FirebaseFirestore firebase = FirebaseFirestore.instance;
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static final user = FirebaseAuth.instance.currentUser;
}
