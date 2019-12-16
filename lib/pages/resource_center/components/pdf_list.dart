import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_library/models/pdf/built_pdf_list.dart';
import 'package:save_the_library/network/api_service.dart';
import 'package:save_the_library/pages/developers/assets.dart';
import 'package:save_the_library/widgets/no_connection_handler.dart';
import 'package:save_the_library/widgets/smart_list.dart';

import 'package:flutter/src/gestures/tap.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfList extends StatelessWidget {
  const PdfList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoConnectionHandler(
      builder: (context) => SmartList<BuiltPdfList>(
        onGet: (page) => Provider.of<ApiService>(context).getPdfs(page),
        listGetter: (body) => body.data.toList(),
        itemBuilder: (context, item) {
          BuiltPdf pdf = item as BuiltPdf;
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ListTile(
                  title: Text(
                    pdf.pdfTitle,
                    style: TextStyle(color: Colors.black38, fontSize: 17.0),
                  ),
                  leading: SizedBox(
                      height: 50.0,
                      width: 50.0, // fixed width and height
                      child: Image.network(
                          'https://savethelibrarymyanmar.org/images/${pdf.image}')),
                  subtitle:
                      Text(pdf.pdfSource, style: TextStyle(color: Colors.red)),
                ),
                ButtonTheme(
                  child: ButtonBar(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      RaisedButton(
                        child: RichText(
                          text: LinkTextSpan(
                              url:
                                  // 'http://docs.google.com/viewer?url=http://www.pdf995.com/samples/pdf.pdf',
                                  '${pdf.downloadLink}',
                              text: 'Download PDF', ),
                        ),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, pdf.downloadLink);
                        },
                      ),
                      RaisedButton(
                        child: const Text('Favourtie',
                            style: TextStyle(color: Colors.amberAccent)),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LinkTextSpan extends TextSpan {
  LinkTextSpan({TextStyle style, String url, String text})
      : super(
      style: style,
      text: text ?? url,
      recognizer: new TapGestureRecognizer()
        ..onTap = () {
          launch(url);
        });
}
//
