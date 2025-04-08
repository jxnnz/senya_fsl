import 'package:flutter/material.dart';

// Define a class to hold layout configurations
class LayoutConfig {
  // Sidebar properties
  final double sidebarWidthExpandedDesktop;
  final double sidebarWidthCollapsedDesktop;
  final double mobileSidebarWidth;
  final double sidebarIconSize;
  final double sidebarIconPadding;
  final double sidebarLabelFontSize;

  // AppBar properties
  final double appBarPaddingHorizontal;
  final double appBarPaddingVertical;
  final double appBarIconSize;
  final double appBarIconSpacing;
  final double appBarTextFontSize;

  // Main Content properties
  final EdgeInsets screenPadding;
  final double unitSectionSpacing;

  // Lesson Card properties
  final double lessonCardHeight;
  final EdgeInsets lessonCardPadding;
  final double lessonImageWidth;
  final double lessonImageHeight;

  LayoutConfig({
    required this.sidebarWidthExpandedDesktop,
    required this.sidebarWidthCollapsedDesktop,
    required this.mobileSidebarWidth,
    required this.sidebarIconSize,
    required this.sidebarIconPadding,
    required this.sidebarLabelFontSize,
    required this.appBarPaddingHorizontal,
    required this.appBarPaddingVertical,
    required this.appBarIconSize,
    required this.appBarIconSpacing,
    required this.appBarTextFontSize,
    required this.screenPadding,
    required this.unitSectionSpacing,
    required this.lessonCardHeight,
    required this.lessonCardPadding,
    required this.lessonImageWidth,
    required this.lessonImageHeight,
  });
}
