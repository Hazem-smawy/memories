import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:memories/ui/constants.dart';
import '../../core/memory_controller.dart';
import '../../data/app_database.dart';
import '../widgets/glass.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Memory m = Get.arguments;
    final c = Get.find<MemoryController>();
    final date = DateFormat.yMMMMd('ar').add_jm().format(m.date);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('التفاصيل'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 20),
            onPressed: () {
              c.deleteMemory(m.id);
              Get.back();
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, size: 20),
            onPressed: () {
              c.clearForm(m);
              Get.toNamed('/edit', arguments: m);
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: Hero(
              tag: m.id,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16).copyWith(bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(m.emoji, style: const TextStyle(fontSize: 32)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            m.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(date, style: Theme.of(context).textTheme.labelSmall),
                    const SizedBox(height: 8),

                    Text(
                      m.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 16),
                    if (m.imagePaths.isNotEmpty)
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: m.imagePaths
                            .map(
                              (p) => ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  defaultBorderRadious,
                                ),
                                child: Image.file(
                                  File(p),
                                  width: MediaQuery.of(context).size.width - 30,
                                  // height: 160,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
