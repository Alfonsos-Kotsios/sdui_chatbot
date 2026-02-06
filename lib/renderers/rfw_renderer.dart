import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';

class RfwRenderer extends StatefulWidget {
  final String library;
  final String data;

  const RfwRenderer({super.key, required this.library, required this.data});

  @override
  State<RfwRenderer> createState() => _RfwRendererState();
}

class _RfwRendererState extends State<RfwRenderer> {
  final Runtime _runtime = Runtime();
  final DynamicContent _dynamicContent = DynamicContent();

  @override
  void initState() {
    super.initState();
    _runtime.update(
      const LibraryName(['core', 'widgets']),
      createCoreWidgets(),
    );
    _runtime.update(
      const LibraryName(['core', 'material']),
      createMaterialWidgets(),
    );
    _loadRemoteWidget();
  }

  @override
  void didUpdateWidget(covariant RfwRenderer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.library != widget.library || oldWidget.data != widget.data) {
      _loadRemoteWidget();
    }
  }

  void _loadRemoteWidget() {
    _runtime.update(
      const LibraryName(['remote']),
      parseLibraryFile(widget.library),
    );
    _dynamicContent.update('root', parseDataFile(widget.data));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: RemoteWidget(
        runtime: _runtime,
        data: _dynamicContent,
        widget: const FullyQualifiedWidgetName(LibraryName(['remote']), 'root'),
      ),
    );
  }
}
