import 'package:get/get.dart';

class HideShowState extends GetxController{

  var isVisible=false.obs;
  var isCameraVisible=true.obs;
  var isNumberValid=false.obs;
  var isNumber=true.obs;
  var profVisible=false.obs;
  var defaultInterest=5.obs;
  var homenavigator=0.obs;
  var profilenavigator=0.obs;
  //var delivery=0.obs;
  /*final delivery = [
    {
      "totalCount": "Unknown",
      "uid": "test"
    }
  ].obs;*/
  final dynamicList =[].obs;
  final delivery=[];


  isDelivery(valData)
  {


   delivery.clear();

    delivery.addAll(valData);
update();



  }
  isChangeDelivery(valData,indexData,qty_product){
    delivery[indexData]["totalCount"]=qty_product;
    delivery.addAll(valData);
    update();
  }
  isHiden(valData){
    isVisible.value=valData;
  }
  isCameraHiden(valData){
    isCameraVisible.value=valData;
  }
  isValid(valData){
    isNumberValid.value=valData;
  }
  isNumberCorrect(valData){
    isNumber.value=valData;
  }
  isprofileVisible(valData){
    profVisible.value=valData;
  }
  setDefaultInterest(valData){
    defaultInterest.value=valData;
  }
  setHomenavigator(valData){
    homenavigator.value=valData;
  }
  setProfilenavigator(valData){
    profilenavigator.value=valData;
  }


}