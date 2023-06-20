class Utils {
  static String feedback(int command) {
    List<String> fb = [
      "Turning on, kitchen light.", //0, 0, 1
      "Turning off, kitchen light.", //0, 0, 0
      "Turning on, kitchen fan.", //1
      "Turning off, kitchen fan.", //1
      "Turning on, living room light.", //0
      "Turning off, living room light.", //0
      "Turning on, living room fan.", // 1
      "Turning off, living room fan.", //1
      "Turning on, bedroom light.", //0
      "Turning off, bedroom light.", //0
      "Turning on, bedroom fan.", //1
      "Turning off, bedroom fan.", //1
      "Turning on, guest room light.", // 0
      "Turning off, guest room light.", // 0
      "Turning on, guest room fan.", // 1
      "Turning off, guest room fan.", //1
      "Turning on, socket 1.",
      "Turning on, socket 2.",
      "Turning on, socket 3.",
      "Turning on, socket 4.",
      "Turning off, socket 1.",
      "Turning off, socket 2.",
      "Turning off, socket 3.",
      "Turning off, socket 4.",
      "Sorry, I don't understand."
    ];

    return command < 0 ? fb[fb.length - 1] : fb[command];
  }

  static List<int> response(int command) {
    final res = [
      [0, 0, 1],
      [0, 0, 0],
      [1, 0, 1],
      [1, 0, 0],
      [0, 1, 1],
      [0, 1, 0],
      [1, 1, 1],
      [1, 1, 0],
      [0, 2, 1],
      [0, 2, 0],
      [1, 2, 1],
      [1, 2, 0],
      [0, 3, 1],
      [0, 3, 0],
      [1, 3, 1],
      [1, 3, 0],
      [2, 1, 0],
      [2, 1, 0],
      [2, 1, 1],
      [2, 1, 1],
      [2, 0, 2],
      [2, 0, 2],
      [2, 0, 3],
      [2, 0, 3]
    ];
    return command == -1 ? [] : res[command];
  }

  static int readCommand(String command) {
    command = command.toLowerCase();

    if (_segment(command) == 0) {
      if (command.contains('light')) {
        if (command.contains('on')) {
          return 0;
        } else {
          return 1;
        }
      } else if (command.contains('fan')) {
        if (command.contains('on')) {
          return 2;
        } else {
          return 3;
        }
      }

      return -1;
    }

    if (_segment(command) == 1) {
      if (command.contains('light')) {
        if (command.contains('on')) {
          return 4;
        } else {
          return 5;
        }
      } else if (command.contains('fan')) {
        if (command.contains('on')) {
          return 6;
        } else {
          return 7;
        }
      }

      return -1;
    }

    if (_segment(command) == 2) {
      if (command.contains('light')) {
        if (command.contains('on')) {
          return 8;
        } else {
          return 9;
        }
      } else if (command.contains('fan')) {
        if (command.contains('on')) {
          return 10;
        } else {
          return 11;
        }
      }

      return -1;
    }

    if (_segment(command) == 3) {
      if (command.contains('light')) {
        if (command.contains('on')) {
          return 12;
        } else {
          return 13;
        }
      } else if (command.contains('fan')) {
        if (command.contains('on')) {
          return 14;
        } else {
          return 15;
        }
      }

      return -1;
    }

    if (command.contains('on socket')) {
      if (command.contains('1') || command.contains('one')) {
        return 16;
      }

      if (command.contains('2') || command.contains('two')) {
        return 17;
      }

      if (command.contains('3') || command.contains('three')) {
        return 18;
      }

      if (command.contains('4') || command.contains('four')) {
        return 19;
      }
    }

    if (command.contains('off socket')) {
      if (command.contains('1') || command.contains('one')) {
        return 20;
      }

      if (command.contains('2') || command.contains('two')) {
        return 21;
      }

      if (command.contains('3') || command.contains('three')) {
        return 22;
      }

      if (command.contains('4') || command.contains('four')) {
        return 23;
      }
    }

    return -1;
  }

  static int _segment(String command) {
    if (command.contains("kitchen")) {
      return 0;
    }

    if (command.contains("living room")) {
      return 1;
    }

    if (command.contains("bedroom")) {
      return 2;
    }

    if (command.contains("guest room")) {
      return 3;
    }

    return -1;
  }
}
