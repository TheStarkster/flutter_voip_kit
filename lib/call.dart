import 'dart:convert';

import 'flutter_voip_kit.dart';

enum CallState { connecting, active, held, ended, failed, incoming }

///Call object represents a call going on with the users device
class Call {
  ///UUID of call
  final String uuid;

  ///address or handle of the call
  final String address;

  ///outgoing is true if call is initiated by the user
  final bool outgoing;

  ///current state of call
  CallState callState;

  //actions

  ///End the call initiated by the user
  Future<bool> end() async {
    return FlutterVoipKit.endCall(this.uuid);
  }

  ///hold the call initiated by the user
  Future<bool> hold({bool onHold = true}) {
    return FlutterVoipKit.holdCall(this.uuid, onHold: onHold);
  }

  Call({
    this.uuid,
    this.address,
    this.outgoing,
    this.callState,
  });

  Call copyWith(
      {String uuid, String address, bool outgoing, CallState callState}) {
    return Call(
        uuid: uuid ?? this.uuid,
        address: address ?? this.address,
        outgoing: outgoing ?? this.outgoing,
        callState: callState ?? this.callState);
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'address': address,
      'outgoing': outgoing,
      'callState': this.callState.index
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'Call(uuid: $uuid, address: $address, outgoing: $outgoing, state: $callState)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Call &&
        other.uuid == uuid &&
        other.address == address &&
        other.outgoing == outgoing &&
        other.callState == callState;
  }

  @override
  int get hashCode =>
      uuid.hashCode ^ address.hashCode ^ outgoing.hashCode ^ callState.hashCode;
}
