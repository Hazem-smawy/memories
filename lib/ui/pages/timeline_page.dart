import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/memory_controller.dart';
import '../../core/routes.dart';
import '../widgets/memory_card.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _fade;

  static const double _gutter = 40; // left gutter for the timeline
  static const double _circleSize = 16;

  @override
  void initState() {
    super.initState();
    _fade = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    )..forward();
  }

  @override
  void dispose() {
    _fade.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MemoryController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('ذكريات'),
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          c.clearForm();
          Get.toNamed(AppRoutes.edit);
        },
        child: const Icon(Icons.add),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Gradient / blurred bg
          // Container(
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [
          //         Color(0xFF24243e),
          //         Color(0xFF302b63),
          //         Color(0xFF0f0c29),
          //       ],
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //     ),
          //   ),
          // ),
          FadeTransition(
            opacity: _fade,
            child: SafeArea(
              child: Obx(() {
                final items = c.memories;
                if (items.isEmpty) {
                  return const Center(
                    child: Text("لاتوجد اي ذكريات بعد قم بإضافة ذكرياتك"),
                  );
                }

                // Stack the continuous line behind the ListView
                return Stack(
                  children: [
                    // Continuous vertical line (aligned with the center of the gutter)
                    Positioned(
                      right: 16 + (_gutter / 2) - 1, // 16 = list padding left
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.35),
                              Colors.black.withOpacity(0.15),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // The timeline list
                    ListView.separated(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 28),
                      itemBuilder: (context, index) {
                        final m = items[index];
                        final dateString = DateFormat.yMMMd(
                          'ar',
                        ).format(m.date);

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Gutter with the circle marker (the line is behind)
                            SizedBox(
                              width: _gutter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Center(
                                  child: Container(
                                    width: _circleSize,
                                    height: _circleSize,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black.withAlpha(50),
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            // Date above the card + the card itself
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dateString,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 8),
                                  MemoryCard(
                                    memory: m,
                                    onTap: () => Get.toNamed(
                                      AppRoutes.detail,
                                      arguments: m,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
