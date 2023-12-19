import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foldable_list_ml/foldable_list/function.dart';
import 'package:foldable_list_ml/foldable_list/widgets/bound_foldable_list.dart';
import 'package:foldable_list_ml/foldable_list/widgets/bound_tile_item.dart';

/// [TileManager] stores [RootContents] and provides external operation methods.
class TileManager {
  final RootContents _rootContents;
  /// The RebuildState function of which State you want to display contents,
  /// e.g., TileManager(rebuildState: () {setState(() {});});
  final RebuildState rebuildState;

  TileManager({
    required this.rebuildState,
    RootContents? rootContents,
  }) : _rootContents = rootContents ?? RootContents(contents: []);

  /// Print the all the [_rootContents]
  @visibleForTesting
  debugPrint() {
    print('----------debug print start----------');
    print(_rootContents.collectAllWidgets());
    print('----------debug print end----------');
  }

  /// Get the [_rootContents] widgets for display
  List<Widget> buildList() {
    return _rootContents.contents;
  }

  /// Add [addedWidget] to the [BoundFoldableList] -> [toWhere]
  void add(Widget toWhere, Widget addedWidget) {
    if (!_rootContents.add(toWhere, addedWidget)) {
      if (kDebugMode) {
        print('$toWhere not find');
      }
    }
  }

  /// Add [addedWidget] to root of the [_rootContents]
  void addToRoot(Widget addedWidget) {
    _rootContents.contents.add(addedWidget);
    rebuildState();
  }

  /// Remove the [removedWidget]
  void remove(Widget removedWidget) {
    if (!_rootContents.remove(removedWidget, rebuildState)) {
      if (kDebugMode) {
        print('$removedWidget not find');
      }
    }
  }

  /// Remove all valid widgets that are not [BoundFoldableList] or [BoundTileItem]
  void removeValidWidgets() {
    _rootContents.removeValidWidgets(rebuildState);
  }

  /// Clear all [_rootContents]
  void clear() {
    _rootContents.contents.clear();
    rebuildState();
  }

  @override
  String toString() {
    return '[TileManager@$hashCode]';
  }
}

/// Store Roots Contents and provide the basic operation methods
class RootContents {
  final List<Widget> contents;

  RootContents({
   required this.contents
  });

  FindPack? _findByWidget(Widget toFind, Widget current, Widget parent) {
    if (toFind == current) {
      return FindPack(found: current, parent: parent);
    }
    if (current is BoundFoldableList) {
      for (Widget child in current.statePack.stateChildren) {
        var result = _findByWidget(toFind, child, current);
        if (result != null) return result;
      }
    }
    return null;
  }

  /// Find [toFind] from [contents]
  ///
  /// Return [FindPack] if found. If it in the list of [contents], the [FindPack.parent] is null
  FindPack? findByWidget(Widget toFind) {
    // toFind is in contents
    if (contents.contains(toFind)) {
      return FindPack(found: toFind, parent: null);
    }

    for (Widget item in contents) {
      if (item is BoundFoldableList) {
        for (Widget child in item.statePack.stateChildren) {
          var result = _findByWidget(toFind, child, item);
          if (result != null) return result;
        }
      }
    }
    return null;
  }

  /// Add [addedWidget] to the [BoundFoldableList] -> [toWhere]
  ///
  /// Return true if add successfully
  bool add(Widget toWhere, Widget addedWidget) {
    assert(toWhere is BoundFoldableList);

    var result = findByWidget(toWhere);
    if (result != null) {
      BoundFoldableList f = result.found as BoundFoldableList;
      f.statePack.stateChildren.add(addedWidget);
      f.controller.rebuildState();
      return true;
    }
    return false;
  }

  /// Remove the [removedWidget]
  ///
  /// Return true if remove successfully
  bool remove(Widget removedWidget, RebuildState rebuildState) {
    var result = findByWidget(removedWidget);
    if (result != null) {
      // removedWidget is in rootContents
      if (result.parent == null) {
        contents.remove(removedWidget);
        rebuildState();
      } else {
        // removedWidget is in a BoundFoldableList
        BoundFoldableList p = result.parent as BoundFoldableList;
        p.statePack.stateChildren.remove(removedWidget);
        p.controller.rebuildState();
      }
      return true;
    }
    return false;
  }

  bool _removeValidWidgets(Widget current, Widget parent) {
    if (current is! BoundFoldableList && current is! BoundTileItem) {
      parent as BoundFoldableList;
      parent.statePack.stateChildren.remove(current);
      parent.controller.rebuildState();
      return true;
    }
    if (current is BoundFoldableList) {
      for (int i = 0; i < current.statePack.stateChildren.length; i++) {
        Widget child = current.statePack.stateChildren[i];
        var result = _removeValidWidgets(child, current);
        if (result) i--;
      }
    }
    return false;
  }

  /// Remove all valid widgets that are not [BoundFoldableList] or [BoundTileItem]
  void removeValidWidgets(RebuildState rebuildState) {
    for (int i = 0; i < contents.length; i++) {
      Widget item = contents[i];
      if (item is! BoundFoldableList && item is! BoundTileItem) {
        contents.remove(item);
        i--;
        rebuildState();
      } else if (item is BoundFoldableList) {
        for (Widget child in item.statePack.stateChildren) {
          _removeValidWidgets(child, item);
        }
      }
    }
  }

  void _collectAllWidgets(Widget current, Function addToWidgets) {
    addToWidgets(current);
    if (current is BoundFoldableList) {
      for (Widget child in current.statePack.stateChildren) {
        _collectAllWidgets(child, addToWidgets);
      }
    }
  }

  /// Collect all the widgets of [contents]
  @visibleForTesting
  List<Widget> collectAllWidgets() {
    List<Widget> widgets = [];
    Function addToWidgets = widgets.add;
    for (Widget item in contents) {
      _collectAllWidgets(item, addToWidgets);
    }
    return widgets;
  }

  @override
  String toString() {
    return '[TileManager@$hashCode]';
  }
}

class FindPack {
  final Widget found;
  final Widget? parent;

  FindPack({
    required this.found,
    this.parent
  });
}