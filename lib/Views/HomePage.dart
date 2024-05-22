import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantdisease/Models/PlantDiseasemodel.dart';
import 'package:plantdisease/Models/UploadResponse.dart';
import 'package:plantdisease/Services/DetectPlantDiseaseServices.dart';
import 'package:plantdisease/Views/DetailPlantDisease.dart';

import '../Widgets/appbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? image;
  Future<void> getfilefromgallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? response = await picker.pickImage(source: ImageSource.gallery);
    image = File(response!.path);
    setState(() {});
  }

  Future<void> getfilefromcamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? response = await picker.pickImage(source: ImageSource.camera);
    image = File(response!.path);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DetectPlantDiseaseServices().fetchPlantDiseases();
  }
bool load=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(context),
      body: Column(
        children: [
          image != null
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Center(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.file(image!))))
              : Container(),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: getfilefromgallery,
                  child: Icon(Icons.browse_gallery)),
              ElevatedButton(
                  onPressed: getfilefromcamera, child: Icon(Icons.camera)),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          image != null
              ? ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      load=true;
                    });
                    UploadResponse? res =
                        await DetectPlantDiseaseServices().uploadImage(image!);
                    if(res!=null){PlantDisease? disease = await DetectPlantDiseaseServices()
                        .findPlantDiseaseByName(res.diseaseName);
                        setState(() {
                      load=false;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPlantDisease(
                                plantDisease: disease, uploadResponse: res,
                              )),
                    );}
                  },
                  child:load?CircularProgressIndicator(): Text("Detect Plant Disease"))
              : Container()
        ],
      ),
    );
  }
}
