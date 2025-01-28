library;

import 'package:flutter/material.dart';

/// A beautiful and animated bottom navigation that paints a rounded shape
/// around its [items] to provide a wonderful look.
///
/// Update [selectedIndex] to change the selected item.
/// [selectedIndex] is required and must not be null.
class BottomNavyBar extends StatelessWidget {
  const BottomNavyBar({
    super.key,
    this.selectedIndex = 0,
    this.showElevation = true,
    // this.iconSize = 24,
    this.iconSize,
    this.backgroundColor,
    this.shadowColor = Colors.black12,
    this.itemCornerRadius = 10.0,
    this.containerHeight,
    this.blurRadius = 2,
    this.spreadRadius = 0,
    this.borderRadius,
    this.shadowOffset = Offset.zero,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 4),
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.center,
    required this.items,
    required this.onItemSelected,
    this.curve = Curves.linear,
    this.selectedFontSize = 12.0,
    this.unselectedFontSize = 12.0,
    this.selectedIconSize = 23.0,
    this.unselectedIconSize = 20.0,
    this.flexIndex = 1,
  })  : assert(items.length >= 2 && items.length <= 5);

  /// The selected item is index. Changing this property will change and animate
  /// the item being selected. Defaults to zero.
  final int selectedIndex;

  /// The icon size of all items. Defaults to 24.
  final double? iconSize;

  /// The background color of the navigation bar. It defaults to
  /// [ThemeData.bottomAppBarTheme.color] if not provided.
  final Color? backgroundColor;

  /// Defines the shadow color of the navigation bar. Defaults to [Colors.black12].
  final Color shadowColor;

  /// Whether this navigation bar should show a elevation. Defaults to true.
  final bool showElevation;

  /// Use this to change the item's animation duration. Defaults to 270ms.
  final Duration animationDuration;

  /// Defines the appearance of the buttons that are displayed in the bottom
  /// navigation bar. This should have at least two items and five at most.
  final List<BottomNavyBarItem> items;

  /// A callback that will be called when a item is pressed.
  final ValueChanged<int> onItemSelected;

  /// Defines the alignment of the items.
  /// Defaults to [MainAxisAlignment.center].
  final MainAxisAlignment mainAxisAlignment;

  /// The [items] corner radius, if not set, it defaults to 10.0.
  final double itemCornerRadius;

  /// Defines the bottom navigation bar height. Defaults to 56.
  final double? containerHeight;

  /// Used to configure the blurRadius of the [BoxShadow]. Defaults to 2.
  final double blurRadius;

  /// Used to configure the spreadRadius of the [BoxShadow]. Defaults to 0.
  final double spreadRadius;

  /// Used to configure the offset of the [BoxShadow]. Defaults to null.
  final Offset shadowOffset;

  /// Used to configure the borderRadius of the [BottomNavyBar]. Defaults to null.
  final BorderRadiusGeometry? borderRadius;

  /// Used to configure the padding of the [BottomNavyBarItem] [items].
  /// Defaults to EdgeInsets.symmetric(horizontal: 4).
  final EdgeInsets itemPadding;

  /// Used to configure the animation curve. Defaults to [Curves.linear].
  final Curve curve;

  final double selectedFontSize;

  final double unselectedFontSize;
  final double selectedIconSize;
  final double unselectedIconSize;
  final int flexIndex;

  @override
  Widget build(BuildContext context) {
    final Color bgColor =
        backgroundColor ?? Colors.white;
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          if (showElevation)
            BoxShadow(
              color: shadowColor,
              blurRadius: blurRadius,
              spreadRadius: spreadRadius,
              offset: shadowOffset,
            ),
        ],
        borderRadius: borderRadius,
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight ?? kBottomNavigationBarHeight,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: items.map((item) {
              var index = items.indexOf(item);
              return Expanded(
                flex: index == flexIndex ? 4 : 3,
                child: GestureDetector(
                  onTap: () => onItemSelected(index),
                  child: _ItemWidget(
                    item: item,
                    iconSize: iconSize,
                    isSelected: index == selectedIndex,
                    backgroundColor: bgColor,
                    itemCornerRadius: itemCornerRadius,
                    animationDuration: animationDuration,
                    itemPadding: itemPadding,
                    curve: curve,
                    unselectedFontSize: unselectedFontSize,
                    selectedFontSize: selectedFontSize,
                    selectedIconSize: selectedIconSize,
                    unselectedIconSize: unselectedIconSize,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final double? iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;
  final EdgeInsets itemPadding;
  final Curve curve;
  final double selectedFontSize;
  final double unselectedFontSize;

  final double selectedIconSize;
  final double unselectedIconSize;

  const _ItemWidget({
    required this.iconSize,
    required this.isSelected,
    required this.item,
    required this.backgroundColor,
    required this.itemCornerRadius,
    required this.animationDuration,
    required this.itemPadding,
    this.curve = Curves.linear,
    required this.selectedFontSize,
    required this.unselectedFontSize,
    required this.selectedIconSize,
    required this.unselectedIconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      selected: isSelected,
      child: AnimatedContainer(
        width: double.maxFinite,
        height: double.maxFinite,
        duration: animationDuration,
        curve: curve,
        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: isSelected
              ? item.backgroundColorItem ?? item.activeColor.withValues(alpha: 0.2)
              : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius),
        ),
        child: SingleChildScrollView(
          // scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: kToolbarHeight,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconTheme(
                    data: IconThemeData(
                      size: iconSize ??
                          (isSelected ? selectedIconSize : unselectedIconSize),
                      color: isSelected
                          ? item.activeColor.withValues(alpha: 1)
                          : item.inactiveColor ?? item.activeColor,
                    ),
                    child: item.icon,
                  ),
                  const SizedBox(height: 3.0),
                  // if (isSelected)
                  Container(
                    padding: itemPadding,
                    child: DefaultTextStyle.merge(
                      style: TextStyle(
                        color:
                            isSelected ? item.activeColor : item.inactiveColor,
                        fontWeight: FontWeight.bold,
                        fontSize:
                            isSelected ? selectedFontSize : unselectedFontSize,
                      ),
                      maxLines: 1,
                      textAlign: item.textAlign,
                      child: item.title,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The [BottomNavyBar.items] definition.
class BottomNavyBarItem {
  BottomNavyBarItem({
    required this.icon,
    required this.title,
    this.activeColor = Colors.blue,
    this.backgroundColorItem,
    this.textAlign,
    this.inactiveColor,
  });

  /// Defines this item's icon which is placed in the right side of the [title].
  final Widget icon;

  /// Defines this item's title which placed in the left side of the [icon].
  final Widget title;

  /// The [icon] and [title] color defined when this item is selected. Defaults
  /// to [Colors.blue].
  final Color activeColor;

  /// The [icon] and [title] color defined when this item is not selected.
  final Color? inactiveColor;

  /// The alignment for the [title].
  ///
  /// This will take effect only if [title] it a [Text] widget.
  final TextAlign? textAlign;

  final Color? backgroundColorItem;
}
