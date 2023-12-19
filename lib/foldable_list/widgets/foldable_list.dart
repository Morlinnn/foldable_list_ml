import 'package:flutter/material.dart';
import 'package:foldable_list_ml/foldable_list/state_pack.dart';
import 'package:foldable_list_ml/foldable_list/widgets/tile_item.dart';

/// Basic foldable list with the main tile widget and widget children,
/// it can be folded and expended by clicking the tail button
class FoldableList extends StatefulWidget {
  /// FoldableList group
  final StatePack statePack;
  final Widget title;

  /// TileItem group
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsetsGeometry? titleMargin;

  /// InkWell group
  final GestureTapCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCallback? onTapCancel;
  final GestureTapCallback? onDoubleTap;
  final GestureLongPressCallback? onLongPress;
  final GestureTapCallback? onSecondaryTap;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCallback? onSecondaryTapCancel;
  final ValueChanged<bool>? onHighlightChanged;
  final ValueChanged<bool>? onHover;
  final MouseCursor? mouseCursor;
  final double? radius;
  final BorderRadius? borderRadius;
  final ShapeBorder? customBorder;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final MaterialStateProperty<Color?>? overlayColor;
  final Color? splashColor;
  final InteractiveInkFeatureFactory? splashFactory;
  final bool enableFeedback;
  final bool excludeFromSemantics;
  final ValueChanged<bool>? onFocusChange;
  final bool autofocus;
  final FocusNode? focusNode;
  final bool canRequestFocus;
  final MaterialStatesController? statesController;

  /// Container group
  final double? height;
  final double? width;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Clip clipBehavior;

  FoldableList({
    super.key,
    required this.statePack,
    required this.title,
    this.leading,
    this.trailing,
    this.titleMargin,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTap,
    this.onSecondaryTapUp,
    this.onSecondaryTapDown,
    this.onSecondaryTapCancel,
    this.onHighlightChanged,
    this.onHover,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.overlayColor,
    this.splashColor,
    this.splashFactory,
    this.radius,
    this.borderRadius,
    this.customBorder,
    this.enableFeedback = true,
    this.excludeFromSemantics = false,
    this.focusNode,
    this.canRequestFocus = true,
    this.onFocusChange,
    this.autofocus = false,
    this.statesController,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
  });

  @override
  State<StatefulWidget> createState() {
    return FoldableListState();
  }

  @override
  String toStringShort() {
    return '[FoldableList@$hashCode, stateChildren=${statePack.stateChildren}, isExpended=${statePack.initExpended}]';
  }
}

class FoldableListState extends State<FoldableList> {
  @override
  void initState() {
    super.initState();
    if (widget.statePack.rebuildStateFunctionCallBack != null) {
      widget.statePack.rebuildStateFunctionCallBack!(() {setState(() {});});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TileItem(
          autofocus: widget.autofocus,
          borderRadius: widget.borderRadius,
          canRequestFocus: widget.canRequestFocus,
          customBorder: widget.customBorder,
          enableFeedback: widget.enableFeedback,
          excludeFromSemantics: widget.enableFeedback,
          focusColor: widget.focusColor,
          focusNode: widget.focusNode,
          highlightColor: widget.highlightColor,
          hoverColor: widget.hoverColor,
          mouseCursor: widget.mouseCursor,
          onFocusChange: widget.onFocusChange,
          onTap: widget.onTap,
          onDoubleTap: widget.onDoubleTap,
          onLongPress: widget.onLongPress,
          onSecondaryTap: widget.onSecondaryTap,
          onSecondaryTapCancel: widget.onSecondaryTapCancel,
          onSecondaryTapDown: widget.onSecondaryTapDown,
          onSecondaryTapUp: widget.onSecondaryTapUp,
          onHighlightChanged: widget.onHighlightChanged,
          onHover: widget.onHover,
          onTapCancel: widget.onTapCancel,
          onTapDown: widget.onTapDown,
          onTapUp: widget.onTapUp,
          overlayColor: widget.overlayColor,
          radius: widget.radius,
          splashColor: widget.splashColor,
          splashFactory: widget.splashFactory,
          statesController: widget.statesController,
          height: widget.height,
          width: widget.width,
          alignment: widget.alignment,
          color: widget.color,
          decoration: widget.decoration,
          foregroundDecoration: widget.foregroundDecoration,
          margin: widget.margin,
          padding: widget.padding,
          transform: widget.transform,
          transformAlignment: widget.transformAlignment,
          clipBehavior: widget.clipBehavior,
          constraints: widget.constraints,
          leading: widget.leading,
          title: widget.title,
          trailing: Row(
            children: [
              if (widget.trailing != null) widget.trailing!,
              IconButton(
                  onPressed: () {
                    updateExpend();
                  },
                  icon: Icon(
                    widget.statePack.initExpended? Icons.expand_less : Icons.expand_more,
                  )
              ),
            ],
          ),
          titleMargin: widget.titleMargin,
        ),
        Column(
          children: widget.statePack.initExpended? widget.statePack.stateChildren : [],
        ),
      ],
    );
  }

  void updateExpend() {
    setState(() {
      widget.statePack.initExpended = !widget.statePack.initExpended;
    });
  }
}