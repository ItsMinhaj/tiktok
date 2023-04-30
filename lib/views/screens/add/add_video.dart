import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constant.dart';
import '../confirm_video/confirm_video.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  selectVideo(ImageSource source, BuildContext context) async {
    ImagePicker picker = ImagePicker();
    final pickedVideo = await picker.pickVideo(source: source);
    if (pickedVideo != null) {
      // Get.to(ConfirmVideoScreen(
      //   videoPath: pickedVideo.path ,
      // ));
      // ignore: use_build_context_synchronously
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) =>
              ConfirmVideoScreen(videoPath: File(pickedVideo.path))));
    }
  }

  optionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Choose From"),
            content: SizedBox(
              height: 200,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.camera),
                    title: const Text("Camera"),
                    onTap: () {
                      selectVideo(ImageSource.camera, context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.image),
                    title: const Text("Gallery"),
                    onTap: () {
                      selectVideo(ImageSource.gallery, context);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.cancel),
                    title: const Text("Cancel"),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            optionDialog(context);
          },
          child: Ink(
            height: 40,
            width: 120,
            color: buttonColor,
            child: const Center(child: Text("Add Video")),
          ),
        ),
      ),
    );
  }
}
