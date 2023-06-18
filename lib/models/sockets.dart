class Sockets {
  final List<bool> sockets;

  Sockets({this.sockets = const [false, false, false, false]});

  static Sockets fromJson(Map json) => Sockets(
          sockets: List.from([
        json['socket_1'],
        json['socket_2'],
        json['socket_3'],
        json['socket_4']
      ]));

  Map<String, dynamic> toJson() => {
        "socket_1": sockets[0],
        "socket_2": sockets[1],
        "socket_3": sockets[2],
        "socket_4": sockets[3]
      };
}
