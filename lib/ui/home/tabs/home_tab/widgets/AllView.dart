import 'package:evently_c16/core/reusable_components/CustomButton.dart';
import 'package:evently_c16/core/source/remote/FirestoreManager.dart';
import 'package:evently_c16/model/Event.dart';
import 'package:flutter/material.dart';

import 'EventItem.dart';

class AllView extends StatelessWidget {
  const AllView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreManager.getAllEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // loading state
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Column(
            children: [
              Text(snapshot.error!.toString()),
              CustomButton(title: "Try Again", onPress: () {}),
            ],
          );
        }
        List<Event> events = snapshot.data ?? [];
        return ListView.separated(
          itemBuilder: (context, index) => EventItem(event: events[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: events.length,
        );
      },
    );
  }
}
