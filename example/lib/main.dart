import 'package:flutter/material.dart';
import 'package:foldable_list_ml/foldable_list/context_controller.dart';
import 'package:foldable_list_ml/foldable_list/tile_manager.dart';
import 'package:foldable_list_ml/foldable_list/widgets/bound_foldable_list.dart';
import 'package:foldable_list_ml/foldable_list/widgets/bound_tile_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'FoldableTile Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TileManager tileManager;

  @override
  void initState() {
    super.initState();
    /// Init tileManager with setState method in this state,
    /// cannot give setState directly, e.g., TileManager(widgetSetState: setState);
    tileManager = TileManager(rebuildState: () {setState(() {});});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          actions: [
            IconButton(
                onPressed: () {
                  /// Add a Text to tileManager's rootContents,
                  /// it automatically packed to a BoundTileItem,
                  /// but this is not recommended,
                  /// because you have no controller to operate 'add' 'remove' from tileManager
                  tileManager.addToRoot(const Text("data"));
                },
                enableFeedback: false,
                icon: const Icon(Icons.add)
            ),
            IconButton(
                onPressed: () {
                  // Example: add BoundFoldableList to rootContents when click button
                  createFoldableListAndToRoot(tileManager);
                },
                enableFeedback: false,
                icon: const Icon(
                    Icons.add_circle_outline
                )
            ),
            IconButton(
              // Rebuild current widget state
                onPressed: () {
                  setState(() {});
                },
                enableFeedback: false,
                icon: const Icon(Icons.refresh)
            ),
            // Clear contents
            IconButton(
                onPressed: () {
                  tileManager.clear();
                },
                enableFeedback: false,
                icon: const Icon(Icons.cleaning_services)
            ),
            // Remove all valid widgets
            IconButton(
                onPressed: () {
                  tileManager.removeValidWidgets();
                },
                enableFeedback: false,
                icon: const Icon(
                  Icons.layers_clear_outlined
                )
            ),
            // Use for print all the contents
            IconButton(
                onPressed: () {
                  tileManager.debugPrint();
                },
                enableFeedback: false,
                icon: const Icon(Icons.search)
            )
          ],
        ),
        body: Column(
          children: tileManager.buildList(),
        )
    );
  }

  // Add BoundFoldableList to rootContents
  void createFoldableListAndToRoot(TileManager boundManager) {
    // Create foldable list
    BoundFoldableList foldableList_1 = createFoldableList_1(tileManager);

    tileManager.addToRoot(
        foldableList_1
    );
  }

  /// Create boundFoldableList_1
  BoundFoldableList createFoldableList_1(TileManager boundManager) {
    ContextController controller = ContextController(boundManager: boundManager);
    return BoundFoldableList(
      // It is necessary to give a unique key for constructor
      key: UniqueKey(),
      controller: controller,
      title: const Text("new bound foldable list 1"),
      leading: IconButton(
          onPressed: () {
            controller.add(
              // Example: add BoundFoldableList to current foldable list when click button
                createFoldableTile_2(boundManager)
            );
          },
          enableFeedback: false,
          icon: const Icon(Icons.add)
      ),
      trailing: IconButton(
        onPressed: () {
          controller.remove();
        },
        enableFeedback: false,
        icon: const Icon(Icons.remove),
      ),
    );
  }

  /// Create boundFoldableTile_2
  BoundFoldableList createFoldableTile_2(TileManager boundManager) {
    ContextController controller = ContextController(boundManager: boundManager);
    return BoundFoldableList(
      // Give a unique key
      key: UniqueKey(),
      controller: controller,
      title: const Text("new bound foldable list 2"),
      leading: IconButton(
          onPressed: () {
            controller.add(
              // Example: add boundTileItem to current foldable list when click button
              createBoundTileItem(boundManager),
            );
          },
          enableFeedback: false,
          icon: const Icon(Icons.add)
      ),
      trailing: IconButton(
        onPressed: () {
          controller.remove();
        },
        enableFeedback: false,
        icon: const Icon(Icons.remove),
      ),
    );
  }

  /// Create new bound tile item
  BoundTileItem createBoundTileItem(TileManager boundManager) {
    ContextController controller = ContextController(boundManager: boundManager);
    return BoundTileItem(
      controller: controller,
      title: const Text('new bound tile item'),
      trailing: IconButton(
        onPressed: () {
          controller.remove();
        },
        enableFeedback: false,
        icon: const Icon(Icons.remove),
      ),
    );
  }
}
