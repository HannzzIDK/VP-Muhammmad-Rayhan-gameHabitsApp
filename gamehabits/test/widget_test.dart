import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gamehabits/main.dart'; // Sesuaikan jika path-nya berbeda
import 'package:gamehabits/models/quest.dart';
import 'package:gamehabits/widgets/quest_card.dart';

const Size small = Size(320, 568);
const Size large = Size(430, 932);
const Size tablet = Size(800, 1280);

const List<(String, Size)> screens = [
  ('small phone', small),
  ('large phone', large),
  ('tablet', tablet),
];

// --- 1. TAMBAHKAN VARIABEL DUMMY UNTUK TES 5 & 7 ---
final List<Quest> kLongNameMenu = [
  Quest(
    id: 99,
    title: 'Misi ini memiliki nama yang saaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaangat panjang.',
    isMainQuest: true,
    expReward: 10,
    coinReward: 5,
  ),
];

final List<Quest> kBigMenu = List.generate(
  500,
  (index) => Quest(
    id: index,
    title: 'Quest Nomor $index',
    isMainQuest: index % 2 == 0, // Selang-seling main/side quest
    expReward: 10,
    coinReward: 5,
  ),
);

/// Sets the fake screen, pumps the app and lets every animation finish.
Future<void> pumpLab(
  WidgetTester tester,
  Size size, {
  List<Quest>? items, // 1. Ubah menjadi nullable, hapus default value di sini
  double keyboard = 0,
  double topInset = 0,
  double bottomInset = 0,
  ThemeMode theme = ThemeMode.light,
}) async {
  // 2. Definisikan default data di dalam fungsi
  final testItems =
      items ??
      <Quest>[
        Quest(
          id: 1,
          title: 'Quest 1',
          isMainQuest: true,
          expReward: 10,
          coinReward: 5,
          isCompleted: false,
        ),
        Quest(
          id: 2,
          title: 'Quest 2',
          isMainQuest: false,
          expReward: 20,
          coinReward: 10,
          isCompleted: false,
        ),
        Quest(
          id: 3,
          title: 'Quest 3',
          isMainQuest: true,
          expReward: 30,
          coinReward: 15,
          isCompleted: false,
        ),
      ];

  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = size;
  tester.view.viewInsets = FakeViewPadding(bottom: keyboard);
  tester.view.padding = FakeViewPadding(top: topInset, bottom: bottomInset);
  tester.view.viewPadding = FakeViewPadding(top: topInset, bottom: bottomInset);
  addTearDown(tester.view.reset);

  // 3. Gunakan testItems di sini
  await tester.pumpWidget(QuestTrackerApp(items: testItems, themeMode: theme));
  await tester.pumpAndSettle();
}

void expectNoLayoutErrors(WidgetTester tester) {
  final Object? error = tester.takeException();
  expect(error, isNull, reason: 'Layout error:\n$error');
}

Finder get mainScrollable => find
    .byWidgetPredicate(
      (widget) =>
          widget is Scrollable && widget.axisDirection == AxisDirection.down,
    )
    .first;

void main() {
  group('Lab 04 — the unbreakable screen', () {
    testWidgets('1 · small phone, 320 dp', (tester) async {
      await pumpLab(tester, small);
      expectNoLayoutErrors(tester);
    });

    testWidgets('2 · large phone, 430 dp', (tester) async {
      await pumpLab(tester, large);
      expectNoLayoutErrors(tester);
    });

    testWidgets(
      '3 · tablet, 800 dp — the layout changes, it does not stretch',
      (tester) async {
        await pumpLab(tester, tablet);
        expectNoLayoutErrors(tester);
        expect(
          // 3. UBAH DARI QuestTile MENJADI QuestCard
          find.byType(QuestCard),
          findsNothing,
          reason: 'At 800 dp the phone list should become a grid or two panes.',
        );
      },
    );

    for (final (name, size) in screens) {
      testWidgets('4 · landscape — $name', (tester) async {
        await pumpLab(tester, size.flipped);
        expectNoLayoutErrors(tester);
      });
    }

    for (final (name, size) in screens) {
      testWidgets('5 · a 200-character item name — $name', (tester) async {
        await pumpLab(tester, size, items: kLongNameMenu);
        expectNoLayoutErrors(tester);
      });
    }

    testWidgets('6 · zero items shows an empty state', (tester) async {
      await pumpLab(tester, small, items: const <Quest>[]);
      expectNoLayoutErrors(tester);
      expect(
        find.byKey(const Key('empty-state')),
        findsOneWidget,
        reason: "Zero items needs an empty state with key: const Key('empty-state').",
      );
    });

    testWidgets('7 · 500 items — built lazily, scrolled hard', (tester) async {
      await pumpLab(tester, small, items: kBigMenu);
      expectNoLayoutErrors(tester);
      expect(
        // 3. UBAH DARI QuestTile MENJADI QuestCard
        find.byType(QuestCard).evaluate().length,
        lessThan(100),
        reason: 'Only the visible tiles should be built. Is a long list shrink-wrapped?',
      );

      for (var i = 0; i < 5; i++) {
        await tester.fling(mainScrollable, const Offset(0, -2000), 3000);
        await tester.pumpAndSettle();
      }
      expectNoLayoutErrors(tester);
    });

    testWidgets(
      '8 · keyboard open on a short screen — content stays reachable',
      (tester) async {
        await pumpLab(tester, small, keyboard: 260);
        expectNoLayoutErrors(tester);
        final field = tester.getRect(find.byKey(const Key('search-field')));
        expect(
          field.bottom,
          lessThanOrEqualTo(small.height - 260),
          reason: 'The search field is hidden behind the keyboard.',
        );
        expect(
          tester.getRect(mainScrollable).bottom,
          lessThanOrEqualTo(small.height - 260),
          reason: 'The scrollable content should end above the keyboard so everything can be scrolled into view.',
        );
      },
    );

    testWidgets('8 · keyboard open in landscape', (tester) async {
      await pumpLab(tester, small.flipped, keyboard: 180);
      expectNoLayoutErrors(tester);
    });

    for (final (name, size) in screens) {
      testWidgets('9 · dark mode — $name', (tester) async {
        await pumpLab(tester, size, theme: ThemeMode.dark);
        expectNoLayoutErrors(tester);
      });
    }

    testWidgets('Bonus · notch and gesture bar', (tester) async {
      await pumpLab(tester, small, topInset: 32, bottomInset: 20);
      expectNoLayoutErrors(tester);
      final button = tester.getRect(find.byKey(const Key('order-button')));
      expect(
        button.bottom,
        lessThanOrEqualTo(small.height - 20),
        reason: 'The order button sits under the gesture bar. Which widget keeps content out of it?',
      );
    });
  });
}
