// import 'package:paurakhi/src/app/screens/home/presentation/tabbars/productmodel.dart';
// import 'package:paurakhi/src/core/API/GetProductAPI/get_product_api.dart';

// import 'all.dart';
// import 'loadmore_controller.dart';

// class Scrollproduct {
//     Future<void> _getProducts({required bool clearItems}) async {
//     setState(() {
//       isLoading = true;
//     });

//     final ServerResponseProduct? response = await GetProductAPI.getProductCategory(
//       category,
//       type,
//       LoadMoreController.currentPage,
//     );

//     if (!isDisposed) {
//         isLoading = false;
//         if (response != null) {
//           if (clearItems) {
//             All.items = response.data;
//           } else {
//             All.items.addAll(response.data);
//           }
//         }
//     }
//   }
// }