// import 'package:flutter/material.dart';
//
// class WaveSkeletonBox extends StatefulWidget {
//   final double? width;
//   final double height;
//   final BorderRadius? borderRadius;
//
//   const WaveSkeletonBox({
//     super.key,
//     this.width,
//     required this.height,
//     this.borderRadius,
//   });
//
//   @override
//   State<WaveSkeletonBox> createState() => _WaveSkeletonBoxState();
// }
//
// class _WaveSkeletonBoxState extends State<WaveSkeletonBox>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1400),
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final resolvedWidth = widget.width ?? constraints.maxWidth;
//           return AnimatedBuilder(
//             animation: _controller,
//             builder: (_, __) {
//               return CustomPaint(
//                 size: Size(resolvedWidth, widget.height),
//                 painter: _WavePainter(_controller.value),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// class _WavePainter extends CustomPainter {
//   final double progress;
//   _WavePainter(this.progress);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final basePaint = Paint()..color = Colors.grey.shade300;
//     canvas.drawRect(Offset.zero & size, basePaint);
//
//     final dx = -size.width + (progress * size.width * 2.5);
//     final gradient = LinearGradient(
//       colors: [
//         Colors.grey.shade300,
//         Colors.grey.shade100,
//         Colors.grey.shade300,
//       ],
//       stops: const [0.35, 0.5, 0.65],
//     );
//
//     final wavePaint = Paint()
//       ..shader = gradient.createShader(
//         Rect.fromLTWH(dx, 0, size.width * 1.5, size.height),
//       );
//
//     canvas.drawRect(Offset.zero & size, wavePaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant _WavePainter old) => old.progress != progress;
// }

import 'package:flutter/material.dart';

class WaveSkeletonBox extends StatefulWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const WaveSkeletonBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  State<WaveSkeletonBox> createState() => _WaveSkeletonBoxState();
}

class _WaveSkeletonBoxState extends State<WaveSkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final resolvedWidth = widget.width ?? constraints.maxWidth;
          final resolvedHeight = widget.height ?? constraints.maxHeight;
          return AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return CustomPaint(
                size: Size(resolvedWidth, resolvedHeight),
                painter: _WavePainter(_controller.value),
              );
            },
          );
        },
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  final double progress;
  _WavePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final basePaint = Paint()..color = Colors.grey.shade300;
    canvas.drawRect(Offset.zero & size, basePaint);

    final dx = -size.width + (progress * size.width * 2.5);
    final gradient = LinearGradient(
      colors: [
        Colors.grey.shade300,
        Colors.grey.shade100,
        Colors.grey.shade300,
      ],
      stops: const [0.35, 0.5, 0.65],
    );

    final wavePaint = Paint()
      ..shader = gradient.createShader(
        Rect.fromLTWH(dx, 0, size.width * 1.5, size.height),
      );

    canvas.drawRect(Offset.zero & size, wavePaint);
  }

  @override
  bool shouldRepaint(covariant _WavePainter old) => old.progress != progress;
}
