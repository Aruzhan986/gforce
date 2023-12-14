import 'package:equatable/equatable.dart';

abstract class QrEvent extends Equatable {
  const QrEvent();

  @override
  List<Object> get props => [];
}

class QrScanStarted extends QrEvent {
  final String qrCode;

  const QrScanStarted(this.qrCode);

  @override
  List<Object> get props => [qrCode];
}

class QrCameraToggled extends QrEvent {}

class QrFlashToggled extends QrEvent {}
