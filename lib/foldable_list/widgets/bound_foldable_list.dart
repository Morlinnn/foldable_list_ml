import 'package:flutter/material.dart';
import 'package:foldable_list_ml/foldable_list/context_controller.dart';
import 'package:foldable_list_ml/foldable_list/state_pack.dart';
import 'package:foldable_list_ml/foldable_list/tile_manager.dart';
import 'package:foldable_list_ml/foldable_list/widgets/foldable_list.dart';

/// Bind the [FoldableList] and [TileManager] to provide operation methods at rootContents
class BoundFoldableList extends FoldableList {
  final ContextController controller;

  BoundFoldableList({
    super.key,
    required this.controller,
    bool initExpended = true,
    List<Widget>? stateChildren,
    required super.title,
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
  }) : super(
    statePack: StatePack(
      initExpended: initExpended,
      stateChildren: stateChildren,
      rebuildStateFunctionCallBack: (func) {
        controller.rebuildStateFunction = func;
      }
    ),
  ) {
    controller.bindWidget(this);
  }

  @override
  String toStringShort() {
    return '[BoundFoldableList@$hashCode, controller=$controller, stateChildren=${statePack.stateChildren}, isExpended=${statePack.initExpended}]';
  }
}