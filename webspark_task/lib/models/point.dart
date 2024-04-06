class Point {
  final int x;
  final int y;
  String symbol;

  Point({required this.x, required this.y, String sybmol = '.'})
      : symbol = sybmol;

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(x: json['x'], y: json['y']);
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }

  @override
  String toString() => '($x,$y)';

  @override
  int get hashCode => x.hashCode + y.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Point && other.x == x && other.y == y;
}
