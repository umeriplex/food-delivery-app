import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_odering_app/routes/route_helper.dart';
import 'package:food_odering_app/utils/app_ex.dart';
import 'package:food_odering_app/utils/colors.dart';
import 'package:food_odering_app/widgets/texts.dart';
import 'package:get/get.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_food_controller.dart';
import '../../modals/popular_product_response_modal.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimentions.dart';
import '../../widgets/icon_and_text.dart';


class MainFoodViewBody extends StatefulWidget {

  const MainFoodViewBody({Key? key}) : super(key: key);

  @override
  State<MainFoodViewBody> createState() => _MainFoodViewBodyState();
}

class _MainFoodViewBodyState extends State<MainFoodViewBody> {

  final PageController _pageController = PageController(viewportFraction: 0.90);
  var _currentPage = 0.0;
  double _scaleFactor = 0.8;
  double height = Dimentions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  dispose(){
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Slider Section
        GetBuilder<PopularProductController>(builder:(popularProducts){
          return  popularProducts.isLoaded ? SizedBox(
            height: Dimentions.pageView,
            child: PageView.builder(
                controller: _pageController,
                itemCount:  popularProducts.popularProductList.isEmpty ? 1 : popularProducts.popularProductList.length,
                itemBuilder: (context,position){
                  return _buildPageItem(position, popularProducts.popularProductList[position]);
                }),
          ) : const CircularProgressIndicator(color: AppColors.mainColor,);
        }),
        // Dots
        GetBuilder<PopularProductController>(
          builder: (popularProducts) {
            return DotsIndicator(
              dotsCount: popularProducts.popularProductList.isEmpty ? 1 : popularProducts.popularProductList.length,
              position: _currentPage,
              decorator: DotsDecorator(
                activeColor: AppColors.mainColor,
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
              ),
            );
          }
        ),
        // Recommended Foods
        Dimentions.height30.ph,
        Container(
          margin: EdgeInsets.only(left: Dimentions.width24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended",size: 24,),
              Dimentions.width10.pw,
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: BigText(text: ".",color: AppColors.black87,),
              ),
              Dimentions.width10.pw,
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: SmallText(text: "Food pairing",),
              ),

            ],
          ),
        ),
        // list of foods
        GetBuilder<RecommendedFoodController>(
          builder: (recommendedFood) {
            return recommendedFood.isLoaded ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
                itemCount: recommendedFood.recommendedFoodList.isEmpty ? 1 : recommendedFood.recommendedFoodList.length,
                itemBuilder: (context,index){
                  return GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getRecommendedFood(index));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: Dimentions.width24,right: Dimentions.width24,bottom: Dimentions.height10),
                      child: Row(
                        children: [
                          // image
                          Container(
                            width: Dimentions.listViewImgSize,
                            height: Dimentions.listViewImgSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimentions.radius20),
                              color: AppColors.white54,
                              image: DecorationImage(
                                image: NetworkImage(AppConstants.imagesUrl + recommendedFood.recommendedFoodList[index].image! ?? AppConstants.foodPlaceHolder),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                          // text
                          Expanded(
                            child: Container(
                              height: Dimentions.listViewTextContSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimentions.radius20),
                                  bottomRight: Radius.circular(Dimentions.radius20),
                                ),
                                color: AppColors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: Dimentions.width10,right: Dimentions.width10,top: Dimentions.height10,bottom: Dimentions.height10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(text: recommendedFood.recommendedFoodList[index].name ?? "Food Name",),
                                    SmallText(text: "Mountain of cheese and chicken, with a touch of garlic."),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextAndIcon(
                                          size: Dimentions.icon24,
                                          icon: Icons.circle_sharp,
                                          text: "Normal",
                                          iconColor: AppColors.iconColor1,
                                        ),
                                        TextAndIcon(
                                          size: Dimentions.icon24,
                                          icon: Icons.location_on,
                                          text: "2.4km",
                                          iconColor: AppColors.mainColor,
                                        ),
                                        TextAndIcon(
                                          size: Dimentions.icon24,
                                          icon: Icons.access_time_outlined,
                                          text: "12min",
                                          iconColor: AppColors.iconColor2,
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ),
                  );
                }
            ) : const CircularProgressIndicator(color: AppColors.mainColor,);
          }
        ),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModal product){

    Matrix4 matrix = Matrix4.identity();
    if(index == _currentPage.floor()){
      var currScale = 1-(_currentPage-index)*(1-_scaleFactor);
      var currTrans = height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);

    }
    else if(index == _currentPage.floor()+1){
      var currScale = _scaleFactor+(_currentPage-index+1)*(1-_scaleFactor);
      var currTrans = height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    else if(index == _currentPage.floor()-1){
      var currScale = 1-(_currentPage-index)*(1-_scaleFactor);
      var currTrans = height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }
    else{
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, height*(1-_scaleFactor)/2, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getPopularFood(index));
            },
            child: Container(
              height: height,
              margin: EdgeInsets.only(left: Dimentions.width10,right: Dimentions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.radius30),
                color: index.isEven ? Colors.cyan : Colors.greenAccent,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.imagesUrl + product.image.toString() ?? AppConstants.foodPlaceHolder),
                ),

              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimentions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimentions.width24,right: Dimentions.width24,bottom: Dimentions.width30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.radius20),
                color: AppColors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0,5)
                  ),
                  BoxShadow(
                      color: AppColors.white,
                      offset: Offset(-5,0)
                  ),
                  BoxShadow(
                      color: AppColors.white,
                      offset: Offset(5,0)
                  ),
                ]

              ),
              child: Container(
                padding: EdgeInsets.only(left: 15,right: 15,top: Dimentions.height10,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(text: product.name ?? "No Name",size: 24,),
                    Dimentions.height10.ph,
                    Row(
                      children: [
                        Wrap(
                          children: List.generate(5, (index) => const Icon(Icons.star,color: AppColors.mainColor,size: 15,)),
                        ),
                        3.pw,
                        SmallText(text: product.stars.toString() ?? "0",color: AppColors.black54,),
                        10.pw,
                        SmallText(text: "205 comments",color: AppColors.black54,),


                      ],
                    ),
                    Dimentions.height15.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextAndIcon(
                          size: Dimentions.icon24,
                          icon: Icons.circle_sharp,
                          text: "Normal",
                          iconColor: AppColors.iconColor1,
                        ),
                        TextAndIcon(
                          size: Dimentions.icon24,
                          icon: Icons.location_on,
                          text: "2.4km",
                          iconColor: AppColors.mainColor,
                        ),
                        TextAndIcon(
                          size: Dimentions.icon24,
                          icon: Icons.access_time_outlined,
                          text: "12min",
                          iconColor: AppColors.iconColor2,
                        ),

                      ],
                    ),
                  ],
                ),
              ),

            ),
          ),
        ],
      ),
    );
  }




}
