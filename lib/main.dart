// Copyright (c) 2022 beta
//
// This software is provided 'as-is', without any express or implied
// warranty. In no event will the authors be held liable for any damages
// arising from the use of this software.
//
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it
// freely, subject to the following restrictions:
//
// 1. The origin of this software must not be misrepresented; you must not
//    claim that you wrote the original software. If you use this software
//    in a product, an acknowledgment in the product documentation would be
//    appreciated but is not required.
// 2. Altered source versions must be plainly marked as such, and must not be
//    misrepresented as being the original software.
// 3. This notice may not be removed or altered from any source distribution.

import 'package:event_bus/event_bus.dart';
import 'package:fluff/fluff.dart';
import 'package:flutter/material.dart' hide Typography, MenuItem;
import 'package:flutter/services.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:window_manager/window_manager.dart';

import 'events.dart';
import 'gitmoji/gitmoji.dart';
import 'shortcuts.dart';
import 'tray.dart';
import 'widgets/gitmoji_view/gitmoji_view.dart';

const appName = 'Fluentmoji';

final EventBus bus = EventBus();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Tray icon
  await initSystemTray(bus: bus);

  // Register hotkeys
  await hotKeyManager.unregisterAll(); // For hot reload
  await registerHotkeys();

  await FluffApp.init(
    useCustomWindow: true,
    showSystemTitleBar: false,
    initialSize: const Size(360, 480),
    minSize: const Size(360, 480),
    // FIXME: find a way to only allow resizing vertically
    maxSize: const Size(360, 20000),
  );

  runApp(FluffApp(
    title: appName,
    windowControls: CaptionButtons(
      maximizeDisabled: true,
      onClose: windowManager.hide,
    ),
    child: const App(),
  ));
}

Future<void> registerHotkeys() async {
  // Ctrl + Shift + G (global): toggle window
  await hotKeyManager.register(
    HotKey(
      KeyCode.keyG,
      modifiers: [KeyModifier.control, KeyModifier.shift],
      scope: HotKeyScope.system,
    ),
    keyDownHandler: (hotkey) {
      bus.fire(ToggleWindowEvent());
    },
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> with WindowListener {
  final _focusNode = FocusNode();
  final _controller = TextEditingController();
  final _scrollController = AutoScrollController();

  final List<Gitmoji> _sortedGitmojis = List.of(Gitmoji.all)
    ..sort((a, b) => a.code.compareTo(b.code));
  late final Fuzzy<Gitmoji> _gitmojiFuzzy;

  // Search states
  String _searchText = '';
  late List<Gitmoji> _filteredGitmojis;

  // Selection states
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    // Listen to events from EventBus (hotkeys, etc.)
    _listenToBusEvents();

    // Listen to window events
    windowManager.addListener(this);

    // Init fuzzy search pool
    _gitmojiFuzzy = Fuzzy(_sortedGitmojis,
        options: FuzzyOptions(
          threshold: 0.3,
          distance: 1000,
          keys: [
            WeightedKey<Gitmoji>(
              name: 'toString',
              weight: 1.0,
              getter: (gitmoji) => gitmoji.toString(),
            )
          ],
        ));
    _filteredGitmojis = _sortedGitmojis;

    // Handle search text changes
    _controller.addListener(_onSearchTextChange);

    // Ensure the focus stays in search box
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _controller.removeListener(_onSearchTextChange);
    _controller.dispose();

    windowManager.removeListener(this);
  }

  void _listenToBusEvents() {
    bus
      ..on<ToggleWindowEvent>().listen((_) => _onToggleWindow())
      ..on<ExitEvent>().listen((_) => _onExit());
  }

  @override
  void onWindowBlur() {
    super.onWindowBlur();
    _focusNode.unfocus();
  }

  @override
  void onWindowFocus() {
    super.onWindowFocus();
    _focusNode.requestFocus();
    if (_controller.text.isNotEmpty) {
      _controller.selection =
          TextSelection(baseOffset: 0, extentOffset: _controller.text.length);
    }
  }

  // Bus event handlers (global shortcuts & tray icon events)

  void _onToggleWindow() async {
    if (await windowManager.isVisible()) {
      if (await windowManager.isFocused()) {
        await windowManager.hide();
      } else {
        await windowManager.focus();
      }
    } else {
      await windowManager.show();
    }
  }

  void _onExit() {
    windowManager.close();
  }

  void _onSelectPrevItem() {
    if (_selectedIndex > 0) {
      _onSelectIndex(_selectedIndex - 1);
    }
  }

  void _onSelectNextItem() {
    if (_selectedIndex < _filteredGitmojis.lastIndex) {
      _onSelectIndex(_selectedIndex + 1);
    }
  }

  void _onSelectPrevPageItem() {
    if (_selectedIndex - 5 >= 0) {
      _onSelectIndex(_selectedIndex - 5);
    } else {
      _onSelectIndex(0);
    }
  }

  void _onSelectNextPageItem() {
    if (_selectedIndex + 5 <= _filteredGitmojis.lastIndex) {
      _onSelectIndex(_selectedIndex + 5);
    } else {
      _onSelectIndex(_filteredGitmojis.lastIndex);
    }
  }

  void _onSelectFirstItem() {
    if (_filteredGitmojis.isNotEmpty) {
      _onSelectIndex(0);
    }
  }

  void _onSelectLastItem() {
    if (_filteredGitmojis.isNotEmpty) {
      _onSelectIndex(_filteredGitmojis.lastIndex);
    }
  }

  // In-app shortcut event handlers

  void _onCopySelectedCode() {
    if (_selectedIndex >= _filteredGitmojis.length) {
      return;
    }
    final gitmoji = _filteredGitmojis[_selectedIndex];
    Clipboard.setData(ClipboardData(text: gitmoji.code));
    _onHideWindow();
  }

  void _onCopySelectedEmoji() {
    if (_selectedIndex >= _filteredGitmojis.length) {
      return;
    }
    final gitmoji = _filteredGitmojis[_selectedIndex];
    Clipboard.setData(ClipboardData(text: gitmoji.emoji));
    _onHideWindow();
  }

  void _onHideWindow() {
    windowManager.hide();
  }

  // Search event handlers

  void _onSearchTextChange() {
    setState(() {
      _searchText = _controller.text;

      _onSelectIndex(0);

      _filteredGitmojis = _gitmojiFuzzy
          .search(_searchText)
          .map((result) => result.item)
          .toList();
    });
  }

  void _onSelectIndex(int index) {
    if (index < 0 || index > _filteredGitmojis.lastIndex) {
      return;
    }

    setState(() => _selectedIndex = index);
    _scrollController.scrollToIndex(
      _selectedIndex,
      duration: const Duration(microseconds: 100),
    );
  }

  // Copy related event handlers

  void _onCopyCode(Gitmoji gitmoji) {
    Clipboard.setData(ClipboardData(text: gitmoji.code));
    _showCopiedSnackBar(gitmoji.code);
  }

  void _onCopyEmoji(Gitmoji gitmoji) {
    Clipboard.setData(ClipboardData(text: gitmoji.emoji));
    _showCopiedSnackBar(gitmoji.emoji);
  }

  void _showCopiedSnackBar(String contentCopied) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Label(contentCopied, typography: Typography.caption),
              Label(
                ' copied to clipboard',
                typography: Typography.caption,
                color: ColorPalette.text.secondary,
              ),
            ],
          ),
          duration: const Duration(milliseconds: 1500),
          // animation: CurvedAnimation(),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 9),
          backgroundColor: ColorPalette.background.solid.secondary,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: ColorPalette.stroke.card.primary,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          dismissDirection: DismissDirection.none,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: _shortcuts,
      child: Actions(
        actions: _shortcutActions,
        child: Column(
          children: [
            // Search box
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextBox(
                hint: 'Search',
                prefixIcon: SymbolIcons.searchMedium,
                controller: _controller,
                focusNode: _focusNode,
              ),
            ),

            // List
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _filteredGitmojis.length,
                    itemBuilder: ((context, index) {
                      return AutoScrollTag(
                        key: ValueKey(index),
                        controller: _scrollController,
                        index: index,
                        child: GitmojiView(
                          _filteredGitmojis[index],
                          selected: index == _selectedIndex,
                          onCopyCode: _onCopyCode,
                          onCopyEmoji: _onCopyEmoji,
                        ),
                      );
                    })),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<ShortcutActivator, Intent> get _shortcuts => const {
        // Enter: copy code of selected gitmoji
        SingleActivator(LogicalKeyboardKey.enter): CopyCodeIntent(),
        // Ctrl + Enter: copy emoji of selected gitmoji
        SingleActivator(
          LogicalKeyboardKey.enter,
          control: true,
        ): CopyEmojiIntent(),
        // Up: select the previous gitmoji
        SingleActivator(LogicalKeyboardKey.arrowUp): SelectPrevIntent(),
        // Down: select the next gitmoji
        SingleActivator(LogicalKeyboardKey.arrowDown): SelectNextIntent(),
        // PageUp: scroll up one page
        SingleActivator(LogicalKeyboardKey.pageUp): SelectPrevPageIntent(),
        // PageDown: scroll down one page
        SingleActivator(LogicalKeyboardKey.pageDown): SelectNextPageIntent(),
        // Home: select the first gitmoji
        SingleActivator(LogicalKeyboardKey.home): SelectFirstIntent(),
        // End: select the last gitmoji
        SingleActivator(LogicalKeyboardKey.end): SelectLastIntent(),
        // Esc: hide window
        SingleActivator(LogicalKeyboardKey.escape): HideWindowIntent(),
      };

  Map<Type, Action<Intent>> get _shortcutActions => {
        CopyCodeIntent: CallbackAction(
          onInvoke: (_) => _onCopySelectedCode(),
        ),
        CopyEmojiIntent: CallbackAction(
          onInvoke: (_) => _onCopySelectedEmoji(),
        ),
        SelectPrevIntent: CallbackAction(
          onInvoke: (_) => _onSelectPrevItem(),
        ),
        SelectNextIntent: CallbackAction(
          onInvoke: (_) => _onSelectNextItem(),
        ),
        SelectPrevPageIntent: CallbackAction(
          onInvoke: (_) => _onSelectPrevPageItem(),
        ),
        SelectNextPageIntent: CallbackAction(
          onInvoke: (_) => _onSelectNextPageItem(),
        ),
        SelectFirstIntent: CallbackAction(
          onInvoke: (_) => _onSelectFirstItem(),
        ),
        SelectLastIntent: CallbackAction(
          onInvoke: (_) => _onSelectLastItem(),
        ),
        HideWindowIntent: CallbackAction(
          onInvoke: (_) => _onHideWindow(),
        ),
      };
}

extension GitmojiListIndexUtils on List<Gitmoji> {
  int get lastIndex => length - 1;
}
