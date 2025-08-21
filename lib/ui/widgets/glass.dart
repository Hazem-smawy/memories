// import 'dart:ui';
// import 'package:flutter/material.dart';

// class GlassContainer extends StatelessWidget {
//   final Widget child;
//   final double blur;
//   final double opacity;
//   final EdgeInsets padding;
//   final BorderRadius borderRadius;

//   const GlassContainer({
//     super.key,
//     required this.child,
//     this.blur = 20,
//     this.opacity = .15,
//     this.padding = const EdgeInsets.all(12),
//     this.borderRadius = const BorderRadius.all(Radius.circular(20)),
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: borderRadius,
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
//         child: Container(
//           padding: padding,
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(opacity),
//             borderRadius: borderRadius,
//             border: Border.all(color: Colors.white.withOpacity(0.2)),
//           ),
//           child: child,
//         ),
//       ),
//     );
//   }
// }
