import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Account {
  const Account({
    required this.email,
    required this.password,
    required this.name,
    required this.landlord,
  });

  final String email;
  final String password;
  final String name;
  final bool landlord;
}

const doorAccounts = [
  Account(
    email: 'leon@winterfeldt.de',
    password: 'stay',
    name: 'Leon Keller',
    landlord: false,
  ),
  Account(
    email: 'adler@winterfeldt.de',
    password: 'stay',
    name: 'Frau Adler',
    landlord: true,
  ),
];

class HouseBook extends ChangeNotifier {
  HouseBook(this.data);

  final Map<String, dynamic> data;
  Account? account;

  bool get landlord => account?.landlord ?? false;
  String? openPaperId;
  String? openIssueId;
  final Map<String, bool> done = {};
  final Map<String, bool> photos = {};
  final Map<String, bool> booked = {};
  final Map<String, num> customMeterReadings = {};

  static Future<HouseBook> load() async {
    final raw = await rootBundle.loadString('assets/seed.json');
    return HouseBook(jsonDecode(raw) as Map<String, dynamic>);
  }

  void switchDoor(Account target) {
    account = target;
    notifyListeners();
  }

  num meterReading(Map<String, dynamic> meter) {
    final id = meter['id'] as String;
    return customMeterReadings[id] ?? (meter['thisYear'] as num);
  }

  void updateMeterReading(String id, num value) {
    customMeterReadings[id] = value;
    notifyListeners();
  }

  int totalTasksCount() {
    var count = 0;
    for (final phase in phases) {
      count += (phase['items'] as List).length;
    }
    return count;
  }

  int completedTasksCount() {
    var count = 0;
    for (final phase in phases) {
      for (final raw in phase['items'] as List) {
        if (isDone(raw as Map)) count++;
      }
    }
    return count;
  }

  Map<String, dynamic> get home => data['home'] as Map<String, dynamic>;
  Map<String, dynamic> get limits => home['limits'] as Map<String, dynamic>;

  List<Map<String, dynamic>> get phases => [
        for (final phase in (data['journey'] as Map)['phases'] as List)
          Map<String, dynamic>.from(phase as Map),
      ];

  List<Map<String, dynamic>> get papers => [
        for (final paper in data['papers'] as List)
          Map<String, dynamic>.from(paper as Map),
      ];

  List<Map<String, dynamic>> get issues => [
        for (final issue in data['issues'] as List)
          Map<String, dynamic>.from(issue as Map),
      ];

  List<Map<String, dynamic>> get meters => [
        for (final meter in data['meters'] as List)
          Map<String, dynamic>.from(meter as Map),
      ];

  List<Map<String, dynamic>> get trades => [
        for (final trade in data['trades'] as List)
          Map<String, dynamic>.from(trade as Map),
      ];

  bool isDone(Map item) => done[item['id']] ?? item['done'] == true;

  void toggle(Map item) {
    done['${item['id']}'] = !isDone(item);
    notifyListeners();
  }

  List<Map<String, dynamic>> waiting() {
    final items = <Map<String, dynamic>>[];
    for (final phase in phases) {
      for (final raw in phase['items'] as List) {
        final item = Map<String, dynamic>.from(raw as Map);
        if (!isDone(item) && mine(item)) items.add(item);
      }
    }
    return items.take(3).toList();
  }

  Map<String, dynamic>? paper(String id) {
    for (final item in papers) {
      if (item['id'] == id) return item;
    }
    return null;
  }

  Map<String, dynamic>? issue(String id) {
    for (final item in issues) {
      if (item['id'] == id) return item;
    }
    return null;
  }

  Map<String, dynamic>? tradeFor(String trade) {
    for (final item in trades) {
      if (item['trade'] == trade) return item;
    }
    return null;
  }

  String? signIn(String email, String password) {
    final needle = email.trim().toLowerCase();
    for (final door in doorAccounts) {
      if (door.email == needle && door.password == password) {
        account = door;
        notifyListeners();
        return null;
      }
    }
    return 'That address and phrase do not open this house.';
  }

  void signOut() {
    account = null;
    openPaperId = null;
    openIssueId = null;
    notifyListeners();
  }

  bool mine(Map item) {
    final owner = item['owner'];
    if (owner == 'both') return true;
    return landlord ? owner == 'landlord' : owner == 'tenant';
  }

  String dutyLine(Map item) {
    final owner = item['owner'];
    if (owner == 'both') return 'Both of you';
    if (mine(item)) return 'Yours';
    return landlord ? 'Leon, the tenant' : 'Frau Adler, the landlord';
  }

  void selectPaper(String? id) {
    openPaperId = id;
    notifyListeners();
  }

  void selectIssue(String? id) {
    openIssueId = id;
    notifyListeners();
  }

  void keepPhoto(String id) {
    photos[id] = true;
    notifyListeners();
  }

  void book(String id) {
    booked[id] = true;
    notifyListeners();
  }
}
