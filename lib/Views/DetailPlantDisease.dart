import 'package:flutter/material.dart';
import 'package:plantdisease/Widgets/appbar.dart';

import '../Models/PlantDiseasemodel.dart';
import '../Models/UploadResponse.dart';

class DetailPlantDisease extends StatefulWidget {
  final PlantDisease? plantDisease;final UploadResponse? uploadResponse;
  const DetailPlantDisease({super.key, required this.plantDisease, required this.uploadResponse});

  @override
  State<DetailPlantDisease> createState() => _DetailPlantDiseaseState();
}

class _DetailPlantDiseaseState extends State<DetailPlantDisease> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppbar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child:
              Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                ClipRRect(borderRadius: BorderRadius.circular(25),child: Image.network(widget.uploadResponse!.imageUrl)),
           SizedBox(height: 50,), Column(
              children: [
                Text(widget.plantDisease!.name,style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),SizedBox(height: 50,),
            Column(
              children: [
                Text("CulturalPractices",style: TextStyle(fontWeight: FontWeight.bold),),
                Text(widget.plantDisease!.culturalPractices),
              ],
            ),
            Column(
              children: [
                Text("Fertilizers",style: TextStyle(fontWeight: FontWeight.bold)),
                Text(widget.plantDisease!.fertilizers),
              ],
            ),
            Column(
              children: [
                Text("Pesticides",style: TextStyle(fontWeight: FontWeight.bold)),
                Text(widget.plantDisease!.pesticides),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
