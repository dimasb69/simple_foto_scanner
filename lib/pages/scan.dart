import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:document_scanner_flutter/document_scanner_flutter.dart';
import 'package:document_scanner_flutter/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:pdf_ocr/func_const/permmisions.dart';
import 'package:pdf_ocr/main.dart';
import 'package:share_plus/share_plus.dart';

import '../func_const/bottom_nav.dart';
import '../func_const/functions.dart';

late bool docChk;
late bool imgChk;
late var fPath = "";

void main() {
  runApp(const Scan());
}

class Scan extends StatefulWidget {
  const Scan({super.key});

  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  PDFDocument? _scannedDocument;
  File? _scannedDocumentFile;
  File? _scannedImage;

  @override
  void initState() {
    checkPermission(context);
    checkWritePermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff95A2BD),
        ),
        scaffoldBackgroundColor: const Color(0xff4a5875),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Color(0xff95A2BD),
                child: Image(image: AssetImage('assets/logo.png')),
              ),
              SizedBox(width: 12),
              Text('Simple Foto Scanner',
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black45,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/scanner.png"), fit: BoxFit.none)),
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            children: [
              if (_scannedDocument != null || _scannedImage != null) ...[
                if (imgChk)
                  Expanded(
                    child: Image.file(_scannedImage!,
                        height: double.maxFinite,
                        width: double.maxFinite,
                        fit: BoxFit.fill),
                  ),
                if (docChk)
                  Expanded(
                      child: PDFViewer(
                    document: _scannedDocument!,
                  )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.white54,
                          child: Text(
                            fPath,
                            style: const TextStyle(
                                fontSize: 8, color: Colors.black),
                          ),
                        ),
                        screns
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    iconSize: 20,
                                    icon: const Icon(Icons.file_open),
                                    color: Colors.white,
                                    focusColor: Colors.yellow,
                                    onPressed: () async {
                                      late OpenResult openResult;
                                      final pathFile = fPath;
                                      final path = pathFile;
                                      bool permissionReady =
                                          await checkPermission(context);
                                      if (permissionReady) {
                                        final result =
                                            await OpenFile.open(path);
                                        result;
                                        OpenResult openResult = result;

                                        if (openResult.type ==
                                            ResultType.noAppToOpen) {
                                          screns = false;
                                          setState(() {
                                            screns;
                                          });
                                          await sleepTime(5).then((value) {
                                            screns = true;
                                            setState(() {
                                              screns;
                                            });
                                          });
                                          print(openResult.type);
                                        }
                                        ;
                                      }
                                      setState(() {});
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  IconButton(
                                    iconSize: 20,
                                    icon: const Icon(Icons.share),
                                    color: Colors.white,
                                    onPressed: () async {
                                      var openResult = 'Unknown';
                                      final pathFile = fPath;
                                      print('path: $pathFile');
                                      final path = pathFile;
                                      bool permissionReady =
                                          await checkPermission(context);
                                      if (permissionReady) {
                                        List<String> file = [path];
                                        final result =
                                            await Share.shareFiles(file);
                                      }
                                    },
                                  ),
                                ],
                              )
                            : Center(
                              child: Container(
                                color: Colors.black87,
                                child: const Text(
                                  textAlign: TextAlign.center,
                                    'No tienes aplicacion de PDF instalada, debes instala una',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.yellow),
                                  ),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Builder(builder: (context) {
                        return ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color(0x96cdd2dc))),
                            onPressed: () => openPdfScanner(context),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircleAvatar(
                                    child: Image(
                                        image: AssetImage('assets/pdf.png'),
                                        color: Color(0xD8131313)),
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text(
                                  "Scan to PDF",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                )
                              ],
                            ));
                      }),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: Builder(builder: (context) {
                        return ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color(0x96cdd2dc))),
                            onPressed: () => openImageScanner(context),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircleAvatar(
                                    child: Image(
                                        image: AssetImage('assets/jpg.png'),
                                        color: Color(0xD0333232)),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Scan to Image",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                )
                              ],
                            ));
                      }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: bottomDevName(),
      ),
    );
  }

  openPdfScanner(BuildContext context) async {
    var doc = await DocumentScannerFlutter.launchForPdf(
      context,
      labelsConfig: {
        ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next Steps",
        ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_SINGLE: "Only 1 Page",
        ScannerLabelsConfig.PDF_GALLERY_FILLED_TITLE_MULTIPLE:
            "Only {PAGES_COUNT} Page"
      },
      //source: ScannerFileSource.CAMERA
    );
    if (doc != null) {
      var dateFormat = getDateNow();
      _scannedDocument = null;
      setState(() {});
      await Future.delayed(const Duration(milliseconds: 100));
      _scannedDocumentFile = doc;
      late var doc2;
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final _sdk = androidInfo.version.sdkInt;
      if (_sdk! >= 30) {
        doc2 = await doc
            .copy('/storage/emulated/0/Documents/ScanPdf_$dateFormat.pdf');
      } else {
        doc2 = await doc
            .copy('/storage/emulated/0/Download/ScanPdf_$dateFormat.pdf');
      }

      _scannedDocumentFile = doc2;
      _scannedDocument = await PDFDocument.fromFile(doc2);

      setState(() {
        docChk = true;
        imgChk = false;
        fPath = _scannedDocumentFile!.path;
      });
    }
  }

  openImageScanner(BuildContext context) async {
    var image = await DocumentScannerFlutter.launch(context,
        //source: ScannerFileSource.CAMERA,
        labelsConfig: {
          ScannerLabelsConfig.ANDROID_NEXT_BUTTON_LABEL: "Next Step",
          ScannerLabelsConfig.ANDROID_OK_LABEL: "OK"
        });
    if (image != null) {
      _scannedImage = image;
      setState(() {
        imgChk = true;
        docChk = false;
        fPath = _scannedImage!.path;
      });
    }
  }
}
