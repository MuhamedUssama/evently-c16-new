import 'package:evently_c16/core/reusable_components/CustomField.dart';
import 'package:flutter/material.dart';

import '../../../../core/reusable_components/CustomButton.dart';
import '../../../../core/source/remote/FirestoreManager.dart';
import '../../../../model/Event.dart';
import '../home_tab/widgets/EventItem.dart';

class LoveTab extends StatefulWidget {
  const LoveTab({super.key});

  @override
  State<LoveTab> createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
  late TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomField(
              validation: (value) {
                return null;
              },
              hint: "Search for Event",
              prefix: "assets/images/Search.svg",
              controller: searchController,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder(
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
                    itemBuilder: (context, index) =>
                        EventItem(event: events[index]),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemCount: events.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
