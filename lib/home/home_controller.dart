import 'package:demo_interview_test/home/feature_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class HomeController extends GetxController {
  // HomeController();

  // // Make SplashService a private variable so it is not used directly.
  // final HomeService _homeService;

  static HomeController get to => Get.find();

  var selectedIndex = 0.obs;
  var isMenuShowed = true.obs;
  var centerPageTitle = "Home Page Title".obs;

  List<String> bottomBarLabels = ["Home", "Connect", "Evolve", "Explore"];
  List<IconData> bottomBarIcons = [Icons.home, Icons.thumb_up_alt, Icons.lightbulb, Icons.explore];

  TextEditingController searchEditingController = TextEditingController();
  var searchedText = "".obs;

  final FocusNode focusNode = FocusNode();

  RxList<FeatureModel> features = <FeatureModel>[].obs;
  RxList<FeatureModel> filterFeatures = <FeatureModel>[].obs;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController? sheetController;

  @override
  void onInit() {
    super.onInit();
    generateListOfFeature();
  }
  
  void onFloatingActionTapped() {
    if(!isMenuShowed.value){
      sheetController?.close();
    }
    isMenuShowed.value = !isMenuShowed.value;
    update();
  }

  void onBottomBarItemTapped(int index) {
    selectedIndex.value = index;
    centerPageTitle.value = bottomBarLabels[index];
    update();
  }

  void onSearchTextChanged(String value){
    searchedText.value = value;
    filterFeatures.value = features.where((element) => element.title.toLowerCase().contains(searchedText.toLowerCase())).toList();
    update();
  }

  void generateListOfFeature(){
    for(int i=0;i<100;i++){
      if(i%2==0){
        features.add(FeatureModel(title: generateRandomString(5) + " " + generateRandomString(7)));
      }
      else{
        features.add(FeatureModel(title: generateRandomString(5), isTopFeature: i<10 && i%2==1));
      }
    }
    update();
  }

  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }
}
