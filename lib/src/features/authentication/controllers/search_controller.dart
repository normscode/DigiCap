import '../models/memory_model.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final memories = <MemoryModel>[].obs;
  final searchQuery = ''.obs;

  List<MemoryModel> get filteredMemories {
    if (searchQuery.isEmpty) {
      return memories;
    }

    final lowercaseQuery = searchQuery.value.toLowerCase();
    return memories.where((memory) {
      final lowercaseTitle = memory.title.toLowerCase();
      final lowercaseDescription = memory.description.toLowerCase();
      return lowercaseTitle.contains(lowercaseQuery) ||
          lowercaseDescription.contains(lowercaseQuery);
    }).toList();
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }
}
