import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c16/model/User.dart';

import '../../../model/Event.dart';

class FirestoreManager {
  static CollectionReference<User> getUserCollection() {
    var collection = FirebaseFirestore.instance
        .collection("User")
        .withConverter(
          fromFirestore: (snapshot, options) {
            var data = snapshot.data();
            var user = User.fromFireStore(data);
            return user;
          },
          toFirestore: (user, options) {
            return user.toFireStore();
          },
        );
    return collection;
  }

  static Future<void> addUser(User user) {
    var collection = getUserCollection();
    var doc = collection.doc(user.id);
    return doc.set(user);
  }

  static Future<User?> getUser(String userId) async {
    var collection = getUserCollection();
    var doc = collection.doc(userId);
    var snapshot = await doc.get();
    return snapshot.data();
  }

  static CollectionReference<Event> getEventCollection() {
    var collection = FirebaseFirestore.instance
        .collection("Event")
        .withConverter(
          fromFirestore: (snapshot, options) {
            var data = snapshot.data();
            return Event.fromFirestore(data);
          },
          toFirestore: (event, options) {
            return event.toFirestore();
          },
        );
    return collection;
  }

  static Future<void> createEvent(Event event) {
    var collection = getEventCollection();
    var docRef = collection.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }

  static Future<List<Event>> getAllEvents() async {
    var collection = getEventCollection();
    var querySnapshot = await collection.get();
    var docList = querySnapshot.docs;
    var eventList = docList.map((document) => document.data()).toList();
    return eventList;
  }

  static Future<List<Event>> getTypeEvents(String type) async {
    var collection = getEventCollection().where("type", isEqualTo: type);
    var querySnapshot = await collection.get();
    var docList = querySnapshot.docs;
    var eventList = docList.map((document) => document.data()).toList();
    return eventList;
  }
}
