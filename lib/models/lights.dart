class Lights {
  final List<bool> lights;

  Lights({this.lights = const [false, false, false, false]});

  static Lights fromJson(Map json) => Lights(
        lights: List.from([
          json['kitchen'],
          json['living_room'],
          json['bedroom'],
          json['guest_room']
        ]),
      );

  Map<String, dynamic> toJson() => {
        "kitchen": lights[0],
        "living_room": lights[1],
        "bedroom": lights[2],
        "guest_room": lights[3]
      };
}
