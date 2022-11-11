import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

setUserId(userId) async {
  await _prefs.then((value) {
    value.setString("userId", userId);
  });
}

setPhoneNumber(phoneNumber) async {
  await _prefs.then((value) {
    value.setString("phoneNumber", phoneNumber);
  });
}

setUserName(userName) async {
  await _prefs.then((value) {
    value.setString("userName", userName);
  });
}

clearData() async {
  await _prefs.then((value) => value.clear());
}

// setCallType(callType) async {
//   await _prefs.then((value){
//     value.setString("callType", callType);
//   });
// }

Future<String> getId() async {
  String userId = "";
  await _prefs.then((value) {
    userId = (value.getString("userId") ?? "");
  });
  return userId;
}

Future<String> getPhoneNumber() async {
  String phoneNumber = "";
  await _prefs.then((value) {
    phoneNumber = value.getString("phoneNumber")!;
  });
  return phoneNumber;
}

Future<String> getuserName() async {
  String userName = "";
  await _prefs.then((value) {
    userName = (value.getString("userName") ?? "");
  });
  return userName;
}

// Future<String> getCallType() async {
//   String callType = "";
//   await _prefs.then((value){
//     callType =  value.getString("callType")!;
//   });
//   return callType;
// }