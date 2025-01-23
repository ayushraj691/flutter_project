import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:paycron/utils/my_toast.dart';

class CommonController extends GetxController {
  var imagePath = "".obs;

  String myDateAndTime(String toBeParsed, String formatThen, formatNow) {
    DateTime tempDate = DateFormat(formatThen).parse(toBeParsed);
    DateFormat getCurrentDateAndTime() => DateFormat(formatNow);
    String four = getCurrentDateAndTime().format(tempDate);
    return four;
  }

  DateTime currentDate = DateTime.now();

  Future<DateTime> selectDate(BuildContext context, DateTime date) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(2101));

    if (picked != null && picked != currentDate) {
      date = picked;
      return date;
    } else {
      return DateTime.parse("");
    }
  }

  Future showSelectionDialog(
    BuildContext context,
    Function(ImageSource) onTapCallback,
  ) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const Text(
                      'Select Image From',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            onTapCallback = await SeleImagefromGallery();
                            imagePath.value = onTapCallback as String;
                            // print('Image_path :-');
                            // print("**************");
                            // print(imagePath.value);
                            // print("*****************");
                            if (onTapCallback != null) {
                              Navigator.pop(context);
                            } else {
                              MyToast.toast('No Image selected');
                            }
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/gallery.png',
                                    height: 60,
                                    width: 60,
                                  ),
                                  const Text("Gallery")
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            onTapCallback = await SeleImagefromcamera();
                            // print('Image_path :-');
                            // print(onTapCallback);
                            if (onTapCallback != null) {
                              Navigator.pop(context);
                            } else {
                              MyToast.toast('No Image selected');
                            }
                          },
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/camera.png',
                                    height: 60,
                                    width: 60,
                                  ),
                                  const Text("Camera")
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  SeleImagefromGallery() async {
    var picture = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (picture != null) {
      return picture;
    } else {
      return "";
    }
  }

  SeleImagefromcamera() async {
    var picture = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (picture != null) {
      return picture;
    } else {
      return "";
    }
  }
}
