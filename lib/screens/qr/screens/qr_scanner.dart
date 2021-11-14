import 'dart:io';

import 'package:cocktail_app/_core/routes/routes.dart';
import 'package:cocktail_app/_shared/utility_methods/utility_methods.dart';
import 'package:cocktail_app/screens/qr/view_model/qr_scanner_screen_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  final GlobalKey _qrKey = GlobalKey();
  QRViewController? _controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller?.pauseCamera();
    } else if (Platform.isIOS) {
      _controller?.resumeCamera();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController qrController) {
    _controller = qrController;
    _controller?.scannedDataStream.take(1).listen(_navitateToDetailAfterScan);
  }

  void _navitateToDetailAfterScan(Barcode scanData) async {
    final code = scanData.code ?? "";
    final cocktail = await fetchViewModel<QrScannerScreenViewModel>(context)
        .findByIdsFromQRScan(code);
    Navigator.pop(context);
    if (cocktail != null) {
      Navigator.pushNamed(context, Routes.detail, arguments: cocktail);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: QRView(
        key: _qrKey,
        onQRViewCreated: _onQRViewCreated,
        overlay: QrScannerOverlayShape(),
        cameraFacing: CameraFacing.back,
        formatsAllowed: const [BarcodeFormat.qrcode],
      ),
    );
  }
}
