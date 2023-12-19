import 'package:flutter/material.dart';
import 'package:foldable_list_ml/foldable_list/function.dart';
import 'package:foldable_list_ml/foldable_list/widgets/foldable_list.dart';

/// Store the properties that are used for [FoldableListState]
class StatePack {
  /// Expended state of [FoldableList]
  bool initExpended;
  /// [FoldableListState] will use it to build
  final List<Widget> stateChildren;
  /// The call back of the rebuild state function of [FoldableListState]
  final FunctionCallBack<RebuildState>? rebuildStateFunctionCallBack;

  StatePack({
    this.initExpended = true,
    List<Widget>? stateChildren,
    this.rebuildStateFunctionCallBack
  }) : stateChildren = stateChildren ?? [];
}