import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/const_colors.dart';

class AddImageWidget extends StatefulWidget {
  const AddImageWidget({super.key});

  @override
  State<AddImageWidget> createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends State<AddImageWidget> {
  Uint8List? _image;
  File? selectedImage;
  String? thumbnailImagePath; // Variable to hold the thumbnail image path
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      alignment: Alignment.bottomCenter,
      color: backgoundColor,
      height: 350,
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
                    width: 150,
                    child: const Center(
                      child: Text(
                        "Product Gallery",
                        style: TextStyle(
                            color: orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, bottom: 5, top: 5),
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
                            color: Colors.grey[200],
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
                    width: 150,
                    child: const Center(
                      child: Text(
                        "Product Thumbnail",
                        style: TextStyle(
                            color: orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    width: 0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 100, right: 30, bottom: 5, top: 5),
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
                              color: Colors.grey[200],
                              child: _image != null
                                  ? Image.memory(_image!, fit: BoxFit.cover)
                                  : Tooltip(
                                      message: "Pack images",
                                      child: Image.asset(
                                        'assets/images/addImages.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
      ),
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _pickImageFromGallery();
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
}
