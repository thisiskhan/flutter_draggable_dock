# Flutter Draggable Dock

This project demonstrates a Flutter-based draggable dock widget inspired by the macOS dock, where users can drag and reorder icons. The dock displays icons for commonly used applications, allowing them to be rearranged with smooth animations and a more interactive user experience.

## Features

- **Draggable Icons**: Icons can be dragged left or right within the dock, smoothly animating to their new positions.
- **Animated Dock Expansion**: The dock expands and contracts as icons are dragged out and in, adjusting its size dynamically.
- **Return Animation**: Icons dragged out of bounds smoothly return to their original position, maintaining the layout.
- **Customizable Icons**: Each icon has a unique color, icon, and label, customizable in the `DockIcon` model.
- **Smooth Scaling and Bounce Effect**: Icons scale up during drag, providing a visual cue, and a subtle bounce animation is triggered upon drop.
- **Effective Dart Standards**: This project follows Effective Dart standards with full documentation for classes, fields, and methods.

## Implementation

1. **Dock Widget**: The main `Dock` widget displays the icons in a horizontal row with a floating effect, thanks to rounded corners, shadows, and a black background.

2. **Draggable and Drag Target**: Each icon is wrapped in a `Draggable` and a `DragTarget` widget for drag-and-drop functionality. Icons temporarily change appearance while being dragged.

3. **Smooth Scaling and Bounce Animation**: Using `Transform.scale` for drag feedback and `AnimatedContainer` with `Curves.easeInOutBack`, we achieve smooth scaling up and a subtle bounce effect on drop, enhancing the dock's interactivity.

4. **Dock Size Adjustment**: The dock resizes dynamically to fit the icon count, contracting when icons are dragged out and expanding when they are dragged back in.

5. **Documentation**: The project includes full documentation as per Effective Dart standards.

## Preview

Here’s a GIF preview of the dock in action:

![Simulator Screen Recording](https://raw.githubusercontent.com/thisiskhan/flutter_draggable_dock/refs/heads/main/out_put.gif)

## Getting Started

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/thisiskhan/flutter_draggable_dock.git
   cd flutter_draggable_dock
   ```
2. **Run the App:**
   * Open the project in your preferred IDE (VS Code, Android Studio).
   * Use the command ```flutter run``` to build and run the application on a simulator or physical device.

## Project Structure
   * main.dart: Contains the main Flutter code for the dock widget, including the ```Dock``` and ```DraggableDockIcon``` classes.
   * DockIcon Model: Defines the properties of each dock icon, including ID, icon, color, and name.

## Requirements
   * Flutter SDK: Ensure you have Flutter SDK installed.
   * Device or Simulator: iOS or Android device/emulator to run the application.