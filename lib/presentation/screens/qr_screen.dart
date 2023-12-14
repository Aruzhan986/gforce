import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gforce/generated/locale_keys.g.dart';
import 'package:flutter_gforce/presentation/bloc/bloc_qr/qr_bloc.dart';
import 'package:flutter_gforce/presentation/bloc/bloc_qr/qr_event.dart';
import 'package:flutter_gforce/presentation/bloc/bloc_qr/qr_state.dart';
import 'package:flutter_gforce/presentation/constants/constants.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<QrBloc>(
      create: (context) => QrBloc(),
      child: Scaffold(
        body: BlocConsumer<QrBloc, QrState>(
          listener: (context, state) {
            if (state is QrScanSuccess) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(LocaleKeys.QR_Data.tr()),
                  content: Text(state.qrData),
                  actions: <Widget>[
                    TextButton(
                      child: Text(LocaleKeys.Close.tr()),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              );
            }
          },
          builder: (context, state) {
            return QRView(
              key: GlobalKey(debugLabel: 'QR'),
              onQRViewCreated: (QRViewController controller) {
                context.read<QrBloc>().qrViewController = controller;
                controller.scannedDataStream.listen((Barcode barcode) {
                  if (barcode.code != null) {
                    context.read<QrBloc>().add(QrScanStarted(barcode.code!));
                  }
                });
              },
              overlay: QrScannerOverlayShape(
                borderColor: PrimaryColors.Coloreight,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: MediaQuery.of(context).size.width * 0.8,
              ),
            );
          },
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () => context.read<QrBloc>().add(QrCameraToggled()),
              tooltip: LocaleKeys.Toggle_Camera.tr(),
              child: Icon(Icons.flip_camera_android),
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () => context.read<QrBloc>().add(QrFlashToggled()),
              tooltip: LocaleKeys.Toggle_Flash.tr(),
              child: Icon(Icons.flash_on),
            ),
          ],
        ),
      ),
    );
  }
}
