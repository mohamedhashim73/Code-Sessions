import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:code_app/models/category_model.dart';
import 'package:code_app/models/user_model.dart';
import 'package:code_app/modules/Screens/categories_screen/categories_screen.dart';
import 'package:code_app/modules/Screens/favorites_screen/favorites.dart';
import 'package:code_app/modules/Screens/home_screen/home_screen.dart';
import 'package:code_app/modules/Screens/cart_screen/cart_screen.dart';
import 'package:code_app/modules/Screens/profile_screen/profile_screen.dart';
import 'package:code_app/shared/constnts/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http ;
import 'package:code_app/layout/layout_cubit/layout_states.dart';
import 'package:http/http.dart';

import '../../models/banner_model.dart';
import '../../models/product_model.dart';
import '../../shared/network/local_network.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit() : super(LayoutInitialState());

  int bottomNavIndex = 0 ;
  void changeBottomNavIndex({required int currentIndex}){
    bottomNavIndex = currentIndex ;
    emit(ChangeBottomNavigationIndexState());
  }

  List<Widget> layoutScreens = [HomeScreen(),CategoriesScreen(),FavoritesScreen(),CartScreen(),ProfileScreen()];

  UserModel? userModel;
  void getUserData() async {
    emit(GetUserDataLoadingState());
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/profile"),
      headers:
      {
        'Authorization' : token!,
      }
    );
    var responseData = jsonDecode(response.body);
    if( responseData['status'] == true )
      {
        userModel = UserModel.fromJson(responseData['data']);
        debugPrint("User Data is : ${responseData['data']}");
        emit(GetUserDataSuccessState());
      }
    else
      {
        emit(FailedToGetUserDataState(responseData['message']));
      }
  }

  List<BannerModel> bannersData = [];
  // Get Banners Data
  void getBanners() async {
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/banners"),
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
      {
        for( var item in responseBody['data'] )
          {
            bannersData.add(BannerModel.fromJson(data: item));
          }
        // print("First Url on Banners Data is : ${bannersData.first.image}");
        emit(GetBannersSuccessState());
      }
    else
      {
        bannersData = [];
        print("Banners Data is : $responseBody");
        emit(FailedToGetBannersState());
      }
  }

  List<CategoryModel> categoriesData = [];
  // Get Banners Data
  void getCategories() async {
    emit(GetCategoriesLoadingState());
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/categories"),
      headers:
      {
        'lang' : 'en'
      }
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
    {
      for( var item in responseBody['data']['data'] )
      {
        categoriesData.add(CategoryModel.fromJson(data: item));
      }
      // print("First Url on Categories Data is : ${categoriesData.first.image}");
      emit(GetCategoriesSuccessState());
    }
    else
    {
      categoriesData = [];
      print("Banners Data is : $responseBody");
      emit(FailedToGetCategoriesState());
    }
  }

  List<ProductModel> productsData = [];
  // Get Banners Data
  Set<String> favoritesStatus = {};
  void getProducts() async {
    emit(GetProductsLoadingState());
    Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/home"),
      headers:
      {
        'lang' : "en"
      }
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
    {
      for( var item in responseBody['data']['products'] )
      {
        productsData.add(ProductModel.fromJson(json: item));
      }
      emit(GetProductsSuccessState());
    }
    else
    {
      productsData = [];
      // print("Products Data is : $responseBody");
      emit(FailedToGetProductsState());
    }
  }

  List<ProductModel> favoritesData = [];
  Future<void> getFavorites() async {
    favoritesData.clear();
    emit(GetFavoritesLoadingState());
    Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/favorites"),
        headers:
        {
          'lang' : 'en',
          'Authorization' : token!
        }
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
    {
      for( var item in responseBody['data']['data'] )
      {
        favoritesStatus.add(item['product']['id'].toString());
        favoritesData.add(ProductModel.fromJson(json: item['product']));
      }
      debugPrint("Favorites number is : ${responseBody['data']['total']}");
      debugPrint("Favorites Status Number is : ${favoritesStatus.length}");
      emit(GetFavoritesSuccessState());
    }
    else
    {
      favoritesData = [];
      debugPrint("Favorites Data is : $responseBody");
      emit(FailedToGetFavoritesState());
    }
  }

  void addOrRemoveToOrFromFavorites({required String productID}) async {
    // عشان يحصل ريفرش في صفحه HomeScreen
    favoritesStatus.contains(productID) == true ? favoritesStatus.remove(productID) : favoritesStatus.add(productID);
    emit(GetFavoritesLoadingState());
    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/favorites"),
        headers:
        {
          'lang' : 'en',
          'Authorization' : token!
        },
      body:
      {
        "product_id": productID
      }
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
    {
      await getFavorites();
      emit(AddOrRemoveFromFavoritesSuccessState());
    }
    else
    {
      emit(FailedToAddOrRemoveFromFavoritesState());
    }
  }

  void changePassword({required String newPassword}) async {
    emit(ChangePasswordLoadingState());
    String? currentPassword = await CacheNetwork.getCacheData(key: 'password');
    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/change-password"),
      body: {
          'current_password' : currentPassword,
          'new_password' : newPassword
      },
      headers: {
          'Authorization' : token!
      }
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] )
      {
        CacheNetwork.insertToCache(key: "password", value: newPassword);
        password = newPassword;
        emit(ChangePasswordSuccessState());
      }
    else
      {
        emit(FailedToChangePasswordState());
      }
  }

  void updateUserData({required String phone,required String name}) async {
    emit(UpdateUserDataLoadingState());
    String? currentPassword = await CacheNetwork.getCacheData(key: 'password');
    Response response = await http.put(
        Uri.parse("https://student.valuxapps.com/api/update-profile"),
      body:
      {
          'name' : name,
          'email' : userModel!.email,
          'password' : currentPassword,
          'phone' : phone,
          'image' : userModel!.image,
      },
      headers:
      {
          'Authorization' : token!
      }
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] )
      {
        userModel = UserModel.fromJson(responseBody['data']);
        emit(UpdateUserDataSuccessState());
      }
    else
      {
        emit(FailedToUpdateUserDataState());
      }
  }

}