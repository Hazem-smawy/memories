import 'package:get/get.dart';
import 'package:memories/ui/pages/details_page.dart';
import '../ui/pages/timeline_page.dart';
import '../ui/pages/edit_page.dart';

class AppRoutes {
  static const timeline = '/';
  static const edit = '/edit';
  static const detail = '/detail';

  static final pages = [
    GetPage(name: timeline, page: () => const TimelinePage()),
    GetPage(name: edit, page: () => const EditPage()),
    GetPage(name: detail, page: () => const DetailPage()),
  ];
}
