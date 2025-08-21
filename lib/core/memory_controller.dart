import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:drift/drift.dart' as d;
import '../data/app_database.dart';

class MemoryController extends GetxController {
  final AppDatabase db;
  MemoryController(this.db);

  @override
  void onInit() {
    super.onInit();
    db.watchAll().listen((data) => memories.assignAll(data));
  }

  final memories = <Memory>[].obs;
  final isLoading = false.obs;

  // form fields
  final title = ''.obs;
  final emoji = '📝'.obs;
  final description = ''.obs;
  final pickedImages = <String>[].obs;
  final date = DateTime.now().obs;

  void clearForm([Memory? m]) {
    title.value = m?.title ?? '';
    emoji.value = m?.emoji ?? '📝';
    description.value = m?.description ?? '';
    date.value = m?.date ?? DateTime.now();
    pickedImages.assignAll(m?.imagePaths ?? []);
  }

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final files = await picker.pickMultiImage(imageQuality: 85);
    // store paths; optionally copy to app dir for full control
    pickedImages.addAll(files.map((x) => x.path));
  }

  Future<void> addMemory() async {
    if (title.isEmpty) return;
    isLoading.value = true;
    await db.insertMemory(
      MemoriesCompanion.insert(
        date: date.value,
        title: title.value,
        emoji: emoji.value,
        description: d.Value(description.value),
        imagePaths: pickedImages.toList(),
      ),
    );
    isLoading.value = false;
  }

  Future<void> updateMemory(Memory m) async {
    isLoading.value = true;
    final updated = m.copyWith(
      title: title.value,
      emoji: emoji.value,
      description: description.value,
      imagePaths: pickedImages.toList(),
      date: date.value,
    );
    await db.updateMemory(updated);
    isLoading.value = false;
  }

  Future<void> deleteMemory(int id) => db.deleteMemory(id);
}
