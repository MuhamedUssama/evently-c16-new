import 'package:evently_c16/core/reusable_components/CustomButton.dart';
import 'package:evently_c16/core/reusable_components/CustomField.dart';
import 'package:evently_c16/ui/create_event/provider/create_event_provider.dart';
import 'package:evently_c16/ui/create_event/widgets/choose_event_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/ColorsManager.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: const Text("Create Event")),
      body: DefaultTabController(
        length: 3,
        child: Consumer<CreateEventProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: provider.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.25,
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                "assets/images/Book Club.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                "assets/images/sport.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                "assets/images/birthday.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      TabBar(
                        onTap: (tabIndex) {
                          provider.changeSelectedTap(tabIndex);
                        },
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        unselectedLabelColor: ColorsManager.primaryColor,
                        labelColor: ColorsManager.lightBackgroundColor,
                        labelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        dividerHeight: 0,
                        indicatorColor: Colors.white,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(46),
                          color: ColorsManager.primaryColor,
                        ),
                        tabs: [
                          Tab(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(46),
                                border: Border.all(
                                  color: ColorsManager.primaryColor,
                                ),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/book-open.svg",
                                    colorFilter: ColorFilter.mode(
                                      provider.selectedTap == 0
                                          ? ColorsManager.lightBackgroundColor
                                          : ColorsManager.primaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text("Book Club"),
                                ],
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(46),
                                border: Border.all(
                                  color: ColorsManager.primaryColor,
                                ),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/bike.svg",
                                    colorFilter: ColorFilter.mode(
                                      provider.selectedTap == 1
                                          ? ColorsManager.lightBackgroundColor
                                          : ColorsManager.primaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text("Sport"),
                                ],
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(46),
                                border: Border.all(
                                  color: ColorsManager.primaryColor,
                                ),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/cake.svg",
                                    colorFilter: ColorFilter.mode(
                                      provider.selectedTap == 2
                                          ? ColorsManager.lightBackgroundColor
                                          : ColorsManager.primaryColor,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text("Birthday"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Title",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      CustomField(
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return "Should add event title";
                          }
                          return null;
                        },
                        hint: "Enter the event title",
                        prefix: "assets/images/Note_Edit.svg",
                        controller: provider.titleController,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      CustomField(
                        maxLines: 5,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return "Should add event description";
                          }
                          return null;
                        },
                        hint: "Enter the event description",
                        prefix: "assets/images/Note_Edit.svg",
                        controller: provider.descController,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          SvgPicture.asset("assets/images/Calendar_Days.svg"),
                          const SizedBox(width: 10),
                          Text(
                            "Event Date",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              provider.chooseDate(context);
                            },
                            child: Text(
                              provider.selectedDate == null
                                  ? "Choose Date"
                                  : "${provider.selectedDate!.day}/${provider.selectedDate!.month}/${provider.selectedDate!.year}",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: ColorsManager.primaryColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          SvgPicture.asset("assets/images/Clock.svg"),
                          const SizedBox(width: 10),
                          Text(
                            "Event Time",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              provider.chooseTime(context);
                            },
                            child: Text(
                              provider.selectedTime == null
                                  ? "Choose Time"
                                  : "${provider.selectedTime!.hourOfPeriod}:${provider.selectedTime!.minute}${provider.selectedTime!.period.name}",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: ColorsManager.primaryColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Location",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      ChooseEventLocation(provider: provider),
                      const SizedBox(height: 16),
                      CustomButton(
                        title: "Add Event",
                        onPress: () {
                          provider.createNewEvent(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
