// import 'package:fashion_star_shop/services/storeService.dart';
// import 'package:flutter/material.dart';
// import 'package:redux/redux.dart';
// import 'package:async_redux/async_redux.dart'; // import async_redux instead of redux toolkit// Update the import path for storeAPI
// import 'dart:convert'; // Import this for JSON decoding
// // Define action types
// class SetLoadingAction {
//   final bool payload;
//   SetLoadingAction(this.payload);
// }
//
// class SetErrorAction {
//   final dynamic payload;
//   SetErrorAction(this.payload);
// }
//
// class SetSuccessAction {
//   final bool payload;
//   SetSuccessAction(this.payload);
// }
//
// class SetSearchParamsAction {
//   final String payload;
//   SetSearchParamsAction(this.payload);
// }
// class SetStoreAction extends ReduxAction<AppState> {
//   final String storeID;
//   SetStoreAction(this.storeID);
//
//   @override
//   Future<AppState> reduce() async {
//     try {
//       final response = await findStore(storeID);
//       if (response != null && response.statusCode == 200) {
//         final jsonData = json.decode(response.body); // Decode JSON data
//         print(jsonData);
//         return state.copy(storeInfo: jsonData);
//       } else {
//         throw Exception("Failed to fetch store info");
//       }
//     } catch (e) {
//       throw Exception("Failed to fetch store info");
//     }
//   }
// }
//
// // Define initial state
// class AppState {
//   final String storeBanner;
//   final Map<String, dynamic> storeInfo;
//   final List<dynamic> categories;
//   final Map<String, dynamic> breadcrumb;
//   final dynamic selectedCategory;
//   final dynamic selectedSubCategory;
//   final dynamic selectedCurrent;
//   final bool moreSideBar;
//   final Map<String, bool> moreCategoryToggle;
//   final List<dynamic> searchProducts;
//   final String searchParams;
//   final String searchParamsResult;
//   final bool loading;
//   final dynamic error;
//   final bool success;
//
//   AppState({
//     this.storeBanner = "",
//     required this.storeInfo,
//     required this.categories,
//     required this.breadcrumb,
//     this.selectedCategory,
//     this.selectedSubCategory,
//     this.selectedCurrent,
//     this.moreSideBar = false,
//     required this.moreCategoryToggle,
//     this.searchProducts = const [],
//     this.searchParams = "",
//     this.searchParamsResult = "",
//     this.loading = false,
//     this.error,
//     this.success = false,
//   });
//
//   // Copy method for updating state
//   AppState copy({
//     String? storeBanner,
//     Map<String, dynamic>? storeInfo,
//     List<dynamic>? categories,
//     Map<String, dynamic>? breadcrumb,
//     dynamic? selectedCategory,
//     dynamic? selectedSubCategory,
//     dynamic? selectedCurrent,
//     bool? moreSideBar,
//     Map<String, bool>? moreCategoryToggle,
//     List<dynamic>? searchProducts,
//     String? searchParams,
//     String? searchParamsResult,
//     bool? loading,
//     dynamic error,
//     bool? success,
//   }) {
//     return AppState(
//       storeBanner: storeBanner ?? this.storeBanner,
//       storeInfo: storeInfo ?? this.storeInfo,
//       categories: categories ?? this.categories,
//       breadcrumb: breadcrumb ?? this.breadcrumb,
//       selectedCategory: selectedCategory ?? this.selectedCategory,
//       selectedSubCategory: selectedSubCategory ?? this.selectedSubCategory,
//       selectedCurrent: selectedCurrent ?? this.selectedCurrent,
//       moreSideBar: moreSideBar ?? this.moreSideBar,
//       moreCategoryToggle: moreCategoryToggle ?? this.moreCategoryToggle,
//       searchProducts: searchProducts ?? this.searchProducts,
//       searchParams: searchParams ?? this.searchParams,
//       searchParamsResult: searchParamsResult ?? this.searchParamsResult,
//       loading: loading ?? this.loading,
//       error: error ?? this.error,
//       success: success ?? this.success,
//     );
//   }
// }
//
// // Define reducers
// AppState setLoadingReducer(AppState state, SetLoadingAction action) {
//   return state.copy(loading: action.payload);
// }
//
// AppState setErrorReducer(AppState state, SetErrorAction action) {
//   return state.copy(error: action.payload);
// }
//
// AppState setSuccessReducer(AppState state, SetSuccessAction action) {
//   return state.copy(success: action.payload);
// }
//
// AppState setStoreReducer(AppState state, SetStoreAction action) {
//   // Reducer logic for setStore action
//   return state;
// }
//
// // Add other reducers similarly
//
// // Create the store
// final Store<AppState> store = Store<AppState>(
//   combineReducers<AppState>([
//     TypedReducer<AppState, SetLoadingAction>(setLoadingReducer),
//     TypedReducer<AppState, SetErrorAction>(setErrorReducer),
//     TypedReducer<AppState, SetSuccessAction>(setSuccessReducer),
//     TypedReducer<AppState, SetStoreAction>(setStoreReducer),
//     // Add other reducers here
//   ]),
//   initialState: AppState(), // Initial state
// );
//
// // Create selectors
// bool selectLoading(AppState state) => state.loading;
// dynamic selectError(AppState state) => state.error;
// bool selectSuccess(AppState state) => state.success;
// Map<String, dynamic> selectBreadcrumb(AppState state) => state.breadcrumb;
// Map<String, dynamic> selectStore(AppState state) => state.storeInfo;
// List<dynamic> selectCategories(AppState state) => state.categories;
