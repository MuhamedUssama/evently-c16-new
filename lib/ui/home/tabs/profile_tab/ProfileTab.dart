import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:evently_c16/core/resources/RoutesManager.dart';
import 'package:evently_c16/providers/UserProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String selectedLanguage = "en";
  @override
  Widget build(BuildContext context) {
    UserProvider provider = Provider.of<UserProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(64),
            ),
          ),
          child: SafeArea(
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(1000),
                      bottomLeft: Radius.circular(1000),
                      bottomRight: Radius.circular(1000),
                    ),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 120,
                  ),
                ),
                const SizedBox(width: 16),
                provider.user == null
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.user!.name!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              color: ColorsManager.lightBackgroundColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            provider.user!.email!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: ColorsManager.lightBackgroundColor,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  child: DropdownButton<String>(
                    items: const [
                      DropdownMenuItem(value: "en", child: Text("English")),
                      DropdownMenuItem(value: "ar", child: Text("العربية")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value!;
                      });
                    },
                    isExpanded: true,
                    value: selectedLanguage,
                    borderRadius: BorderRadius.circular(20),
                    underline: const SizedBox(),
                    padding: EdgeInsets.zero,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsManager.redColor,
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(
                      context,
                      RoutesManager.login,
                    );
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.logout, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        "logout".tr(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
