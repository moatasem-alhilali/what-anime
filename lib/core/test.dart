import 'dart:math';

import 'package:flutter/material.dart';

// class ScannerAnimation extends StatefulWidget {
//   final double height;
//   final double width;

//   const ScannerAnimation({required this.height, required this.width});

//   @override
//   _ScannerAnimationState createState() => _ScannerAnimationState();
// }

// class _ScannerAnimationState extends State<ScannerAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     )..addListener(() {
//         setState(() {});
//       });
//     _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: ScannerPainter(_animation.value),
//       child: Container(
//         height: widget.height,
//         width: widget.width,
//       ),
//     );
//   }
// }

// class ScannerPainter extends CustomPainter {
//   final double value;

//   ScannerPainter(this.value);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0
//       ..strokeCap = StrokeCap.round;

//     final path = Path()
//       ..moveTo(0, size.height * value)
//       ..lineTo(0, size.height * (value - 0.1))
//       ..lineTo(size.width, size.height * (value - 0.2))
//       ..lineTo(size.width, size.height * (value - 0.3))
//       ..lineTo(0, size.height * (value - 0.4))
//       ..lineTo(0, size.height * (value - 0.5))
//       ..close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }

// class PulseAnimation extends StatefulWidget {
//   final double size;
//   final Color color;

//   const PulseAnimation({this.size = 100, this.color = Colors.blue});

//   @override
//   _PulseAnimationState createState() => _PulseAnimationState();
// }

// class _PulseAnimationState extends State<PulseAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 2),
//     )
//       ..addListener(() {
//         setState(() {});
//       })
//       ..repeat(reverse: true);
//     _animation = Tween<double>(begin: 1.0, end: 1.5).animate(_controller);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return Container(
//           width: widget.size * _animation.value,
//           height: widget.size * _animation.value,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: widget.color.withOpacity(0.5 - (_animation.value / 3)),
//           ),
//         );
//       },
//     );
//   }
// }

// //-------------------------------------------------------------------------------

class ScannerAnimationTow extends StatefulWidget {
  final Color backgroundColor;
  final Color scanningColor;
  final double scanningWidth;
  final double scanningDuration;

  ScannerAnimationTow({
    this.backgroundColor = Colors.red,
    this.scanningColor = Colors.white,
    this.scanningWidth = 200,
    this.scanningDuration = 1500,
  });

  @override
  _ScannerAnimationState createState() => _ScannerAnimationState();
}

class _ScannerAnimationState extends State<ScannerAnimationTow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.scanningDuration.round()),
    )..repeat();
    _animation =
        Tween<double>(begin: 0, end: widget.scanningWidth).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _ScannerPainter(
            backgroundColor: widget.backgroundColor,
            scanningColor: widget.scanningColor,
            scanningWidth: widget.scanningWidth,
            scanningOffset: _animation.value - (widget.scanningWidth / 2),
          ),
        );
      },
    );
  }
}

class _ScannerPainter extends CustomPainter {
  final Color backgroundColor;
  final Color scanningColor;
  final double scanningWidth;
  final double scanningOffset;

  _ScannerPainter({
    this.backgroundColor = Colors.black,
    this.scanningColor = Colors.white,
    this.scanningWidth = 200,
    this.scanningOffset = 0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = backgroundColor;
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    final scanningPaint = Paint()
      ..color = scanningColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final scanningPath = Path()
      ..moveTo((size.width / 2) - (scanningWidth / 2) + scanningOffset, 0)
      ..lineTo((size.width / 2) + (scanningWidth / 2) + scanningOffset, 0)
      ..lineTo(
          (size.width / 2) + (scanningWidth / 2) - scanningOffset, size.height)
      ..lineTo(
          (size.width / 2) - (scanningWidth / 2) - scanningOffset, size.height)
      ..close();

    canvas.drawPath(scanningPath, scanningPaint);
  }

  @override
  bool shouldRepaint(_ScannerPainter oldDelegate) {
    return scanningOffset != oldDelegate.scanningOffset;
  }
}
