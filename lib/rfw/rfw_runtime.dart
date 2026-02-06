import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';

class RfwRuntime {
  RfwRuntime() {
    _loadLibraries();
    _loadData();
  }

  final Runtime runtime = Runtime();
  final DynamicContent data = DynamicContent();

  static const LibraryName _libraryName = LibraryName(['demo']);

  FullyQualifiedWidgetName get rootWidget =>
      FullyQualifiedWidgetName(_libraryName, 'root');

  void _loadLibraries() {
    runtime.update(const LibraryName(['core']), createCoreWidgets());
    runtime.update(_libraryName, parseLibraryFile(_rfwLibrary));
  }

  void _loadData() {
    data.update(
      'demo',
      DynamicMap.from(<String, Object?>{
        'title': 'Remote Flutter Widgets',
        'subtitle': 'Το UI αυτό έρχεται από μια RFW βιβλιοθήκη μέσα στο app.',
      }),
    );
  }

  static const String _rfwLibrary = r'''
import core;
widget root = Padding(
  padding: [16],
  child: Column(
    children: [
      Text(text: data.title),
      SizedBox(height: 8),
      Text(text: data.subtitle),
    ],
  ),
);
''';
}
