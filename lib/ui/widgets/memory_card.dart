import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memories/data/app_database.dart';
import 'package:memories/ui/constants.dart';

class MemoryCard extends StatelessWidget {
  final Memory memory;
  final VoidCallback onTap;
  // final VoidCallback onDelete;

  const MemoryCard({
    super.key,
    required this.memory,
    required this.onTap,
    // required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      // <-- Add this
      color: Colors.transparent, // keep glass look
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(memory.emoji, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      memory.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              if (memory.description.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  memory.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              if (memory.imagePaths.isNotEmpty) ...[
                const SizedBox(height: 8),
                SizedBox(
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: memory.imagePaths
                        .map(
                          (p) => Container(
                            margin: const EdgeInsets.only(left: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                defaultBorderRadious,
                              ),
                              border: Border.all(color: blackColor20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                defaultBorderRadious,
                              ),
                              child: Image.file(
                                File(p),
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
