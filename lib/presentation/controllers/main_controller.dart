import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rugved_assignment/data/source/network/api_client.dart';
import 'package:rugved_assignment/data/constants.dart';
import '../../data/models/user_model.dart';
import '../../data/source/locale/database_service.dart';
import '../screens/explore_screen.dart';
import '../screens/home_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/profile_screen.dart';

class MainController extends GetxController {
  DatabaseService databaseService = DatabaseService.instance;

  final List<Widget> screens = [
    HomeScreen(),
    NotificationScreen(),
    ExploreScreen(),
    ProfileScreen(),
  ];

  Set<int> navigationHistory = {0};

  List<UserModel> searchList = [];
  List<UserModel> recentSearchList = [];

  TextEditingController searchController = TextEditingController();

  bool isFollowing = false;
  RxString searchQuery = ''.obs;
  int selectedIndex = 0;
  bool isLoading = false;
  String errorMessage = "No User Found";
  String errorIcon = noUserFound;

  @override
  void onInit() {
    super.onInit();
    getAllRecentSearchList();

    debounce(
      searchQuery,
      (callback) {
        if (searchQuery.value.isNotEmpty) {
          searchUser(searchQuery.value);
        } else {
          update();
        }
      },
      time: Duration(milliseconds: 800),
    );
  }

  void changeTab(int index) {
    selectedIndex = index;
    navigationHistory.add(index);
    update();
  }

  void getAllRecentSearchList() async {
    recentSearchList = await databaseService.getSearchesList();
    update();
  }

  Future<void> searchUser(String word) async {
    isLoading = true;
    searchList.clear();
    update();

    await ApiClient.client.get('/$word').then((value) {
      if (value is! List) {
        final data = UserModel.fromJson(value);
        searchList.add(data);
      } else {
        searchList = value.map((data) => UserModel.fromJson(data)).toList();
      }
    }, onError: (e) {
      if (e.toString().contains('internet')) {
        errorMessage = "No Internet";
        errorIcon = noInternet;
      } else {
        errorMessage = "No User Found";
        errorIcon = noUserFound;
      }
    }).onError((error, stackTrace) {
      debugPrint("Error while parsing => $error");
    });

    isLoading = false;
    update();
  }
}
