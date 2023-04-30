import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/display_video_controller.dart';
import '../../widgets/music_circle.dart';
import 'video_player_item.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final displayVideoController = Get.put(DisplayVideoController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() {
        return PageView.builder(
            scrollDirection: Axis.vertical,
            controller: PageController(initialPage: 0, viewportFraction: 1.0),
            itemCount: displayVideoController.videoList.length,
            itemBuilder: (context, index) {
              final data = displayVideoController.videoList[index];
              return Stack(
                children: [
                  VideoPlayerItem(videoUrl: data.videoUrl),
                  Column(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      data.username,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      data.songName,
                                      style: const TextStyle(
                                          fontSize: 15, color: Colors.white),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.music_note, size: 16),
                                        Text(
                                          data.songName,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 40),
                              width: 100,
                              height: size.height / 2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image(
                                        image: NetworkImage(data.profilePhoto),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Column(
                                      children: [
                                        const InkWell(
                                          // onTap: () => displayVideoController
                                          //     .likeVideo(data.uid),
                                          child: Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 48,
                                          ),
                                        ),
                                        Text(
                                          data.likes.length.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.comment,
                                          size: 48,
                                          color: Colors.white,
                                        ),
                                        Text(data.commentCount.toString()),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    child: Column(
                                      children: [
                                        const Icon(Icons.reply,
                                            size: 48, color: Colors.white),
                                        Text(data.shareCount.toString()),
                                      ],
                                    ),
                                  ),
                                  MusicCircle(
                                    thumbnailUrl: data.thumbnail,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              );
            });
      }),
    );
  }
}
