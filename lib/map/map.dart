import 'dart:math';
import 'package:flutter/material.dart';

class Location {
  final double x;
  final double y;
  final String name;
  final double width;
  final double height;
  const Location(
      {required this.x,
      required this.y,
      this.name = '',
      this.width = 1,
      this.height = 1});
}

class CityBlock extends StatelessWidget {
  final double width;
  final double height;
  final String name;
  final List colors;

  const CityBlock({
    super.key,
    required this.width,
    required this.height,
    required this.name,
    this.colors = const [Colors.black26],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black54,
        ),
        borderRadius: BorderRadius.all(Radius.circular(5)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment((0.5 / (width / min(width, height)) - 1),
              (0.5 / (height / min(width, height)) - 1)),
          stops: [0.0, 0.3, 0.3, 0.6, 0.6, 1],
          colors: [
            Colors.red,
            Colors.red,
            Colors.orange,
            Colors.orange,
            Colors.blue,
            Colors.blue,
          ],
          tileMode: TileMode.repeated,
        ),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () => {},
        child: Text(name, style: TextStyle(fontSize: 8, color: Colors.black87)),
      ),
    );
  }
}

class MapContent extends StatelessWidget {
  final List<Location> locations;
  final _size = 30.0;
  final _padding = 2.0;

  MapContent({super.key, required this.locations});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        for (var loc in locations)
          Positioned(
            left: (_size + _padding) * loc.x,
            top: (_size + _padding) * loc.y,
            child: CityBlock(
              width: _size * loc.width,
              height: _size * loc.height,
              name: loc.name,
            ),
          ),
      ],
    );
  }
}
