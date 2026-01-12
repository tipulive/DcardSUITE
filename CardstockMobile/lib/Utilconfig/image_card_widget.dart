import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:get/get.dart';

import '../Pages/SetPage2.dart';
import '../Pages/components/photoComp.dart';


class ImageCardWidget extends StatefulWidget {
  final String initialImageUrl;
  final List<String> smallImageUrls;
  final Map<String, dynamic> imgArguments;

  const ImageCardWidget({super.key,
    required this.initialImageUrl,

    required this.smallImageUrls,
    required String mainImageUrl,
    required this.imgArguments,
  });

  @override
  _ImageCardWidgetState createState() => _ImageCardWidgetState();
}

class _ImageCardWidgetState extends State<ImageCardWidget> {
  late String displayedImageUrl;
  late List<String> smallImageUrls;
  late Map<String, dynamic> imgArguments;


  @override
  void initState() {
    super.initState();
    displayedImageUrl = widget.initialImageUrl;
    imgArguments=widget.imgArguments;
    smallImageUrls = List.from(widget.smallImageUrls);
    //getBack();
   // _updateDisplayedImage(1);
  }

  void _updateDisplayedImage(int index) {
    setState(() {
      String newImageUrl = smallImageUrls[index];
      smallImageUrls[index] = displayedImageUrl;
      displayedImageUrl = newImageUrl;
    });
  }
  getBack(){
  }

  Widget _buildSmallImageCard(String imageUrl, int index) {
    return GestureDetector(
      onTap: () {
        _updateDisplayedImage(index);
      },
      child: Card(
        elevation: 0,
        child: Stack(
          children: [

            _buildImage(imageUrl, width: 100, height: 100),
            (imgArguments["editDisplay"]=="true")?
            Positioned(
              top: -12,
              right: -10,
              child: IconButton(
                icon: const Icon(Icons.edit, size: 20, color: Colors.white),
                onPressed: () {
                  // Handle edit action
                  _handleEdit(imageUrl,imgArguments,index);
                },
              ),
            ):const Text(""),
            (imgArguments["editDisplay"]=="true")?
            Positioned(
              bottom: -12,
              right: -10,
              child: IconButton(
                icon: const Icon(Icons.check_circle, size: 20, color: Colors.white),
                onPressed: () {
                  // Handle edit action
                  _handleEdit(imageUrl,imgArguments,index);
                },
              ),
            ):const Text(""),
          ],
        ),
      ),
    );
  }
  void _handleEdit(String imageUrl,imgArguments,index) async{
    //String filename = imageUrl.split('/').last;

    String filename = imageUrl.split('/').last;
    Uri uri = Uri.parse(filename);

    String? version = uri.queryParameters['Ver'];
    String? imgNum = uri.queryParameters['img'];
    String? ogImg= uri.queryParameters['ogImg'];
    String ogFileName = filename.split('?').first;

    String numberCaption='numb$imgNum';
    String actionStatus=(version=="null")?"upload":"EditUpload";
    //print(imgArguments["productCode"]);
    Get.to(() =>SetPage2(dynamicMethod: () {
      return  const photoComp();
    }),arguments:{
      "title":"Image View",
      //"newAction":actionStatus,

      //"actionStatus":"EditUpload",
      //"actionStatus":(version==null)?"upload":"EditUpload",
      "actionStatus":actionStatus,
      "CVersionN":version,//current Version
      "CimgNumber":imgNum,//current Image Number
      "CNumberCaption":numberCaption, //number Caption
      "CFileName":ogFileName,//current FileName
      "fileNam":filename,
      "productCode":imgArguments["productCode"]
    })?.then((result) {
      if (result != null) {
        String backArg = result as String;
        Uri fullUrl = Uri.parse(imageUrl);
        Map<String, String> queryParameters = Map.from(fullUrl.queryParameters);
        queryParameters['Ver'] = backArg;

        // Reconstruct the URL with the updated query parameters
        Uri updatedUri = fullUrl.replace(queryParameters: queryParameters);


        //print("filename:$filename and image:$imageUrl and arguments:$updatedUri");



        String newUriString = fullUrl.toString().replaceAll("api4.jpg", "${imgArguments["productCode"]}_$ogImg");
        Uri defaultUrl=Uri.parse(newUriString);

        if(index==4)
        {

          setState(() {
            displayedImageUrl=(ogFileName=="api4.jpg")?"$defaultUrl":"$updatedUri";
          });

        }
        else{
          setState(() {
            smallImageUrls[index]=(ogFileName=="api4.jpg")?"$defaultUrl":"$updatedUri";
          });
        }

      }
    });
  }

  Widget _buildImage(String imageUrl, {double width=300 , double height=300}) {
    if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
      // Network image
      return CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
      );
    } else {
      // Local file
      return Image.file(
        File(imageUrl),
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                _buildImage(displayedImageUrl),
                    (imgArguments["editDisplay"]=="true")?
                    Positioned(
                      top: -4,
                      right: -4,
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          // Handle edit action
                          _handleEdit(displayedImageUrl,imgArguments,4);
                        },
                      ),
                    ):const Text(""),

                  ],
                ),
              ],
            ),
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: smallImageUrls
                  .asMap()
                  .entries
                  .map((entry) => _buildSmallImageCard(entry.value, entry.key))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
