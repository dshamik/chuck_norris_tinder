import 'dart:io';
import 'dart:math';
import 'package:flutter/cupertino.dart';

class ImageGenerator {
  final random = Random();
  final List<String> images = [
    'chuck_norris_1.jpeg',
    'chuck_norris_2.jpeg',
    'chuck_norris_3.jpeg',
    'chuck_norris_4.jpeg',
    'chuck_norris_5.jpeg',
    'chuck_norris_6.jpeg',
    'chuck_norris_7.jpeg',
    'chuck_norris_8.jpeg',
    'chuck_norris_9.jpeg',
    'chuck_norris_10.jpeg',
    'chuck_norris_11.jpeg',
    'chuck_norris_12.jpeg',
    'chuck_norris_13.jpeg',
  ];

  Image getImage() {
    var index = random.nextInt(images.length);

    return Image.asset("assets/images/${images[index]}");
  }
}