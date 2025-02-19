import 'dart:io';

import 'package:htmltopdfwidgets/htmltopdfwidgets.dart';

void main() {
  createDocument();
}

const htmlText = '''  <h1>Heading Example</h1>
  <p>This is a paragraph.</p>
  <img src="image.jpg" alt="Example Image" />
  <blockquote>This is a quote.</blockquote>
  <ul>
    <li>First item</li>
    <li>Second item</li>
    <li>Third item</li>
  </ul>"''';

createDocument() async {
  var filePath = 'example.pdf';
  var file = File(filePath);
  final newpdf = Document();
  List<Widget> widgets = await HTMLToPdf().convert(htmlText);
  newpdf.addPage(MultiPage(
      maxPages: 200,
      build: (context) {
        return widgets;
      }));
  await file.writeAsBytes(await newpdf.save());
}
