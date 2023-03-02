class Item {
  final String data;

  late bool isChecked;

  Item({required this.data, required this.isChecked});
}

class Time {
  final String time;
  final String medicine;

  Time({required this.time, required this.medicine});
}

class Check {
  final String medicine;
  final String time;
  late bool isChecked;

  Check({required this.medicine, required this.time, required this.isChecked});
}
