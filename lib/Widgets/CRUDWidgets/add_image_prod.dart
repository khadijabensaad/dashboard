import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

//import 'package:image_cropper/image_cropper.dart';
import '../../constants/const_colors.dart';

class AddImageProd extends StatefulWidget {
  const AddImageProd({super.key});

  @override
  State<AddImageProd> createState() => _AddImageProdState();
}

class _AddImageProdState extends State<AddImageProd> {
  Uint8List? _image;
  File? selectedImage;
  //List<String> images = [];
  List<XFile> imageFileList = [];
  void selectedImages() async {
    final ImagePicker imagePicker = ImagePicker();
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList.addAll(selectedImages);
    }
    setState(() {});
  }
  /*void selectedImages() async {
    final ImagePicker imagePicker = ImagePicker();
    final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages != null && selectedImages.isNotEmpty) {
    //  imageFileList!.addAll(selectedImages);
      imageFileList!.addAll(selectedImages);
    }
  }*/

  String? thumbnailImagePath; // Variable to hold the thumbnail image path
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          alignment: Alignment.bottomCenter,
          color: backgoundColor,
          height: 290,
          width: 600,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: backgoundColor,
                        height: 40,
                        width: 100,
                        child: const Center(
                          child: Text(
                            "Product Gallery",
                            style: TextStyle(
                                color: orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            showImagePickerOption(context);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 100,
                              height: 100,
                              color: backgoundColor,
                              child: _image != null
                                  ? Image.memory(_image!, fit: BoxFit.cover)
                                  : Image.asset(
                                      'assets/images/addImage.png',
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: backgoundColor,
                        height: 40,
                        width: 100,
                        child: const Center(
                          child: Text(
                            "Product Thumbnail",
                            style: TextStyle(
                                color: orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 0, bottom: 5, top: 5),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  showImagePickerOption(context);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    // color: Colors.grey[200],
                                    color: Colors.transparent,
                                    child: Image.asset(
                                      'assets/images/addImages.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
          ),
        ),
        SizedBox(
          height: 600,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                itemCount: imageFileList.length,
                //itemCount: imageFileList!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Image.file(
                    File(imageFileList[index].path),
                    fit: BoxFit.cover,
                  );
                }),
          ),
        )
      ],
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: const Color(0xFFFDF1E1),
        context: context,
        builder: (builder) {
          return SizedBox(
            height: 150,
            width: double.infinity,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Text(
                    "Choose Your Product Picture :",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        color: darkBrown),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Tooltip(
                        message: "Pack images",
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // _pickImageFromGallery();
                            // _imagePicker();
                            selectedImages();
                          },
                          icon: const Icon(
                            CupertinoIcons.photo_fill_on_rectangle_fill,
                            color: darkBrown,
                          ),
                          label: const Text(
                            'Gallery',
                            style: TextStyle(
                                color: darkBrown,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
      thumbnailImagePath = returnImage.path;
    });
    Navigator.of(context).pop();
  }

/*  void _imagePicker() async {
    selectedImages();
    setState(() {});
  }*/

  /*void _imagePicker() async {
    var imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

    if (file != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: file.path,
          compressQuality: 10,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: backgoundColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false,
            ),
            IOSUiSettings(
              title: 'Cropper',
            ),
            WebUiSettings(
              context: context,
            ),
          ]);
      if (croppedFile?.path != null) {
        setState(() {
          thumbnailImagePath =
              croppedFile?.path; // Assign the path to thumbnailImagePath
          // Add the path to the list if it's not null
          if (thumbnailImagePath != null) {
            images
                .add(thumbnailImagePath!); // Add the non-null path to the list
          }
        });
      }
    }
  }*/
}
