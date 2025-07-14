extension Formatter on double {
  String get nominal {
    String numberStr = toStringAsFixed(0);

    final regex = RegExp(r'(\d)(?=(\d{3})+(?!\d))');
    numberStr = numberStr.replaceAllMapped(regex, (match) => '${match[1]}.');
    return numberStr;
  }
}
