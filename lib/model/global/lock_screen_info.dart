class LockScreenInfo {
  final bool? isLockScreen;
  final String? lockScreenText;

  LockScreenInfo({
    this.isLockScreen,
    this.lockScreenText,
  });

  factory LockScreenInfo.fromJson(Map<String, dynamic> parsedJson) {
    return LockScreenInfo(
      isLockScreen: parsedJson['isLockScreen'],
      lockScreenText: parsedJson['lockScreenText'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (isLockScreen != null) {
      data['isLockScreen'] = this.isLockScreen;
    }
    if (lockScreenText != null) {
      data['statusName'] = this.lockScreenText;
    }
    return data;
  }
}
