class DispatchDevicesModel {
  String? deviceModelName;
  String? deviceModelId;
  String? deviceCode;
  String deviceId;
  String deviceNumber;

  DispatchDevicesModel({
    required this.deviceModelName,
    required this.deviceModelId,
    required this.deviceCode,
    required this.deviceId,
    required this.deviceNumber,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceModelName'] = deviceModelName;
    data['deviceModelId'] = deviceModelId;
    data['deviceCode'] = deviceCode;
    data['deviceId'] = deviceId;
    data['deviceNumber'] = deviceNumber;
    return data;
  }
}
