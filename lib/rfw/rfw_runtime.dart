import 'package:rfw/formats.dart';

import 'package:rfw/rfw.dart';

class RfwRuntime {
  RfwRuntime() {
    _loadLibraries();
  }

  final Runtime runtime = Runtime();
  final DynamicContent data = DynamicContent();

  static const LibraryName _libraryName = LibraryName(['demo']);

  FullyQualifiedWidgetName get cardWidget =>
      FullyQualifiedWidgetName(_libraryName, 'card');

  FullyQualifiedWidgetName get rootWidget =>
      FullyQualifiedWidgetName(_libraryName, 'root');

  void _loadLibraries() {
    runtime.update(const LibraryName(['core']), createCoreWidgets());
    try {
      final lib = parseLibraryFile(_rfwLibrary);
      runtime.update(_libraryName, lib);
      print('RFW Library loaded successfully');
    } catch (e) {
      print('RFW Parse Error: $e');
      print('Stack trace: $e');
    }
  }

  /*void _loadData() {
    final initialData = <String, Object?>{
      'title': 'Test Title',
      'content': 'Test Content',
      'icon': '⚙️',
      'subtitle': '',
    };
    try {
      data.update('data', DynamicMap.from(initialData));
      print('RFW Initial data loaded successfully with values: $initialData');
    } catch (e) {
      print('RFW Data Load Error: $e');
      print('Stack trace: $e');
    }
  }*/

  void updateData(Map<String, Object?> values) {
    try {
      data.update('data', DynamicMap.from(values));
      print('RFW Data updated successfully with values: $values');
    } catch (e) {
      print('RFW Data Update Error: $e');
      print('Stack trace: $e');
    }
  }

  static const String _rfwLibrary = r'''
import core;

widget card = Container(
  color: "#FFF5F5F5",
  padding: [8.0],
  child: Column(
    children: [
      Text(text: data.title, textScaleFactor: 1.2),
      SizedBox(height: 8.0),
      Text(text: data.icon, textScaleFactor: 2.0),
      SizedBox(height: 8.0),
      Text(text: data.content),
    ],
  ),
);


''';
}
