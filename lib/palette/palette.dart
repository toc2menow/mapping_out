import 'package:flutter/material.dart';

class Palette {
  final Color color;
  final String legend;
  int order;
  Palette({required this.color, required this.legend, required this.order});
}

class PaletteRow extends StatefulWidget {
  final Palette palette;
  final Function(int order) deletePalette;
  final Palette Function(int order, Color color, String legend) editPalette;

  PaletteRow(
      {Key? key,
      required this.palette,
      required this.deletePalette,
      required this.editPalette})
      : super(key: key) {
    print('asdf');
  }

  @override
  State<StatefulWidget> createState() {
    return _PaletteRowState();
  }
}

class _PaletteRowState extends State<PaletteRow> {
  Palette _palette = Palette(color: Colors.white, legend: "", order: 0);

  @override
  void initState() {
    super.initState();
    _palette = widget.palette;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(color: _palette.color),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _palette.legend,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(child: SizedBox()),
          IconButton(
              iconSize: 18.0,
              onPressed: () {
                setState(() {
                  _palette = widget.editPalette(
                      _palette.order, _palette.color, "test");
                });
              },
              icon: Icon(Icons.edit_outlined)),
          IconButton(
              iconSize: 18.0,
              onPressed: () => widget.deletePalette(_palette.order),
              icon: Icon(Icons.delete_outline))
        ],
      ),
    );
  }
}

class NewPalette extends StatelessWidget {
  final Function(Color color, String legend) notifyAddPalette;
  const NewPalette({super.key, required this.notifyAddPalette});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => {notifyAddPalette(Colors.orange, "new!")},
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.add), Text("Add")]),
        ));
  }
}
