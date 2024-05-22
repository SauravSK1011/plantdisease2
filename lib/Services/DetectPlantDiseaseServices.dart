import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plantdisease/Models/PlantDiseasemodel.dart';
import 'package:plantdisease/constants/constants.dart';

import '../Models/UploadResponse.dart';

class DetectPlantDiseaseServices {
  Future<List<PlantDisease>> fetchPlantDiseases() async {
    final String jsonString =
        await rootBundle.loadString('assets/files/disease.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return jsonData.entries
        .map((entry) => PlantDisease.fromJson({entry.key: entry.value}))
        .toList();
  }
Future<PlantDisease?> findPlantDiseaseByName(String name) async {
  final List<PlantDisease> diseases = await fetchPlantDiseases();
  final foundDisease = diseases.firstWhere((disease) => disease.name == name);
  return foundDisease;
}


  Future<UploadResponse?> uploadImage(File imageFile) async {
    Dio dio = Dio();

    var url =
        '${Constants.url}/upload';

    FormData formData = FormData.fromMap({
      'file':
          await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
    });

    try {
      var response = await dio.post(
        url,
        data: formData,
      );

      if (response.statusCode == 200) {
        var responseData = response.data;
        return UploadResponse.fromJson(responseData);
      } else {
        Fluttertoast.showToast(
            msg: "Failed to upload image. Status code: ${response.statusCode}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);

        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error uploading image: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          fontSize: 8.0);
          print("Error uploading image: $e");
      return null;
    }
  }
}
