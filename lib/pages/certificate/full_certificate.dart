import 'dart:html';

import 'package:arcon/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:screenshot/screenshot.dart';

import 'package:pdf/widgets.dart' as pw;

class FullCertificate {
  final ScreenshotController screenshotController;
  final String userName;
  final String userEmail;
  const FullCertificate({Key? key, required this.screenshotController, required this.userName, required this.userEmail});

  Future<void> downloadCertificate(pw.Document pdf) async {
    final blob = await pdf.save();
    final blobUrl = Uri.dataFromBytes(blob, mimeType: 'application/pdf');
    final anchor = AnchorElement(href: blobUrl.toString())
      ..target = 'webpdfsave'
      ..download = 'certificate.pdf';
    anchor.click();
  }

  Future<pw.Document> generateCertificate() async {
    final pdf = pw.Document();

    final image = pw.MemoryImage((await rootBundle.load('assets/images/certificate.png')).buffer.asUint8List());

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.AspectRatio(
            aspectRatio: 1.15,
            child: pw.LayoutBuilder(
              builder: (context, constraints){
                return pw.Stack(
                    children: [
                      pw.Image(
                        image,
                        fit: pw.BoxFit.cover,
                        width: constraints?.maxWidth,
                        height: constraints?.maxHeight,
                      ),

                      pw.Container(
                        height: constraints?.maxHeight,
                        padding: pw.EdgeInsets.symmetric(
                            horizontal: (constraints?.maxWidth ?? 0) * 0.075
                        ),
                        child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [

                            pw.Expanded(flex: 15, child: pw.SizedBox()),

                            pw.SizedBox(
                              width: constraints?.maxWidth,
                              child: pw.Center(
                                child: pw.Text(
                                    userName.toUpperCase(),
                                    style: pw.TextStyle(
                                      fontSize: App.screenHeight * 0.135 * 0.12,
                                      fontWeight: pw.FontWeight.normal,
                                    )
                                ),
                              )
                            ),

                            pw.Expanded(flex: 17, child: pw.SizedBox()),

                          ],
                        ),
                      ),
                    ]
                );
              }
            )
          );


        },
      ),
    );

    return pdf;
  }

  Future<void> download() async {
    await downloadCertificate(await generateCertificate());
  }
}
