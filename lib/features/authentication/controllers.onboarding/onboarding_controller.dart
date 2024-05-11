
import 'package:fashion_star_shop/features/authentication/screens/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController{
  static OnBoardingController get instance => Get.find();


  //Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  void updatePageIndicator(index)  => currentPageIndex = index;

  // Jump to the specific page dot selected page
  void doNavigationClick(index){
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  // Update Current Index & jump to next page
  void nextPage(){
    if(currentPageIndex.value == 2){
      Get.offAll(const LoginScreen());
    }else{
      int page = currentPageIndex.value +1 ;
      pageController.jumpToPage(page);
    }
  }

  // Update Current Index & jump to last page
  void skipPage(){
    currentPageIndex.value = 2;
    pageController.jumpTo(2);
  }

}