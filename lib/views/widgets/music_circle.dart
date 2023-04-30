import 'package:flutter/material.dart';

class MusicCircle extends StatefulWidget {
  final String thumbnailUrl;
  const MusicCircle({
    super.key,
    required this.thumbnailUrl,
  });

  @override
  State<MusicCircle> createState() => _MusicCircleState();
}

class _MusicCircleState extends State<MusicCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 5000));
    animationController.forward();
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(animationController),
      child: Container(
        height: 60,
        width: 60,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: [
            Colors.white,
            Colors.grey,
          ]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image(
                image: NetworkImage(widget.thumbnailUrl),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
