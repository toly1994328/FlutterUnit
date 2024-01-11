import 'dart:math';


class Rnd {
  static int _seed = DateTime.now().millisecondsSinceEpoch;
  static Random random = Random(_seed);

  static set seed(int val) => random = Random(_seed = val);
  static int get seed => _seed;

  /// Gets the next double.
  static get ratio => random.nextDouble();

  /// Gets a random int between [min] and [max].
  static int getInt(int min, int max) {
    return min + random.nextInt(max - min);
  }

  /// Gets a random double between [min] and [max].
  static double getDouble(double min, double max) {
    return min + random.nextDouble() * (max - min);
  }

  /// Gets a random boolean with chance [chance].
  static bool getBool([double chance = 0.5]) {
    return random.nextDouble() < chance;
  }

  /// Randomize the positions of items in a list.
  static List shuffle(List list) {
    for (int i = 0, l = list.length; i < l; i++) {
      int j = random.nextInt(l);
      if (j == i) {
        continue;
      }
      dynamic item = list[j];
      list[j] = list[i];
      list[i] = item;
    }
    return list;
  }

  /// Randomly selects an item from a list.
  static dynamic getItem(List list) {
    return list[random.nextInt(list.length)];
  }

}
