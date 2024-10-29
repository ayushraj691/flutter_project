import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../controller/variable_controller.dart';
import '../../utils/my_toast.dart';
import 'url.dart';

class ApiCall {

   static Future postApiCalltoken(String url, model, String token,String businessId) async {
     try {
       final response = await http.post(
         Uri.parse('${MyUrls.BASE_URL}/$url/$businessId'),

         headers: {
           'Content-type': 'application/json',
           'Accept': 'application/json',
           'Authorization': 'Bearer $token',
         },
         body: json.encode(model.toJson()),
       );
       if (response.statusCode == 200) {
         var o = json.decode(response.body);
         return o;
       } else {
         if (response.statusCode == 401) {
           try {
             var errorResponse = json.decode(response.body);
             String errorMessage = errorResponse['error'] ?? 'Unauthorized access';
             MyToast.toast(errorMessage);
             debugPrint("401 Unauthorized: $errorResponse");
             return errorResponse;
           } catch (e) {
             debugPrint("Failed to parse 401 response: $e");
             MyToast.toast("$e");
             return {"error": "Unauthorized access, but failed to parse response."};
           }
         } else if (response.statusCode == 404 || response.statusCode==400) {
           try {
             var errorResponse = json.decode(response.body);
             String errorMessage = errorResponse['message'] ?? 'Bad Request';
             String errorMsg = errorResponse['rn'] ?? 'Bad Request';
             MyToast.toast(" ${errorMsg}  $errorMessage");
             debugPrint("400 Bad Request: $errorResponse");
             return errorResponse;
           } catch (e) {
             debugPrint("Failed to parse 400 response: $e");
             MyToast.toast("$e");
             return {"error": "Bad Request, but failed to parse response."};
           }
         } else {
           final variablecontroller = Get.find<VariableController>();
           debugPrint("\n\n\n\n"+"${response.statusCode.toString()}"+"\n\n\n\n\n");
            variablecontroller.loading.value = false;
            variablecontroller.apiResponseCode.value =
               response.statusCode.toString();
         }
       }
     } catch (e) {
       final variablecontroller = Get.find<VariableController>();
       variablecontroller.loading.value = false;
       MyToast.toast("something went wrong.");
       debugPrint("\n\n\nFrom catch block\n${MyUrls.BASE_URL}/$url\n$e\n\n\n");
     }
   }

   static Future postApiCall(String url, model,String token) async {
     try {
       final response = await http.post(
         Uri.parse('${MyUrls.BASE_URL}/$url'),
         headers: {
           'Content-type': 'application/json',
           'Accept': 'application/json',
           'Authorization': 'Bearer $token',
         },
         body: json.encode(model.toJson()),
       );
       if (response.statusCode == 200) {
         var o = json.decode(response.body);
         return o;
       } else {
         if (response.statusCode == 401) {
           try {
             var errorResponse = json.decode(response.body);
             String errorMessage = errorResponse['error'] ?? 'Unauthorized access';
             MyToast.toast(errorMessage);
             debugPrint("401 Unauthorized: $errorResponse");
             return errorResponse;
           } catch (e) {

             debugPrint("Failed to parse 401 response: $e");
             MyToast.toast("$e");
             return {"error": "Unauthorized access, but failed to parse response."};
           }
         } else {
           final variablecontroller = Get.find<VariableController>();
           debugPrint("\n\n\n\n"+"${response.statusCode.toString()}"+"\n\n\n\n\n");
           variablecontroller.loading.value = false;
           variablecontroller.apiResponseCode.value =
               response.statusCode.toString();
         }
       }
     } catch (e) {
       final variablecontroller = Get.find<VariableController>();
       variablecontroller.loading.value = false;
       ///MyToast.toast("something went wrong.");
       debugPrint("\n\n\nFrom catch block\n${MyUrls.BASE_URL}/$url\n$e\n\n\n");
     }
   }

   static Future getApiCall(String url, String token, String id, [String? yes]) async {
     String? showToast = yes;
     try {
       String Url1='${MyUrls.BASE_URL}/$url/$id';
       final response = await http.get(
         Uri.parse(Url1),
         headers: {
           'Content-type': 'application/json',
           'Accept': 'application/json',
           'Authorization': 'Bearer $token',
         },
       );
       if (response.statusCode == 200) {
         debugPrint(response.body);
         var decodedResponse = json.decode(response.body.toString());
         if (decodedResponse is List) {
           return decodedResponse;
         } else if (decodedResponse is Map) {
           return decodedResponse;
         } else {
           throw Exception('Unexpected response type');
         }
       } else {
         if (response.statusCode == 401) {
           try {
             var errorResponse = json.decode(response.body);
             String errorMessage = errorResponse['error'] ?? 'Unauthorized access';
             MyToast.toast(errorMessage);
             debugPrint("401 Unauthorized: $errorResponse");
             return errorResponse;
           } catch (e) {
             debugPrint("Failed to parse 401 response: $e");
             MyToast.toast("$e");
             return {"error": "Unauthorized access, but failed to parse response."};
           }
         } else {
           MyToast.toast(response.reasonPhrase.toString());
           debugPrint("\n\n\n\n${response.statusCode.toString()}\n\n\n\n\n");
         }
       }
     } catch (e) {
       showToast == "yes"
           ? debugPrint("Something went wrong.")
           : MyToast.toast("Something went wrong.");
       debugPrint("\n\n\n From catch block \n$url/$id\n$e\n\n\n");
     }
   }

   static Future getApiCallParam({
     required String endpoint,
     required String token,
     required String id,
     String? query,
     int page = 1,
     int size = 10,
     String sort = '{}',
     String args = '{}',
     String startDate = '',
     String endDate = '',
     String? yes,
     String? urlIdentifier
   }) async {
     String? showToast = yes;
     String url = '';
     try {
       if(urlIdentifier=="0"){
          url='${MyUrls.BASE_URL}/$endpoint/$id?query=${query ?? ''}&page=$page&size=$size&sort=$sort&args=$args&start_date=$startDate&end_date=$endDate';
       }else{
         url = '${MyUrls.BASE_URL}/$endpoint/$id?query=${query ?? ''}&page=$page&size=$size&sort=$sort&args=$args';
       }
       debugPrint("-----------------raj-${url}---------------");
       final response = await http.get(
         Uri.parse(url),
         headers: {
           'Content-type': 'application/json',
           'Accept': 'application/json',
           'Authorization': 'Bearer $token',
         },
       );

       if (response.statusCode == 200) {

         debugPrint(response.body); // Print the raw response
         var decodedResponse = json.decode(response.body.toString());

         if (decodedResponse is List) {
           return decodedResponse;
         } else if (decodedResponse is Map) {
           return decodedResponse;
         } else {
           throw Exception('Unexpected response type');
         }
       } else if (response.statusCode == 401) {
         try {
           var errorResponse = json.decode(response.body);
           String errorMessage = errorResponse['error'] ?? 'Unauthorized access';
           MyToast.toast(errorMessage);
           debugPrint("401 Unauthorized: $errorResponse");
           return errorResponse;
         } catch (e) {
           debugPrint("Failed to parse 401 response: $e");
           MyToast.toast("$e");
           return {"error": "Unauthorized access, but failed to parse response."};
         }
       } else {
         // Handle other status codes
         MyToast.toast(response.reasonPhrase.toString());
         debugPrint("\n\n\n\n${response.statusCode.toString()}\n\n\n\n\n");
       }
     } catch (e) {
       if (showToast == "yes") {
         debugPrint("Something went wrong.");
       } else {
         MyToast.toast("Something went wrong.");
       }
       debugPrint("\n\n\n From catch block \n$url\n$e\n\n\n");
     }
   }
}