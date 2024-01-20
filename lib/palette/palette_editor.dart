import 'package:flutter/material.dart';
import 'package:mapping_out/palette/palette.dart';

class PaletteEditor extends StatefulWidget {
  final List<Palette> palette;
  final Function(List<Palette> palette) notifyPaletteChanged;
  PaletteEditor(
      {super.key, required this.palette, required this.notifyPaletteChanged});

  @override
  State<PaletteEditor> createState() => _PaletteEditorState();
}

class _PaletteEditorState extends State<PaletteEditor> {
  List<Palette> _palette = [];

  @override
  void initState() {
    super.initState();
    _palette = widget.palette;
  }

  Palette editPalette(int order, Color color, String legend) {
    List<Palette> newPaletteList = [];
    final newPalette = Palette(order: order, color: color, legend: legend);
    for (var p in _palette) {
      if (p.order == order) {
        newPaletteList.add(newPalette);
      } else {
        newPaletteList.add(p);
      }
    }
    widget.notifyPaletteChanged(_palette);
    return newPalette;
  }

  Palette addPalette(Color color, String legend) {
    var order = 1;
    if (_palette.isNotEmpty) {
      final lastPalette = _palette[_palette.length - 1];
      order = lastPalette.order + 1;
    }
    final newPalette = Palette(order: order, color: color, legend: legend);
    _palette.add(newPalette);
    widget.notifyPaletteChanged(_palette);
    setState(() {
      _palette = List.from(_palette);
    });
    return newPalette;
  }

  void deletePalette(int order) {
    for (var p in _palette) {
      if (p.order == order) {
        _palette.remove(p);
        break;
      }
    }

    var i = 1;
    for (final p in _palette) {
      p.order = i;
      i += 1;
    }
    widget.notifyPaletteChanged(_palette);
    setState(() {
      _palette = List.from(_palette);
    });
  }

  @override
  Widget build(BuildContext context) {
    final newNeeded = _palette.length < 4;
    return Container(
      height: 270,
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Custom Palette",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Expanded(child: SizedBox()),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (var p in _palette)
                        PaletteRow(
                          key: UniqueKey(),
                          palette: p,
                          deletePalette: (order) => deletePalette(order),
                          editPalette: ((order, color, legend) =>
                              editPalette(order, color, legend)),
                        ),
                      if (newNeeded)
                        NewPalette(notifyAddPalette: (color, legend) {
                          setState(() {
                            addPalette(color, legend);
                          });
                        }),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
