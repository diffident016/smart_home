class Fans {
  final List<bool> fans;

  Fans({this.fans = const [false, false, false, false]});

  static Fans fromJson(Map json) => Fans(
          fans: List.from([
        json['kitchen'],
        json['living_room'],
        json['bedroom'],
        json['guest_room']
      ]));

  Map<String, dynamic> toJson() => {
        "kitchen": fans[0],
        "living_room": fans[1],
        "bedroom": fans[2],
        "guest_room": fans[3]
      };
}
