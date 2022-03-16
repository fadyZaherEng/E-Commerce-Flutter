import 'package:dio/dio.dart';

class DioHelper{
 static late Dio  dio;
 static Init(){
   dio= Dio(BaseOptions(
       baseUrl: 'https://fakestoreapi.com/',
       receiveDataWhenStatusError: true,
   ));
 }// https://fakestoreapi.com/products
 static Future<Response> getData({
   required String url,
   dynamic query,
   String? token,
   String lang='en',
}){
   dio.options.headers={
     'lang':lang,
     'Content-Type':'application/json',
     'Authorization':token,
   };
    return dio.get(
        url,
        queryParameters: query,
    );
  }
 static Future<Response> putData({
   required String url,
   required dynamic data,
   dynamic query,
   String? token,
   String lang='en',
 }){
   dio.options.headers={
     'lang':lang,
     'Authorization':token,
     'Content-Type':'application/json',
   };
   return dio.post(
     url,
     queryParameters: query,
     data: data,
   );
 }
 static Future<Response> putUserUpdateData({
   required String url,
   required dynamic data,
   dynamic query,
   String? token,
   String lang='en',
 }){
   dio.options.headers={
     'lang':lang,
     'Authorization':token,
     'Content-Type':'application/json',
   };
   return dio.put(
     url,
     queryParameters: query,
     data: data,
   );
 }
 static Future<Response> deleteData({
   required String url,
   dynamic data,
   dynamic query,
   String? token,
   String lang='en',
 }){
   dio.options.headers={
     'lang':lang,
     'Authorization':token,
     'Content-Type':'application/json',
   };
   return dio.delete(
     url,
     data: data,
     queryParameters: query,
   );
 }

 static Future<Response> updateData({
   required String url,
   required dynamic data,
   dynamic query,
   String? token,
   String lang='en',
 }){
   dio.options.headers={
     'lang':lang,
     'Authorization':token,
     'Content-Type':'application/json',
   };
   return dio.put(
     url,
     queryParameters: query,
     data: data,
   );
 }
}