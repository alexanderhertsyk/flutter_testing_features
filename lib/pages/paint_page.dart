import 'package:flutter/material.dart';

class PaintPage extends StatefulWidget {
  const PaintPage({super.key});

  static const String route = '/paint';

  @override
  State<PaintPage> createState() => _PaintPageState();
}

class _PaintPageState extends State<PaintPage> {
  List<Offset?> _points = <Offset?>[];

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      final RenderBox referenceBox = context.findRenderObject() as RenderBox;
      var shiftedOffset = Offset(
        details.globalPosition.dx,
        details.globalPosition.dy - 105,
      );
      final Offset localPosition = referenceBox.globalToLocal(shiftedOffset);
      // new list is needed to have 'shouldRepaint' works
      _points = List.from(_points)..add(localPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(PaintPage.route),
      ),
      body: GestureDetector(
        onPanUpdate: _onPanUpdate,
        onPanEnd: (details) => _points.add(null),
        child: CustomPaint(
          painter: SignaturePainter(_points),
          size: Size.infinite,
        ),
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.delete_outline),
        onPressed: () => setState(() => _points.clear()),
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  const SignaturePainter(this.points);

  final List<Offset?> points;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) =>
      oldDelegate.points != points;
}
