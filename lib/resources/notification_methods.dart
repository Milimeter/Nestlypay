import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationMethods{
  final String uid;

  NotificationMethods({this.uid});

  final feedReference = FirebaseFirestore.instance.collection('feed');
}