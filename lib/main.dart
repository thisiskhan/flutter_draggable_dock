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
///
/// The dock displays a row of [DockIcon] widgets, which can be reordered by dragging.
class Dock extends StatefulWidget {
  @override
  _DockState createState() => _DockState();
}

class _DockState extends State<Dock> {
  /// List of [DockIcon] objects to display in the dock.
  List<DockIcon> icons = [
    DockIcon(
        id: '1', iconData: Icons.home, name: "Home", color: Colors.purpleAccent),
    DockIcon(
        id: '2', iconData: Icons.search, name: "Search", color: Colors.pinkAccent),
    DockIcon(
        id: '3', iconData: Icons.settings, name: "Settings", color: Colors.greenAccent),
    DockIcon(
        id: '4', iconData: Icons.notifications, name: "Notifications", color: Colors.redAccent),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
                icons.remove(droppedIcon);
                icons.insert(newIndex, droppedIcon);
              });
            },
          );
        }).toList(),
      ),
    );
  }
}

/// A widget representing a draggable and sortable icon in the dock.
///
/// The [DraggableDockIcon] widget enables each icon to be dragged and reordered
/// within the dock. The icon's appearance changes when it is being dragged.
class DraggableDockIcon extends StatelessWidget {
  /// The [DockIcon] data associated with this widget.
  final DockIcon dockIcon;

  /// A callback function that accepts a [DockIcon] to handle icon reordering.
  final Function(DockIcon) onAccept;

  /// Creates a [DraggableDockIcon] with the given [dockIcon] data and [onAccept] callback.
  const DraggableDockIcon({
    Key? key,
    required this.dockIcon,
    required this.onAccept,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: DragTarget<DockIcon>(
        // Determines if an icon can be dropped here based on the ID.
        onWillAccept: (data) => data != null && data.id != dockIcon.id,
        // Accepts the dragged icon and calls [onAccept] to update its position.
        onAccept: (data) => onAccept(data),
        builder: (context, candidateData, rejectedData) {
          return Draggable<DockIcon>(
            data: dockIcon,
            feedback: Material(
              color: Colors.transparent,
              child: Icon(
                dockIcon.iconData,
                color: dockIcon.color.withOpacity(0.8),
                size: 60,
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
              curve: Curves.easeInOut,
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
