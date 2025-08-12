import 'package:e_commerce/core/class/statusrequest.dart';
import 'package:e_commerce/core/function/handlingdata.dart';
import 'package:e_commerce/data/datasource/remote/parent/resultdata.dart';
import 'package:get/get.dart';

class Postparentcontroller extends GetxController {
  final String studentId;
  Postparentcontroller(this.studentId);

  // Use Rx variables for reactive UI updates
  var statusrequest = Statusrequest.none;

  Resultdata resultdata = Resultdata(Get.find());

  var data = <Map>[].obs; // Observable list of posts
  var filteredData = <Map>[].obs; // For search filtering

  var isGridView = false.obs;
  var searchText = ''.obs;

  String? finalTotalMarks;

  @override
  void onInit() {
    super.onInit();
    getresults();
  }

  Future<void> getresults() async {
    statusrequest = Statusrequest.loading;
update();
    final response = await resultdata.getposts(studentId);
    statusrequest = handlingData(response);

    if (statusrequest == Statusrequest.success) {
      data.assignAll(List<Map>.from(response['data'] ?? []));
      filteredData.assignAll(data); // Initialize filtered with all data
    } else {
      data.clear();
      filteredData.clear();
    }
    update();
  }

  void toggleView() {
    isGridView.value = !isGridView.value;
  }

  void searchPosts(String text) {
    searchText.value = text;

    if (text.isEmpty) {
      filteredData.assignAll(data);
    } else {
      filteredData.assignAll(
        data.where((post) {
          final postText = post['post']?.toString().toLowerCase() ?? '';
          return postText.contains(text.toLowerCase());
        }).toList(),
      );
    }
  }

  Future<void> fetchPosts() async {
    await getresults();
  }
}
