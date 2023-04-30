import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';

import '../models/video_model.dart';

class UploadVideoController extends GetxController {
  RxBool isLoading = false.obs;

  uploadVideo(String songName, String caption, String videoPath) async {
    isLoading.value = true;
    try {
      String? uid = FirebaseAuth.instance.currentUser!.email;

      // to get all the USERS docs id
      DocumentSnapshot userDocs =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      // to get VIDEOS id
      final allVideoDocs =
          await FirebaseFirestore.instance.collection("videos").get();
      int length = allVideoDocs.docs.length;

      // For insert all type of data as required VideoModel
      // we need to fetch "users" collection to get (name,photoUrl etc) which are already stored.
      // fetch "videos" collect to get videos ID

      String videoUrl = await uploadVideoToStorage(videoPath);
      String thumbnail = await uploadThumbailToStorage(uid!, videoPath);

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      VideoModel videoModel = VideoModel(
          username: (userDocs.data() as Map<String, dynamic>)['name'],
          uid: uid,
          id: "Video $length",
          likes: const [],
          commentCount: 0,
          shareCount: 0,
          songName: songName,
          caption: caption,
          videoUrl: videoUrl,
          thumbnail: thumbnail,
          profilePhoto:
              (userDocs.data() as Map<String, dynamic>)['profilePhoto']);
      await firestore
          .collection("videos")
          .doc("Video $length")
          .set(videoModel.toMap());

      isLoading.value = false;
      Get.back();
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  // upload video to storage
  Future<String> uploadVideoToStorage(String videoPath) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("videos")
        .child(DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(await videoCompressed(videoPath));

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  // Get thumbnail from video file

  getThumbnail(String videoPath) async {
    final thubmnail = await VideoCompress.getFileThumbnail(videoPath);
    return thubmnail;
  }

  Future<String> uploadThumbailToStorage(String id, String videoPath) async {
    Reference ref =
        FirebaseStorage.instance.ref().child("thumbnails").child(id);

    UploadTask uploadTask = ref.putFile(await getThumbnail(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // Compress Video file

  Future videoCompressed(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.DefaultQuality,
      deleteOrigin: false, // It's false by default
    );
    return compressedVideo!.file;
  }
}
