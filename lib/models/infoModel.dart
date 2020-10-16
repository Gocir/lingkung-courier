import 'package:flutter/Material.dart';

class InfoModel {
  final String id;
  final String category;
  final String name;
  final String imageUrl;
  final String linkUrl;
  final String source;

  // name constructors
  InfoModel({@required this.id, @required this.category, @required this.name, @required this.imageUrl, @required this.linkUrl, @required this.source});
}
