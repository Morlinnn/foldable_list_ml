import 'dart:ui';

import 'package:foldable_list_ml/foldable_list/tile_manager.dart';
import 'package:foldable_list_ml/foldable_list/widgets/tile_item.dart';

import '../context_controller.dart';

/// Bind the [TileItem] and [TileManager] to provide operation methods at rootContents
class BoundTileItem extends TileItem {
  final ContextController controller;

  BoundTileItem({
    super.key,
    required this.controller,
    super.title,
    super.leading,
    super.trailing,
    super.titleMargin,
    super.onTap,
    super.onDoubleTap,
    super.onLongPress,
    super.onTapDown,
    super.onTapUp,
    super.onTapCancel,
    super.onSecondaryTap,
    super.onSecondaryTapUp,
    super.onSecondaryTapDown,
    super.onSecondaryTapCancel,
    super.onHighlightChanged,
    super.onHover,
    super.mouseCursor,
    super.focusColor,
    super.hoverColor,
    super.highlightColor,
    super.overlayColor,
    super.splashColor,
    super.splashFactory,
    super.radius,
    super.borderRadius,
    super.customBorder,
    super.enableFeedback = true,
    super.excludeFromSemantics = false,
    super.focusNode,
    super.canRequestFocus = true,
    super.onFocusChange,
    super.autofocus = false,
    super.statesController,
    super.alignment,
    super.padding,
    super.color,
    super.decoration,
    super.foregroundDecoration,
    super.width,
    super.height,
    super.constraints,
    super.margin,
    super.transform,
    super.transformAlignment,
    super.clipBehavior = Clip.none,
  }) {
    controller.bindWidget(this);
  }

  @override
  String toStringShort() {
    return '[BoundTileItem@$hashCode, controller=$controller]';
  }
}