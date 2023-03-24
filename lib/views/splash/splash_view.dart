import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_odering_app/routes/route_helper.dart';
import 'package:food_odering_app/utils/colors.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_food_controller.dart';
import '../../utils/dimentions.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadApi() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedFoodController>().getRecommendedFoodList();
  }

  @override
  void initState() {
    super.initState();
    _loadApi();
    controller = AnimationController(duration: const Duration(seconds: 2), vsync: this)..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
      Duration(seconds: 3), () => Get.offNamed(RouteHelper.getInitial()),
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(child: Image.asset("assets/image/logo part 1.png",width: 250,))),
          Center(child: Image.asset("assets/image/logo part 2.png",width: Dimentions.splashImage,)),
        ],
      ),
    );
  }
}
