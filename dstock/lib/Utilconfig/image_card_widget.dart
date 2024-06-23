import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:get/get.dart';

import '../Pages/SetPage.dart';
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
  }

  void _updateDisplayedImage(int index) {
    setState(() {
      String newImageUrl = smallImageUrls[index];
      smallImageUrls[index] = displayedImageUrl;
      displayedImageUrl = newImageUrl;
    });
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
            CachedNetworkImage(
              imageUrl: imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              placeholder: (context, url) => const SizedBox(
                width: 100,
                height: 100,
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => const SizedBox(
                width: 100,
                height: 100,
                child: Center(child: Icon(Icons.error)),
              ),
            ),
            (imgArguments["editDisplay"]=="true")?
            Positioned(
              top: -12,
              right: -10,
              child: IconButton(
                icon: const Icon(Icons.edit, size: 20, color: Colors.white),
                onPressed: () {
                  // Handle edit action
                  _handleEdit(imageUrl,imgArguments);
                },
              ),
            ):Text(""),
            (imgArguments["editDisplay"]=="true")?
            Positioned(
              bottom: -12,
              right: -10,
              child: IconButton(
                icon: const Icon(Icons.check_circle, size: 20, color: Colors.white),
                onPressed: () {
                  // Handle edit action
                  _handleEdit(imageUrl,imgArguments);
                },
              ),
            ):Text(""),
          ],
        ),
      ),
    );
  }
  void _handleEdit(String imageUrl,imgArguments) {
    //String filename = imageUrl.split('/').last;
    String filename = imageUrl.split('/').last;
    print('Edit clicked for: $filename');
    //print(imgArguments["productCode"]);
    Get.to(() =>SetPage2(dynamicMethod: () {
      return  const photoComp();
    }),arguments:{
      "title":"Image View",
      "actionStatus":"EditUpload",
      "fileNam":"$filename",
      "productCode":imgArguments["productCode"]
    });
    // Handle edit action here, using the filename if needed
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
                    CachedNetworkImage(
                      imageUrl: displayedImageUrl,
                      //width:double.infinity,


                      placeholder: (context, url) => const SizedBox(
                        height: 200,

                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => const SizedBox(
                        height: 200,

                        child: Center(child: Icon(Icons.error)),
                      ),
                    ),
                    (imgArguments["editDisplay"]=="true")?
                    Positioned(
                      top: -4,
                      right: -4,
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          // Handle edit action
                          _handleEdit(displayedImageUrl,imgArguments);
                        },
                      ),
                    ):Text(""),

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
