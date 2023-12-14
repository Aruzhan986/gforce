abstract class QrState {}

class QrInitial extends QrState {}

class QrScanSuccess extends QrState {
  final String qrData;

  QrScanSuccess(this.qrData);
}

class QrFailure extends QrState {
  final String error;

  QrFailure(this.error);
}

class QrCameraToggledState extends QrState {}

class QrFlashToggledState extends QrState {
  final bool isFlashOn;

  QrFlashToggledState(this.isFlashOn);
}
