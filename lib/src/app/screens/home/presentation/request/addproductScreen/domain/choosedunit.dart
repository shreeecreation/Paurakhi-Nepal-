import 'package:get/get.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/domain/dropdown.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/domain/dropdown_api.dart';
import 'package:paurakhi/src/app/screens/home/presentation/request/addproductScreen/model/dropdown_model.dart';

class ChoosedUnitController extends GetxController {
  RxString dropdownIndex = "".obs;

  void changeunit() async {
    int index = DropdownList.dropDownIndex;
    DropdownModel dropdownModel = await DropDownAPI.unitAPI();

    List<CategoryModel> selectedCategory = dropdownModel.data;
    await Future.delayed(const Duration(milliseconds: 500), () {
      for (int i = 0; i < selectedCategory.length; i++) {
        if (selectedCategory[i].id == index) {
          dropdownIndex = RxString(selectedCategory[i].unit ?? "MinQty");
          update();
        }
      }
    });
  }
}
