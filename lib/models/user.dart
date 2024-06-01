import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String? uid;
  AppUser({this.uid});
  factory AppUser.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return AppUser(uid: doc.data()!['uid']);
  }
}

class AppUserData {
  String? uid;
  String? name;
  String? email;
  String? photoUrl;
  Timestamp? timestamp;
  String? stripe;

  AppUserData(
      {this.uid,
      this.name,
      this.email,
      this.stripe,
      this.timestamp,
      this.photoUrl});
  factory AppUserData.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    return AppUserData(
      uid: doc.data()!['uid'],
      name: doc.data()!['name'],
      email: doc.data()!['email'],
      photoUrl: doc.data()!["photoUrl"],
      timestamp: doc.data()!['timestamp'],
      stripe: doc.data()!["stripe"],
    );
  }
  AppUserData.fromJson(Map<String, dynamic>? json) {
    uid = json!['uid'];
    name = json['name'];
    timestamp = json['timestamp'];
    email = json['email'];
    stripe = json['stripe'];
    photoUrl = json['Stripe'];
  }
  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "timestamp": timestamp,
        "email": email,
        "stripe": stripe,
        "photoUrl": photoUrl
      };
}
