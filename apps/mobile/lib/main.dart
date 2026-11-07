import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'house.dart';
import 'measure.dart';

void main() {
  runApp(const CasamigoApp());
}

class CasamigoApp extends StatelessWidget {
  const CasamigoApp({super.key});

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF2A241C);
    const paper = Color(0xFFF3EBE1);
    final body = GoogleFonts.nunito(color: ink, fontSize: 17, height: 1.45);
    return MaterialApp(
      title: 'Casamigo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: paper,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF8C4A32),
          onPrimary: Color(0xFFFBF6EF),
          primaryContainer: Color(0xFFE7D3C4),
          onPrimaryContainer: Color(0xFF2A241C),
          secondary: Color(0xFF5E6B4A),
          onSecondary: Color(0xFFFBF6EF),
          secondaryContainer: Color(0xFFD5DCC8),
          onSecondaryContainer: Color(0xFF2A241C),
          error: Color(0xFF8C3A32),
          onError: Color(0xFFFBF6EF),
          surface: Color(0xFFFBF6EF),
          onSurface: Color(0xFF2A241C),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF8C4A32),
            foregroundColor: const Color(0xFFFBF6EF),
          ),
        ),
        textTheme: TextTheme(
          displaySmall: GoogleFonts.fraunces(
            fontSize: 36,
            height: 1.05,
            fontWeight: FontWeight.w500,
            color: ink,
          ),
          headlineSmall: GoogleFonts.fraunces(
            fontSize: 26,
            height: 1.15,
            fontWeight: FontWeight.w500,
            color: ink,
          ),
          titleMedium: GoogleFonts.fraunces(
            fontSize: 20,
            height: 1.2,
            fontWeight: FontWeight.w500,
            color: ink,
          ),
          bodyLarge: body,
          bodyMedium: body.copyWith(fontSize: 15),
          labelLarge: GoogleFonts.nunito(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: ink,
          ),
        ),
      ),
      home: const Shell(),
    );
  }
}

class Shell extends StatefulWidget {
  const Shell({super.key});

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  HouseBook? book;
  int index = 0;

  @override
  void initState() {
    super.initState();
    HouseBook.load().then((value) {
      if (mounted) setState(() => book = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final loaded = book;
    if (loaded == null) {
      return const Scaffold(body: Center(child: Text('Opening the house…')));
    }
    return AnimatedBuilder(
      animation: loaded,
      builder: (context, _) {
        if (loaded.account == null) {
          return LoginPage(book: loaded);
        }
        final wide = MediaQuery.sizeOf(context).width >= 840;
        final pages = [
          HomePage(book: loaded),
          StayPage(book: loaded),
          PapersPage(book: loaded, wide: wide),
          FixPage(book: loaded, wide: wide),
          MetersPage(book: loaded),
        ];
        const labels = ['Home', 'Stay', 'Papers', 'Fix', 'Meters'];
        if (!wide) {
          return Scaffold(
            body: SafeArea(child: pages[index]),
            bottomNavigationBar: NavigationBar(
              selectedIndex: index,
              backgroundColor: const Color(0xFFFBF6EF),
              indicatorColor: const Color(0xFFE7D3C4),
              labelTextStyle: WidgetStatePropertyAll(
                Theme.of(context).textTheme.labelLarge,
              ),
              destinations: [
                for (final label in labels)
                  NavigationDestination(icon: const SizedBox.shrink(), label: label),
              ],
              onDestinationSelected: (value) => setState(() => index = value),
            ),
          );
        }
        final em = Em.of(context);
        return Scaffold(
          body: Row(
            children: [
              NavigationRail(
                backgroundColor: const Color(0xFFE9DFD2),
                selectedIndex: index,
                labelType: NavigationRailLabelType.all,
                selectedLabelTextStyle: Theme.of(context).textTheme.labelLarge,
                unselectedLabelTextStyle: Theme.of(context).textTheme.bodyMedium,
                indicatorColor: const Color(0xFFE4D2C2),
                onDestinationSelected: (value) => setState(() => index = value),
                trailing: TextButton(
                  onPressed: () {
                    loaded.signOut();
                    setState(() => index = 0);
                  },
                  child: const Text('Sign out'),
                ),
                leading: Padding(
                  padding: EdgeInsets.only(top: em(1.2)),
                  child: Image.asset(
                    'assets/brand/casamigo-icon.jpg',
                    width: em(3.2),
                    height: em(3.2),
                  ),
                ),
                destinations: [
                  for (final label in labels)
                    NavigationRailDestination(
                      icon: const SizedBox.shrink(),
                      label: Text(label),
                    ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: em(46)),
                    child: pages[index],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.book});
  final HouseBook book;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  String? error;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void submit() {
    final message = widget.book.signIn(email.text, password.text);
    setState(() => error = message);
  }

  @override
  Widget build(BuildContext context) {
    final em = Em.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: em(28)),
            child: ListView(
              padding: EdgeInsets.all(em(1.4)),
              children: [
                const BrandMark(large: true),
                SizedBox(height: em(1.2)),
                Text('Come in as yourself', style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(height: em(0.4)),
                const Text('The tenant and the landlord each have their own door. The house is the same.'),
                SizedBox(height: em(1)),
                TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  onSubmitted: (_) => submit(),
                ),
                SizedBox(height: em(0.6)),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Phrase'),
                  onSubmitted: (_) => submit(),
                ),
                if (error != null) ...[
                  SizedBox(height: em(0.6)),
                  Text(error!, style: const TextStyle(color: Color(0xFF8C3A32))),
                ],
                SizedBox(height: em(1)),
                FilledButton(onPressed: submit, child: const Text('Open the house')),
                SizedBox(height: em(1.2)),
                const Text('Leon, tenant — leon@winterfeldt.de'),
                const Text('Frau Adler, landlord — adler@winterfeldt.de'),
                const Text('The phrase for both doors is stay.'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.book});
  final HouseBook book;

  @override
  Widget build(BuildContext context) {
    final em = Em.of(context);
    final home = book.home;
    final limits = book.limits;
    final left = (limits['yearlyCap'] as num) - (limits['yearlySpent'] as num);
    final lead = book.landlord
        ? 'You owe the building, the pipes, and the heating. Leon fills the shelf holes before the keys come back.'
        : 'The smoke alarm is due, the October electricity bill is still an estimate, and the heating is running ahead of last winter.';
    return PageFrame(
      child: ListView(
        padding: EdgeInsets.all(em(1.4)),
        children: [
          const BrandMark(),
          SizedBox(height: em(0.4)),
          Text('${home['address']}, ${home['city']}', style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: em(1)),
          Text(
            book.landlord ? 'Signed in as the landlord' : 'Signed in as the tenant',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Text(
            book.account!.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: em(0.4)),
          Text(lead),
          SizedBox(height: em(1.2)),
          const StayRibbon(),
          SizedBox(height: em(1.2)),
          Text('Waiting', style: Theme.of(context).textTheme.titleMedium),
          for (final item in book.waiting())
            Padding(
              padding: EdgeInsets.only(top: em(0.5)),
              child: Sheet(child: Text(item['title'] as String)),
            ),
          SizedBox(height: em(1.2)),
          Sheet(
            child: Text(
              book.landlord
                  ? 'Leon covers small repairs up to ${limits['smallRepairCap']} euros each, and ${limits['yearlyCap']} in a year. ${limits['yearlySpent']} is already spent. The building, the pipes, and the heating stay with you.'
                  : 'Small repairs are yours up to ${limits['smallRepairCap']} euros each, and ${limits['yearlyCap']} in a year. ${limits['yearlySpent']} is already spent, so $left remains.',
            ),
          ),
          SizedBox(height: em(0.8)),
          TextButton(
            onPressed: book.signOut,
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}

class StayRibbon extends StatelessWidget {
  const StayRibbon({super.key});

  @override
  Widget build(BuildContext context) {
    final em = Em.of(context);
    return Row(
      children: [
        for (final label in ['Moved in', 'Now', 'Keys back'])
          Expanded(
            child: Column(
              children: [
                Container(
                  width: em(0.7),
                  height: em(0.7),
                  decoration: BoxDecoration(
                    color: label == 'Now' ? const Color(0xFFC46B4A) : const Color(0xFF5E6B4A),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(height: em(0.35)),
                Text(label, style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
          ),
      ],
    );
  }
}

class StayPage extends StatelessWidget {
  const StayPage({super.key, required this.book});
  final HouseBook book;

  @override
  Widget build(BuildContext context) {
    final em = Em.of(context);
    return PageFrame(
      child: ListView(
        padding: EdgeInsets.all(em(1.4)),
        children: [
          Text('The stay', style: Theme.of(context).textTheme.displaySmall),
          for (final phase in book.phases) ...[
            SizedBox(height: em(1.2)),
            Text(phase['title'] as String, style: Theme.of(context).textTheme.titleMedium),
            for (final raw in phase['items'] as List)
              _Check(book: book, item: Map<String, dynamic>.from(raw as Map)),
          ],
        ],
      ),
    );
  }
}

class _Check extends StatelessWidget {
  const _Check({required this.book, required this.item});
  final HouseBook book;
  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    final em = Em.of(context);
    final done = book.isDone(item);
    return Padding(
      padding: EdgeInsets.only(top: em(0.45)),
      child: Sheet(
        child: InkWell(
          onTap: () => book.toggle(item),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title'] as String,
                      style: TextStyle(
                        decoration: done ? TextDecoration.lineThrough : null,
                        color: const Color(0xFF2A241C),
                      ),
                    ),
                    Text(book.dutyLine(item), style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              Text(done ? 'Kept' : 'Open', style: Theme.of(context).textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }
}

class PapersPage extends StatelessWidget {
  const PapersPage({super.key, required this.book, required this.wide});
  final HouseBook book;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final em = Em.of(context);
    final list = ListView(
      padding: EdgeInsets.all(em(1.4)),
      children: [
        Text('House papers', style: Theme.of(context).textTheme.displaySmall),
        SizedBox(height: em(0.6)),
        for (final paper in book.papers)
          Padding(
            padding: EdgeInsets.only(top: em(0.5)),
            child: Sheet(
              child: InkWell(
                onTap: () => book.selectPaper(paper['id'] as String),
                child: Text(paper['title'] as String, style: Theme.of(context).textTheme.titleMedium),
              ),
            ),
          ),
      ],
    );
    final open = book.openPaperId == null ? null : book.paper(book.openPaperId!);
    final detail = open == null
        ? const SizedBox.shrink()
        : PaperDetail(paper: open, onClose: () => book.selectPaper(null));
    if (wide) {
      return PageFrame(
        child: Row(
          children: [
            Expanded(child: list),
            if (open != null) Expanded(child: detail),
          ],
        ),
      );
    }
    return PageFrame(
      child: open == null ? list : detail,
    );
  }
}

class PaperDetail extends StatelessWidget {
  const PaperDetail({super.key, required this.paper, required this.onClose});
  final Map<String, dynamic> paper;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final em = Em.of(context);
    return ListView(
      padding: EdgeInsets.all(em(1.4)),
      children: [
        TextButton(onPressed: onClose, child: const Text('Back to the papers')),
        Text(paper['title'] as String, style: Theme.of(context).textTheme.headlineSmall),
        SizedBox(height: em(0.8)),
        Text('In short', style: Theme.of(context).textTheme.titleMedium),
        Text(paper['summary'] as String),
        SizedBox(height: em(0.8)),
        Text('English', style: Theme.of(context).textTheme.titleMedium),
        Text(paper['translation'] as String),
        SizedBox(height: em(0.8)),
        Text('Original', style: Theme.of(context).textTheme.titleMedium),
        Text(paper['original'] as String),
      ],
    );
  }
}

class FixPage extends StatelessWidget {
  const FixPage({super.key, required this.book, required this.wide});
  final HouseBook book;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final em = Em.of(context);
    final list = ListView(
      padding: EdgeInsets.all(em(1.4)),
      children: [
        Text('Something in the apartment', style: Theme.of(context).textTheme.displaySmall),
        for (final issue in book.issues)
          Padding(
            padding: EdgeInsets.only(top: em(0.5)),
            child: Sheet(
              child: InkWell(
                onTap: () => book.selectIssue(issue['id'] as String),
                child: Text(issue['title'] as String),
              ),
            ),
          ),
      ],
    );
    final open = book.openIssueId == null ? null : book.issue(book.openIssueId!);
    final detail = open == null
        ? const SizedBox.shrink()
        : IssueDetail(book: book, issue: open);
    if (wide && open != null) {
      return PageFrame(
        child: Row(children: [Expanded(child: list), Expanded(child: detail)]),
      );
    }
    return PageFrame(child: open == null ? list : detail);
  }
}

class IssueDetail extends StatelessWidget {
  const IssueDetail({super.key, required this.book, required this.issue});
  final HouseBook book;
  final Map<String, dynamic> issue;

  @override
  Widget build(BuildContext context) {
    final em = Em.of(context);
    final id = issue['id'] as String;
    final trade = book.tradeFor(issue['trade'] as String);
    final payer = issue['payer'] == 'tenant'
        ? 'Leon pays'
        : issue['payer'] == 'landlord'
            ? 'Frau Adler pays'
            : 'It depends on the cause';
    return ListView(
      padding: EdgeInsets.all(em(1.4)),
      children: [
        TextButton(onPressed: () => book.selectIssue(null), child: const Text('All problems')),
        Text(issue['title'] as String, style: Theme.of(context).textTheme.headlineSmall),
        SizedBox(height: em(0.4)),
        Text(payer, style: Theme.of(context).textTheme.titleMedium),
        Text(issue['reason'] as String),
        SizedBox(height: em(0.8)),
        Text('What you can do', style: Theme.of(context).textTheme.titleMedium),
        for (final step in issue['diy'] as List) Text(step as String),
        SizedBox(height: em(0.8)),
        Text('Tell the landlord if', style: Theme.of(context).textTheme.titleMedium),
        Text(issue['askLandlordWhen'] as String),
        if (trade != null) ...[
          SizedBox(height: em(0.8)),
          Text('${trade['name']}, ${trade['trade']}', style: Theme.of(context).textTheme.titleMedium),
          Text('${trade['area']} · ${trade['nextSlot']}'),
        ],
        SizedBox(height: em(0.8)),
        FilledButton(
          onPressed: () => book.keepPhoto(id),
          child: Text(book.photos[id] == true ? 'Photo kept with the case' : 'Photograph the spot'),
        ),
        SizedBox(height: em(0.4)),
        OutlinedButton(
          onPressed: trade == null ? null : () => book.book(id),
          child: Text(book.booked[id] == true ? 'Visit booked' : 'Book the visit'),
        ),
      ],
    );
  }
}

class MetersPage extends StatelessWidget {
  const MetersPage({super.key, required this.book});
  final HouseBook book;

  @override
  Widget build(BuildContext context) {
    final em = Em.of(context);
    return PageFrame(
      child: ListView(
        padding: EdgeInsets.all(em(1.4)),
        children: [
          Text('Meters', style: Theme.of(context).textTheme.displaySmall),
          Text(book.home['seasonNote'] as String),
          for (final meter in book.meters) ...[
            SizedBox(height: em(0.8)),
            Sheet(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(meter['label'] as String, style: Theme.of(context).textTheme.titleMedium),
                  Text(
                    'This year ${meter['thisYear']} ${meter['unit']} · last year ${meter['lastYear']}',
                  ),
                  Text(meter['note'] as String),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.large = false});

  final bool large;

  @override
  Widget build(BuildContext context) {
    final em = Em.of(context);
    final size = large ? em(8) : em(3.4);
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(em(large ? 1.4 : 0.7)),
          child: Image.asset(
            'assets/brand/casamigo-icon.jpg',
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),
        if (large) ...[
          SizedBox(height: em(0.7)),
          Text('Casamigo', style: Theme.of(context).textTheme.displaySmall),
          Text('The stay, kept by both.', style: Theme.of(context).textTheme.bodyMedium),
        ],
      ],
    );
  }
}

class PageFrame extends StatelessWidget {
  const PageFrame({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => SafeArea(child: child);
}

class Sheet extends StatelessWidget {
  const Sheet({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final em = Em.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFFBF6EF),
        borderRadius: BorderRadius.circular(em(0.6)),
      ),
      child: Padding(padding: EdgeInsets.all(em(0.8)), child: child),
    );
  }
}
