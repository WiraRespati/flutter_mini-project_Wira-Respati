class DateConstant{
  static String minute(String date) {
    DateTime dateTime = DateTime.parse(date);

  // Mendapatkan objek DateTime untuk saat ini
  DateTime now = DateTime.now();

  // Menghitung perbedaan waktu antara createdAt dan now
  Duration difference = now.difference(dateTime);

  // Mengonversi perbedaan waktu menjadi jumlah hari
  int daysPassed = difference.inMinutes;

  return daysPassed.toString();
  }
}