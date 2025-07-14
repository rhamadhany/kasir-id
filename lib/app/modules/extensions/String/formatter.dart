import 'dart:math';

extension Generator on String {
  String get plusGenerate {
    final random = Random();
    final chars = 'abcdefghijklmnopqrstwuxyz0123456789';
    final gen = String.fromCharCodes(
      Iterable.generate(
        8,
        (_) => chars.codeUnitAt(random.nextInt(chars.length)),
      ),
    );

    return '${gen}_$this';
  }
}
