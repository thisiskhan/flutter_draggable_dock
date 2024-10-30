import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

/// The main application widget, setting up the MaterialApp and displaying the [Dock] widget.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Dock(),
        ),
      ),
    );
  }
}

/// A model class representing an icon in the dock.
///
/// Each [DockIcon] contains a unique [id], a [name] for identification,
/// an [iconData] for display, and a [color] to customize its appearance.
class DockIcon {
  /// Unique identifier for the icon.
  final String id;

  /// Name or label of the icon (used for identification purposes).
  final String name;

  /// The [IconData] to represent the icon visually.
  final IconData iconData;

  /// The color of the icon.
  final Color color;

  /// Creates a [DockIcon] with the given [id], [name], [iconData], and [color].
  DockIcon({
    required this.id,
    required this.iconData,
    required this.name,
    required this.color,
  });
}

/// A widget that represents a dock with draggable icons, similar to a macOS dock.
class Dock extends StatefulWidget {
  @override
  _DockState createState() => _DockState();
}

class _DockState extends State<Dock> {
  /// List of [DockIcon] objects to display in the dock.
  List<DockIcon> icons = [
    DockIcon(
        id: '1',
        iconData: Icons.home,
        name: "Home",
        color: Colors.purpleAccent),
    DockIcon(
        id: '2',
        iconData: Icons.search,
        name: "Search",
        color: Colors.pinkAccent),
    DockIcon(
        id: '3',
        iconData: Icons.settings,
        name: "Settings",
        color: Colors.greenAccent),
    DockIcon(
        id: '4',
        iconData: Icons.notifications,
        name: "Notifications",
        color: Colors.redAccent),
  ];

  DockIcon? draggedIcon;
  int? originalIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 10),
          ),
        ],
      ),
      width: icons.length * 80.0 + 40.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: icons.map((icon) {
          return DraggableDockIcon(
            key: ValueKey(icon.id),
            dockIcon: icon,
            onAccept: (droppedIcon) {
              setState(() {
                final oldIndex = icons.indexOf(droppedIcon);
                final newIndex = icons.indexOf(icon);
                icons.removeAt(oldIndex);
                icons.insert(newIndex, droppedIcon);
              });
            },
            onDragStarted: () {
              setState(() {
                draggedIcon = icon;
                originalIndex = icons.indexOf(icon);
                icons.removeAt(originalIndex!);
              });
            },
            onDragEnd: () {
              setState(() {
                if (draggedIcon != null && !icons.contains(draggedIcon)) {
                  icons.insert(originalIndex!, draggedIcon!);
                }
                draggedIcon = null;
                originalIndex = null;
              });
            },
          );
        }).toList(),
      ),
    );
  }
}

/// A widget representing a draggable and sortable icon in the dock.
class DraggableDockIcon extends StatelessWidget {
  final DockIcon dockIcon;
  final Function(DockIcon) onAccept;
  final VoidCallback onDragStarted;
  final VoidCallback onDragEnd;

  const DraggableDockIcon({
    Key? key,
    required this.dockIcon,
    required this.onAccept,
    required this.onDragStarted,
    required this.onDragEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: DragTarget<DockIcon>(
        onWillAccept: (data) => data != null && data.id != dockIcon.id,
        onAccept: (data) => onAccept(data),
        builder: (context, candidateData, rejectedData) {
          return Draggable<DockIcon>(
            onDragStarted: onDragStarted,
            onDraggableCanceled: (_, __) => onDragEnd(),
            onDragEnd: (_) => onDragEnd(),
            data: dockIcon,
            feedback: Material(
              color: Colors.transparent,
              child: Transform.scale(
                scale: 1.2,
                child: Icon(
                  dockIcon.iconData,
                  color: dockIcon.color.withOpacity(0.8),
                  size: 60,
                ),
              ),
            ),
            childWhenDragging: Opacity(
              opacity: 0.4,
              child: Icon(
                dockIcon.iconData,
                color: Colors.grey,
                size: 40,
              ),
            ),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOutBack,
              padding: EdgeInsets.all(8.0),
              child: Icon(
                dockIcon.iconData,
                color: dockIcon.color,
                size: 40,
              ),
            ),
          );
        },
      ),
    );
  }
}
