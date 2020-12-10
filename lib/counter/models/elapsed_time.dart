class ElapsedTime {
  ElapsedTime(this.value) : assert(value != null);
  final Duration value;
  int get inDays => value.inDays;
  int get inHours => value.inHours % 24;
  int get inMinutes => value.inMinutes % 60;
  int get inSeconds => value.inSeconds % 60;
}
