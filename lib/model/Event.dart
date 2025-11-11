import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String? id;
  String? userId;
  String? type;
  String? title;
  String? desc;
  Timestamp? dateTime;
  double? latitude;
  double? longitude;
  String? city;
  String? country;

  Event({
    this.id,
    this.userId,
    this.type,
    this.title,
    this.desc,
    this.dateTime,
    this.latitude,
    this.longitude,
    this.city,
    this.country,
  });

  Event.fromFirestore(Map<String, dynamic>? data) {
    id = data?["id"];
    userId = data?["userId"];
    type = data?["type"];
    title = data?["title"];
    desc = data?["desc"];
    dateTime = data?["dateTime"];
    latitude = data?["latitude"];
    longitude = data?["longitude"];
    city = data?["city"] ?? 'UnKnown';
    country = data?["country"] ?? 'UnKnown';
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "userId": userId,
      "type": type,
      "title": title,
      "desc": desc,
      "dateTime": dateTime,
      "latitude": latitude,
      "longitude": longitude,
      "city": city,
      "country": country,
    };
  }
}
