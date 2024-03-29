import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/show_overlay_provider.dart';
import '../providers/theme_provider.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    Key? key,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.offsetY = 1,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final double offsetY;

  @override
  Widget build(BuildContext context) {
    return Consumer2<ShowOverlayProvider, ThemeProvider>(
        child: child,
        builder: (context, overlay, theme, ch) {
          return AnimatedSlide(
            curve: Curves.easeOutQuart,
            duration: const Duration(milliseconds: 200),
            offset: Offset(0, overlay.isShowOverlay ? 0 : offsetY * .8),
            child: AnimatedOpacity(
              curve: Curves.easeOutQuart,
              duration: const Duration(milliseconds: 200),
              opacity: overlay.isShowOverlay ? 1 : 0,
              child: Container(
                  padding: padding,
                  margin: EdgeInsets.all(theme.isDarkMode ? 6 : 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 6)
                      ]),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10),
                  //   color: Colors.blueAccent,
                  //   //theme.isDarkMode ? Colors.black : Colors.black87,
                  //   border: theme.isDarkMode
                  //       ? Border.all(width: 2, color: Colors.white54)
                  //       : null,
                  // ),
                  child: ch),
            ),
          );
        });
  }
}
