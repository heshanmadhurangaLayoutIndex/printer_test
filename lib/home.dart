import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<UsbDevice> connectedDevices = [];
  // void testReceipt(printer) {
  //   printer.text(
  //       'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
  //   printer.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
  //       styles: const PosStyles(codeTable: 'CP1252'));
  //   printer.text('Special 2: blåbærgrød',
  //       styles: const PosStyles(codeTable: 'CP1252'));
  //
  //   printer.text('Bold text', styles: const PosStyles(bold: true));
  //   printer.text('Reverse text', styles: const PosStyles(reverse: true));
  //   printer.text('Underlined text',
  //       styles: const PosStyles(underline: true), linesAfter: 1);
  //   printer.text('Align left', styles: const PosStyles(align: PosAlign.left));
  //   printer.text('Align center',
  //       styles: const PosStyles(align: PosAlign.center));
  //   printer.text('Align right',
  //       styles: const PosStyles(align: PosAlign.right), linesAfter: 1);
  //
  //   printer.text('Text size 200%',
  //       styles: const PosStyles(
  //         height: PosTextSize.size2,
  //         width: PosTextSize.size2,
  //       ));
  //
  //   printer.feed(2);
  //   printer.cut();
  // }
  //
  // void printReceipt() async {
  //   const PaperSize paper = PaperSize.mm80;
  //   final profile = await CapabilityProfile.load();
  //   final printer = NetworkPrinter(paper, profile);
  //
  //   final PosPrintResult res =
  //   await printer.connect('192.168.0.123', port: 9100);
  //
  //   if (res == PosPrintResult.success) {
  //     testReceipt(printer);
  //     printer.disconnect();
  //   }
  //
  //   print('Print result: ${res.msg}');
  // }

  //
  // Future<void> getDeviceList() async {
  //   await QuickUsb.init();
  //   var deviceList = await QuickUsb.getDeviceList();
  //   debugPrint("Device list $deviceList");
  //   setState(() {
  //     connectedDevices = deviceList;
  //   });
  //   var descriptions = await QuickUsb.getDevicesWithDescription();
  //   var deviceListss = descriptions.map((e) => e.device).toList();
  //   print('descriptions $descriptions');
  //   await QuickUsb.exit();
  // }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = pw.Font.ttf(await rootBundle.load('asset/fonts/OpenSans.ttf'));


    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.SizedBox(
                width: double.infinity,
                child: pw.FittedBox(
                  child: pw.Text(title, style: pw.TextStyle(font: font)),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Flexible(child: pw.FlutterLogo())
            ],
          );
        },
      ),
    );

    return pdf.save();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Column(
      children: [
        Row(
          children: [
            // ElevatedButton(
            //   onPressed: printReceipt,
            //   child: const Text('Print receipt'),
            // ),
            // ElevatedButton(
            //   onPressed: getDeviceList,
            //   child: const Text('Get device list'),
            // ),
          ],
        ),
        Expanded(child: PdfPreview(build: (format) => _generatePdf(format, 'Hello World'))),
      ],
    ));
  }
}
