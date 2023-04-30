import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiktok/controllers/login_controller.dart';

import '../models/video_model.dart';

class DisplayVideoController extends GetxController {
  final Rx<List<VideoModel>> _videoList = Rx<List<VideoModel>>([]);
  //final authController = Get.find<LoginController>();

  List<VideoModel> get videoList => _videoList.value;
  @override
  void onInit() {
    super.onInit();

    _videoList.bindStream(FirebaseFirestore.instance
        .collection("videos")
        .snapshots()
        .map((event) {
      List<VideoModel> retVal = [];
      for (var element in event.docs) {
        retVal.add(VideoModel.fromMap(element));
      }
      return retVal;
    }));
  }

  likeVideo(String id) async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection("videos").doc(id).get();
    var uid = FirebaseAuth.instance.currentUser!.email;

    if ((doc.data() as dynamic)['likes'].contains(uid)) {
      await FirebaseFirestore.instance.collection("videos").doc(id).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await FirebaseFirestore.instance.collection("videos").doc(id).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }
  // var videos = <VideoModel>[].obs;
  // final FirebaseFirestore _db = FirebaseFirestore.instance;

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchVideos();
  // }

  // Future<void> fetchVideos() async {
  //   try {
  //     final QuerySnapshot querySnapshot = await _db.collection('videos').get();

  //     for (var element in querySnapshot.docs) {
  //       videos.add(VideoModel.fromMap(element));
  //     }
  //   } catch (e) {
  //     e.toString();
  //   }
  // }
}
