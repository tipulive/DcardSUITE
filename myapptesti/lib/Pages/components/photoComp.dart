import 'dart:io';
import 'dart:typed_data';


import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';


import 'package:get/get.dart';

import '../../Query/AdminQuery.dart';
import '../../Query/StockQuery.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart' as dio;
import 'package:photo_manager/photo_manager.dart';

import '../../Utilconfig/ConstantClassUtil.dart';





class photoComp extends StatefulWidget {
  const photoComp({super.key});

  @override
  State<photoComp> createState() => _photoCompState();
}

class _photoCompState extends State<photoComp> {

  Map<String, dynamic> arguments = Get.arguments as Map<String, dynamic>;

  int currentTimestamp = DateTime.now().millisecondsSinceEpoch;

  /* picture upload*/
  XFile? _imageFile;
  List<AssetPathEntity> albums = [];
  AssetPathEntity? selectedAlbum;
  List<AssetEntity> images = [];
  @override
  void initState() {
    super.initState();
    _getPermission();
  }

  void _getPermission() async {

    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps == PermissionState.authorized) {
      _loadImageFolders();
      // Permission was granted, proceed with accessing photos.
    } else {
      // Permission was denied or restricted, show an error message or request permission again.
    }
  }
  Future<void> _loadImageFolders() async {
    // Get all asset paths containing images
    List<AssetPathEntity> assetPaths = await PhotoManager.getAssetPathList(
      type: RequestType.image,
    );

    setState(() {
      albums = assetPaths;
      if (albums.isNotEmpty) {
        selectedAlbum = albums.first; // Select the first album by default
        _loadPhotos(selectedAlbum!);
      }
    });
  }

  Future<void> _loadPhotos(AssetPathEntity album) async {
    List<AssetEntity> photos = await album.getAssetListRange(
      start: 0,
      end: 1000, // Load up to 1000 photos (adjust as needed)
    );

    setState(() {
      images = photos;
    });
  }

  Future<XFile?> pickImage({required ImageSource source}) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);
    return pickedImage;
    //print("${arguments["title"]}");
   /* setState(() {
      _imageFile = pickedImage;
      (Get.put(StockQuery()).updateImageFile(pickedImage));
    });
    Get.back();*/
    //_compressAndUploadImage();

  }



  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await pickImage(source: source);
    if (pickedImage != null) {

     // print("${arguments["title"]}");
      setState(() {
        _imageFile = pickedImage;
        (Get.put(StockQuery()).updateImageFile(pickedImage));
      });
      _compressAndUploadImage();


    }
  }
  Future<void> _compressAndUploadImage() async {
    (Get.put(StockQuery()).updateHideLoader(false));
    if (_imageFile == null) return;

    final compressedImage = await compressImage(_imageFile);
    if (compressedImage == null) return;

    // Upload or store the compressed image here.

    // Create a Dio instance.
    final dioInstance = dio.Dio();
    String authToken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
    dioInstance.options.headers = {
      'Authorization': 'Bearer $authToken',
    };

    // Replace this URL with your server's endpoint for uploading images.
    const String uploadUrl = '${ConstantClassUtil.urlLink}/upload';

    try {
      // Use Dio to upload the compressed image.
      final response = await dioInstance.post(
        uploadUrl,
        data: dio.FormData.fromMap({
          'image': dio.MultipartFile.fromBytes(
            compressedImage,
            filename: _imageFile!.name,
          ),
          'productCode':arguments["productCode"],
          'fileNam':arguments["CFileName"],
          'NumbVer':arguments["CNumberCaption"],
          'versionN':currentTimestamp,
          'actionStatus':arguments["actionStatus"],
        }),
      );

      // Handle the response from the server.
      if (response.statusCode == 200) {
        (Get.put(StockQuery()).updateHideLoader(true));
        Get.back(result:'$currentTimestamp');
        //print('Image uploaded successfully ${response}');
      } else {
      }
    } catch (e) {
    }
  }
  Future<Uint8List?> compressImage(XFile? imageFile) async {
    if (imageFile == null) return null;

    final compressedImage = await FlutterImageCompress.compressWithFile(
      imageFile.path,
      minWidth: 600, // Adjust these to lower values if needed
      minHeight: 600,
      quality: 50, // Lower quality for faster compression
      format: CompressFormat.jpeg, // Use CompressFormat directly.
    );

    return compressedImage;
  }
  /* picture upload*/


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  if ((Get.put(StockQuery()).imageFile) != null)
                    Image.file(
                      File((Get.put(StockQuery()).imageFile)!.path),
                      width: 200,
                      height: 200,
                    ),
                  const SizedBox(height: 20),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton<AssetPathEntity>(
                        isExpanded: true,
                        value: selectedAlbum,
                        items: albums.map((album) {
                          return DropdownMenuItem<AssetPathEntity>(
                            value: album,
                            child: Text(album.name),
                          );
                        }).toList(),
                        onChanged: (selected) {
                          setState(() {
                            selectedAlbum = selected;
                            _loadPhotos(selectedAlbum!);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  children: images.map((AssetEntity asset) {
                    return FutureBuilder<Uint8List?>(
                      future: asset.thumbnailData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data != null) {
                          return GestureDetector(
                            onTap: () async{
                              File? file = await asset.file;
                              if (file != null) {
                                String filePath = file.path;
                                setState(() {
                                  _imageFile = XFile(filePath);
                                });

                                // print(arguments);
                                //Get.back();
                                _compressAndUploadImage();


                                //await CachedNetworkImage.evictFromCache("https://sanboxstock.appdev.live/images/product/nyota_TEALTD_1.jpg");
                                //Get.toNamed('/home');

                                /*DefaultCacheManager().removeFile("https://sanboxstock.appdev.live/images/product/nyota_TEALTD_1.jpg").then((value) {
                              print('File removed');
                            }).onError((error, stackTrace) {

                            });*/
                                //await DefaultCacheManager().removeFile('https://sanboxstock.appdev.live/images/product/nyota_TEALTD_1.jpg');

                              }
                              // Handle tap on image
                            },
                            child: Image.memory(
                              snapshot.data!,
                              fit: BoxFit.cover,
                            ),
                          );
                        } else {
                          return Container(); // Placeholder widget
                        }
                      },
                    );
                  }).toList(),
                ),
              ),

            ],

          ),
          GetBuilder<StockQuery>(
            builder: (myLoadercontroller) {
              //return Text('Data: ${_controller.data}');
              return
                (myLoadercontroller.hideLoader)?
                const Text(""):
                Positioned.fill(
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.white70,
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle onPressed for FloatingActionButton
          ////_pickImage(); // Call method to pick image when FloatingActionButton is pressed

          _pickImage(ImageSource.camera);
        },
        child: const Icon(Icons.photo_camera),
      ),

    );



  }


  }


//



