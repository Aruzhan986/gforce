import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gforce/presentation/bloc/bloc_qr/qr_event.dart';

import 'qr_state.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vibration/vibration.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  QRViewController? qrViewController;
  bool isFlashOn = false;

  QrBloc() : super(QrInitial()) {
    on<QrScanStarted>(_onScanStarted);
    on<QrCameraToggled>(_onCameraToggled);
    on<QrFlashToggled>(_onFlashToggled);
  }

  void _onScanStarted(QrScanStarted event, Emitter<QrState> emit) {
    emit(QrScanSuccess(event.qrCode));
  }

  void _onCameraToggled(QrCameraToggled event, Emitter<QrState> emit) {
    qrViewController?.flipCamera();
    emit(QrCameraToggledState());
  }

  void _onFlashToggled(QrFlashToggled event, Emitter<QrState> emit) async {
    qrViewController?.toggleFlash();
    isFlashOn = !isFlashOn;

    bool canVibrate = await Vibration.hasVibrator() ?? false;
    if (canVibrate) {
      Vibration.vibrate(duration: 100);
    }

    emit(QrFlashToggledState(isFlashOn));
  }
}
