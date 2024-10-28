# Flutter Draggable Dock

This project demonstrates a Flutter-based draggable dock widget inspired by the macOS dock, where users can drag and reorder icons. The dock displays icons for commonly used applications, allowing them to be rearranged with smooth animations.

## Features

- **Draggable Icons**: Icons can be dragged left or right, and they smoothly animate to their new position.
- **Animated Dock**: The icons in the dock smoothly adjust to the new layout upon releasing the drag.
- **Customizable Icons**: Each icon has a unique color, icon, and label, which can be modified in the `DockIcon` model.
- **Flutter Best Practices**: This project follows Effective Dart standards and includes documentation for all classes, fields, and methods.

## Implementation

1. **Dock Widget**: The main `Dock` widget displays the icons in a horizontal row. The dock has rounded corners, a shadow, and a black background, making it resemble a floating dock.

2. **Draggable and Drag Target**: Each icon is wrapped in a `Draggable` and a `DragTarget` widget to allow for dragging and dropping. When an icon is dragged, it temporarily changes appearance to indicate it's in motion.

3. **Smooth Animation**: The icons reposition smoothly when dragged, providing a visual effect similar to the macOS dock. We used `AnimatedContainer` to achieve this smooth animation during the drag.

4. **Documentation**: All classes, fields, and methods are documented as per Effective Dart standards.

## Preview

Below is a GIF preview of the dock in action:

![Simulator Screen Recording](/Users/raza.dev/Desktop/Development/doc_icon_test/out_put.gif)

## Getting Started

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd <repository-name>
2. **Run the App:**
   * Open the project in your preferred IDE (VS Code, Android Studio).
   * Use the command ```flutter run``` to build and run the application on a simulator or physical device.

## Project Structure
   * main.dart: Contains the main Flutter code for the dock widget, including the ```Dock``` and ```DraggableDockIcon``` classes.
   * DockIcon Model: Defines the properties of each dock icon, including ID, icon, color, and name.

## Requirements
   * Flutter SDK: Ensure you have Flutter SDK installed.
   * Device or Simulator: iOS or Android device/emulator to run the application.