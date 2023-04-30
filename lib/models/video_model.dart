// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class VideoModel extends Equatable {
  final String username;
  final String uid;
  final String id;
  final List likes;
  final int commentCount;
  final int shareCount;
  final String songName;
  final String caption;
  final String videoUrl;
  final String thumbnail;
  final String profilePhoto;
  const VideoModel({
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.videoUrl,
    required this.thumbnail,
    required this.profilePhoto,
  });

  VideoModel copyWith({
    String? username,
    String? uid,
    String? id,
    List? likes,
    int? commentCount,
    int? shareCount,
    String? songName,
    String? caption,
    String? videoUrl,
    String? thumbnail,
    String? profilePhoto,
  }) {
    return VideoModel(
      username: username ?? this.username,
      uid: uid ?? this.uid,
      id: id ?? this.id,
      likes: likes ?? this.likes,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
      songName: songName ?? this.songName,
      caption: caption ?? this.caption,
      videoUrl: videoUrl ?? this.videoUrl,
      thumbnail: thumbnail ?? this.thumbnail,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'uid': uid,
      'id': id,
      'likes': likes,
      'commentCount': commentCount,
      'shareCount': shareCount,
      'songName': songName,
      'caption': caption,
      'videoUrl': videoUrl,
      'thumbnail': thumbnail,
      'profilePhoto': profilePhoto,
    };
  }

  factory VideoModel.fromMap(dynamic map) {
    return VideoModel(
      username: (map["username"] ?? '') as String,
      uid: (map["uid"] ?? '') as String,
      id: (map["id"] ?? '') as String,
      likes: List.from(
        ((map['likes'] ?? const <dynamic>[]) as List),
      ),
      commentCount: (map["commentCount"] ?? 0) as int,
      shareCount: (map["shareCount"] ?? 0) as int,
      songName: (map["songName"] ?? '') as String,
      caption: (map["caption"] ?? '') as String,
      videoUrl: (map["videoUrl"] ?? '') as String,
      thumbnail: (map["thumbnail"] ?? '') as String,
      profilePhoto: (map["profilePhoto"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) =>
      VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      username,
      uid,
      id,
      likes,
      commentCount,
      shareCount,
      songName,
      caption,
      videoUrl,
      thumbnail,
      profilePhoto,
    ];
  }
}
