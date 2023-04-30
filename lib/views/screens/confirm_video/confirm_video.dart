import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../constant.dart';
import '../../../controllers/upload_video_controller.dart';
import '../../widgets/text_input_field.dart';

class ConfirmVideoScreen extends StatefulWidget {
  final File videoPath;
  const ConfirmVideoScreen({super.key, required this.videoPath});

  @override
  State<ConfirmVideoScreen> createState() => _ConfirmVideoScreenState();
}

class _ConfirmVideoScreenState extends State<ConfirmVideoScreen> {
  late TextEditingController _titleController;
  late TextEditingController _captionController;
  late VideoPlayerController _playerController;

  final upVideoController = Get.put(UploadVideoController());

  @override
  void initState() {
    _titleController = TextEditingController();
    _captionController = TextEditingController();
    setState(() {
      _playerController = VideoPlayerController.file(widget.videoPath);
    });

    _playerController.initialize();
    // _playerController.play();
    // _playerController.setLooping(true);
    // _playerController.setVolume(1);

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _captionController.dispose();
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .7,
              child: VideoPlayer(_playerController),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    height: 40,
                    child: TextInputField(
                        controller: _titleController,
                        labelText: "Song Name",
                        icon: Icons.music_note,
                        isObsecure: false),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    height: 40,
                    child: TextInputField(
                        controller: _captionController,
                        labelText: "Caption",
                        icon: Icons.description_rounded,
                        isObsecure: false),
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      upVideoController.uploadVideo(_titleController.text,
                          _captionController.text, widget.videoPath.path);
                    },
                    child: Ink(
                      height: 40,
                      width: 120,
                      color: buttonColor,
                      child: Center(child: Obx(() {
                        return upVideoController.isLoading.value
                            ? const Center(
                                child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ))
                            : const Text(
                                "Share",
                                style: TextStyle(fontSize: 18),
                              );
                      })),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
