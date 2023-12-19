import 'package:flutter/material.dart';
import 'package:foldable_list_ml/foldable_list/function.dart';
import 'package:foldable_list_ml/foldable_list/tile_manager.dart';
import 'package:foldable_list_ml/foldable_list/widgets/bound_foldable_list.dart';
import 'package:foldable_list_ml/foldable_list/widgets/bound_tile_item.dart';

/// Context controller is used to establish association with [TileManager]
/// for a boundWidget and provides the operations to use
class ContextController {
  final TileManager boundManager;
  late Widget boundWidget;
  RebuildState? _rebuildStateFunction;

  ContextController({
    required this.boundManager
  });

  set rebuildStateFunction(RebuildState value) {
    _rebuildStateFunction = value;
  }

  /// Call rebuildState method [boundWidget],
  /// [boundWidget] must be [BoundFoldableList]
  void rebuildState() {
    assert(boundWidget is BoundFoldableList);
    _rebuildStateFunction!();
  }

  /// Bind [widget] to controller when a [BoundFoldableList] or [BoundTileItem] construct completely
  void bindWidget(Widget widget) {
    boundWidget = widget;
  }

  /// Add [addedWidget] to current [boundWidget],
  /// [boundWidget] must be [BoundFoldableList]
  void add(Widget addedWidget) {
    boundManager.add(boundWidget, addedWidget);
  }

  /// Remove current [boundWidget]
  void remove() {
    boundManager.remove(boundWidget);
  }

  @override
  String toString() {
    return '[ContextController@$hashCode, boundWidget=@${boundWidget.hashCode}, boundManager=$boundManager]';
  }
}