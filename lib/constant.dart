import 'package:flutter/material.dart';

import 'views/screens/add/add_video.dart';
import 'views/screens/display_video/video_screen.dart';

// Colors
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

// BottomNavigationBar pages
const pages = [
  VideoScreen(),
  Center(child: Text("Search")),
  AddVideoScreen(),
  Center(child: Text("Message")),
  Center(child: Text("Profile")),
];
