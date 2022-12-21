import 'dart:async';
import 'package:demo_interview_test/home/feature_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  final Widget title;
  const HomeView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return GestureDetector(
      // behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) => Scaffold(
          resizeToAvoidBottomInset: false,
          key: controller.scaffoldKey,
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(243, 247, 254, 1),
            centerTitle: true,
            elevation: 0,
            title: title,
            leading: getCircleAvtar(
              child: Icon(
                Icons.notifications_active_rounded,
                color: Colors.black,
              ),
            ),
            actions: [
              getCircleAvtar(
                backgroundColor: Colors.blue,
                child: Image.asset(
                  "assets/images/profile_photo.jpg",
                  height: 38,
                ),
              ),
            ],
          ),
          body: Container(
            color: Colors.blueAccent,
            child: Center(
              child: Text(controller.centerPageTitle.value),
            ),
          ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.miniCenterDocked,
          // floatingActionButton: !showFab || !controller.isMenuShowed.value
          //     ? null
          //     : Padding(
          //         padding: controller.isMenuShowed.value
          //             ? const EdgeInsets.only(top: 70.0)
          //             : const EdgeInsets.only(top: 0.0),
          //         child: getFAB()
          //       ),
          bottomNavigationBar: BottomAppBar(
            child: SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getBottomBarItem(
                    icon: controller.bottomBarIcons[0],
                    label: controller.bottomBarLabels[0],
                    onPressed: () => controller.onBottomBarItemTapped(0),
                  ),
                  getBottomBarItem(
                    icon: controller.bottomBarIcons[1],
                    label: controller.bottomBarLabels[1],
                    onPressed: () => controller.onBottomBarItemTapped(1),
                  ),
                  SizedBox(
                    width: 60,
                    child: getFAB(),
                  ),
                  getBottomBarItem(
                    icon: controller.bottomBarIcons[2],
                    label: controller.bottomBarLabels[2],
                    onPressed: () => controller.onBottomBarItemTapped(2),
                  ),
                  getBottomBarItem(
                    icon: controller.bottomBarIcons[3],
                    label: controller.bottomBarLabels[3],
                    onPressed: () => controller.onBottomBarItemTapped(3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  FloatingActionButton getFAB() {
    return FloatingActionButton(
      //Floating action button on Scaffold
      onPressed: () {
        if (controller.isMenuShowed.value) {
          controller.sheetController =
              controller.scaffoldKey.currentState?.showBottomSheet(
            enableDrag: false,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(25),
                topStart: Radius.circular(25),
              ),
            ),
            (c) => Obx(
              () => getFeaturesMenu(),
            ),
          );
        }
        controller.onFloatingActionTapped();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color.fromRGBO(193, 213, 244, 1),
      child: controller.isMenuShowed.value
          ? Image.asset(
              "assets/images/menu_icon.png",
              color: const Color.fromRGBO(38, 109, 246, 1),
              scale: 20,
            )
          : const Icon(
              Icons.close,
              color: Color.fromRGBO(38, 109, 246, 1),
            ),
      //icon inside button
    );
  }

  Widget getCircleAvtar(
      {required Widget child,
      EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(10, 0, 10, 0),
      Color backgroundColor = const Color.fromRGBO(193, 213, 244, 1)}) {
    return Padding(
      padding: padding,
      child: CircleAvatar(
        backgroundColor: backgroundColor,
        child: ClipOval(
          child: child,
        ),
        radius: 20,
      ),
    );
  }

  Widget getBottomBarItem(
      {required IconData icon,
      required String label,
      required void Function() onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(0),
            child: Icon(
              icon,
              color: Colors.blue,
            ),
          ),
          Text(label)
        ],
      ),
    );
  }

  Widget getFeaturesMenu() {
    return Container(
      child: Column(
        children: [
          getSearchBar(),
          !controller.searchedText.isEmpty ? Container() : getTopFeatureLabel(),
          !controller.searchedText.isEmpty ? Container() : getRowFeatures(),
          !controller.searchedText.isEmpty
              ? Container()
              : Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Divider(
                      height: 1, color: Colors.grey.shade600, thickness: 1,),
                ),
          getGridFeatures(),
        ],
      ),
    );
  }

  Widget getFeatureCardForRow(FeatureModel featureModel, bool isVertical,
      {void Function()? onTap}) {
    List<Widget> imageWithText = [
      Image.asset(
        "assets/images/feature_icon.png",
        scale: isVertical ? 10 : 12,
      ),
      SizedBox(
        width: isVertical ? 90 : 100,
        child: Text(featureModel.title, textAlign: TextAlign.center),
      ),
    ];

    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(isVertical ? 10 : 5))),
        elevation: 0.0,
        color: Colors.grey.shade200,
        child: isVertical
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageWithText,)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageWithText,),
      ),
    );
  }

  Widget getRowFeatures() {
    return Container(
      height: 150,
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        shrinkWrap: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        scrollDirection: Axis.horizontal,
        itemCount:
            controller.features.where((element) => element.isTopFeature).length,
        itemBuilder: (context, index) {
          return getFeatureCardForRow(
              controller.features
                  .where((element) => element.isTopFeature)
                  .elementAt(index),
              true);
        },
      ),
    );
  }

  Widget getGridFeatures() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          primary: false,
          clipBehavior: Clip.hardEdge,
          itemCount: controller.searchedText.isEmpty
              ? controller.features.length
              : controller.filterFeatures.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            mainAxisExtent: 60,
          ),
          itemBuilder: (context, index) {
            return getFeatureCardForRow(
                controller.searchedText.isEmpty
                    ? controller.features.elementAt(index)
                    : controller.filterFeatures.elementAt(index),
                false);
          },
        ),
      ),
    );
  }

  Widget getSearchBar() {
    return Row(
      children: [
        Container(
          width: Get.width - 20,
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          margin: const EdgeInsets.fromLTRB(10.0, 10, 10.0, 10.0),
          child: TextField(
            focusNode: controller.focusNode,
            textInputAction: TextInputAction.search,
            onSubmitted: (value) => controller.onSearchTextChanged(value),
            onChanged: (value) => controller.onSearchTextChanged(value),
            controller: controller.searchEditingController,
            decoration: InputDecoration(
              hintText: 'Search Features',
              counterText: "",
              prefixIconColor: Colors.blue,
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getTopFeatureLabel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Top Features",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          InkWell(
            onTap: () {},
            child: getCircleAvtar(
                child: Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                padding: EdgeInsets.all(0)),
          ),
        ],
      ),
    );
  }
}
