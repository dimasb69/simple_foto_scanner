

String getDateNow () {
  var d = DateTime.now();
  final hours = d.hour.toString().padLeft(2, '0');
  final minutes = d.minute.toString().padLeft(2, '0');
  final seconds = d.second.toString().padLeft(2, '0');
  var date = '${d.day}${d.month}${d.year}$hours$minutes$seconds';
  return date.toString();
}


Future<void> sleepTime(dur) async {
  await Future.delayed(Duration(seconds: dur));
}