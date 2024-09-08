import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class History {
  final String history;

  History({required this.history});
  Widget build() {
    return HtmlWidget(
      // the first parameter (`html`) is required
      history,

      // all other parameters are optional, a few notable params:

      // specify custom styling for an element
      // see supported inline styling below
      customStylesBuilder: (element) {
        if (element.classes.contains('foo')) {
          return {'color': 'red'};
        }

        return null;
      },

      // this callback will be triggered when user taps a link
      onTapUrl: (url) => true,

      // select the render mode for HTML body
      // by default, a simple `Column` is rendered
      // consider using `ListView` or `SliverList` for better performance
      renderMode: RenderMode.column,

      // set the default styling for text
      textStyle: const TextStyle(fontSize: 14),
    );
  }
}
