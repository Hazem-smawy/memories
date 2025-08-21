import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/memory_controller.dart';
import '../../data/app_database.dart';
import '../widgets/glass.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<MemoryController>();
    final Memory? editing = Get.arguments;

    final titleCtrl = TextEditingController(text: c.title.value);
    final descCtrl = TextEditingController(text: c.description.value);

    titleCtrl.addListener(() => c.title.value = titleCtrl.text);
    descCtrl.addListener(() => c.description.value = descCtrl.text);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(editing == null ? 'ذكرى جديده' : 'تعديل'),
        // backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.check_rounded),
            onPressed: () async {
              if (editing == null) {
                await c.addMemory();
              } else {
                await c.updateMemory(editing);
              }
              Get.back();
            },
          ),
          SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16).copyWith(bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Obx(
                    () => Text(
                      c.emoji.value,
                      style: const TextStyle(fontSize: 36),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: titleCtrl,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "عنوان مثل . يوم التخرج",
                      ),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Text('🙂', style: TextStyle(fontSize: 24)),
                    onSelected: (e) => c.emoji.value = e,
                    itemBuilder: (_) => const [
                      PopupMenuItem(value: '😊', child: Text('😊 سعيد')),
                      PopupMenuItem(value: '😔', child: Text('😔 حزين')),
                      PopupMenuItem(value: '🏆', child: Text('🏆 فخور')),
                      PopupMenuItem(value: '🧘', child: Text('🧘 هادئ')),
                      PopupMenuItem(value: '📝', child: Text('📝 ملاحضة')),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),
              TextField(
                controller: descCtrl,
                minLines: 4,
                maxLines: 8,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "اوصف ماذا حدث وماهو المميز في هذه الذكرى",
                ),
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () => c.pickImages(),
                    icon: const Icon(
                      Icons.photo_library_outlined,
                      color: Colors.white,
                    ),
                    label: Text(
                      'إضافة صوره',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Colors.white),
                    ),
                  ),

                  const SizedBox(width: 12),
                  Obx(() => Text('${c.pickedImages.length} مختاره')),
                  Spacer(),
                  IconButton(
                    onPressed: () async {
                      // Show the date picker
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), // default date
                        firstDate: DateTime(2000), // earliest selectable date
                        lastDate: DateTime(2100), // latest selectable date
                      );

                      if (pickedDate != null) {
                        c.date.value =
                            pickedDate; // or format it as string if needed
                      }
                    },
                    icon: Icon(Icons.calendar_month),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Obx(() {
                final imgs = c.pickedImages;
                if (imgs.isEmpty) return const SizedBox.shrink();
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: imgs
                      .map(
                        (p) => Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(p),
                                width: 110,
                                height: 110,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: InkWell(
                                onTap: () => c.pickedImages.remove(p),
                                child: const CircleAvatar(
                                  radius: 12,
                                  child: Icon(Icons.close, size: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
