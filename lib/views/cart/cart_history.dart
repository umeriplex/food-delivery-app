import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_odering_app/controllers/cart_controller.dart';
import 'package:food_odering_app/modals/cart_modal.dart';
import 'package:food_odering_app/routes/route_helper.dart';
import 'package:food_odering_app/utils/app_ex.dart';
import 'package:food_odering_app/utils/colors.dart';
import 'package:food_odering_app/utils/dimentions.dart';
import 'package:food_odering_app/widgets/app_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../base/no_data_page.dart';
import '../../utils/app_constants.dart';
import '../../widgets/texts.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getHistoryList[i].time)) {
        cartItemsPerOrder.update(getHistoryList[i].time!, (value) => ++value);
      }
      else {
        cartItemsPerOrder.putIfAbsent(getHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();
    int listCounter = 0;

    Widget timeWidget(int index){
      var outputDate = DateTime.now().toString();
      if(index < getHistoryList.length){
        DateTime format = DateFormat("yyyy-MM-dd hh:mm:ss").parse(getHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(format.toString());
        var outPutFormat = DateFormat("MMM dd, yyyy hh:mm a");
        outputDate = outPutFormat.format(inputDate);
      }
      return BigText(text: outputDate ?? "Date",color: AppColors.titleColor,size: Dimentions.font20,);

    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimentions.height45 + 55,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimentions.height45,left: Dimentions.width20,right: Dimentions.width20),
            color: AppColors.mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(text: "Cart History",color: AppColors.white,size: Dimentions.font26,),
                AppIcon(icon: Icons.shopping_cart_checkout,color: AppColors.mainColor,background: AppColors.white,iconSize: Dimentions.icon24 ,)
              ],
            )
          ),
          GetBuilder<CartController>(
            builder: (cartCont) {
              return cartCont.getCartHistoryList().length > 0
                  ?
              Expanded(
                child : Container(
                  margin: EdgeInsets.only(top: Dimentions.height20,left: Dimentions.width20,right: Dimentions.width20,bottom: Dimentions.height20),
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView(
                      children: [
                        for(int i = 0; i < cartItemsPerOrder.length; i++)
                          Container(
                            height: Dimentions.height10*12,
                            margin: EdgeInsets.only(bottom: Dimentions.height24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                timeWidget(listCounter),
                                Dimentions.height10.ph,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children: List.generate(itemsPerOrder[i], (index) {
                                        if(listCounter < getHistoryList.length){
                                          listCounter++;
                                        }
                                        return index <= 2 ? Container(
                                          height: Dimentions.height10*8,
                                          width: Dimentions.width10*8,
                                          margin: EdgeInsets.only(right: Dimentions.width10 / 5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimentions.radius15 / 2),
                                            image: DecorationImage(
                                              image: NetworkImage(AppConstants.imagesUrl + getHistoryList[listCounter - 1].image.toString() ?? AppConstants.foodPlaceHolder),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ) : Container();
                                      }),
                                    ),
                                    SizedBox(
                                      height: Dimentions.height10*8,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SmallText(text: "total",color: AppColors.signColor,),
                                          BigText(text: "${itemsPerOrder[i]} Items",color: AppColors.titleColor,size: Dimentions.font20,),
                                          InkWell(
                                            onTap: (){
                                              var orderTime = cartOrderTimeToList();
                                              Map<int,CartModal> moreOrder = {};
                                              for(int x = 0; x < getHistoryList.length; x++){
                                                if(getHistoryList[x].time == orderTime[i]){
                                                  moreOrder.putIfAbsent(getHistoryList[x].id!, () =>
                                                      CartModal.fromJsom(jsonDecode(jsonEncode(getHistoryList[x])))
                                                  );
                                                }
                                              }
                                              Get.find<CartController>().setItems = moreOrder;
                                              Get.find<CartController>().getItems();
                                              Get.toNamed(RouteHelper.getCartView());
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimentions.radius15 / 2),
                                                border: Border.all(
                                                  color: AppColors.mainColor,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: Dimentions.width10-2 ,vertical: Dimentions.width10 / 2),
                                                child: SmallText(text: "View Details",color: AppColors.mainColor,),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              )
                  :
              SizedBox(
                height: MediaQuery.of(context).size.height/1.5,
                child: const Center(child: NoData(text: "Don't let an empty history hold you back. Start exploring!",imgPath: "assets/image/empty_box.png",)));
            }
          ),
        ],
      )
    );
  }
}
