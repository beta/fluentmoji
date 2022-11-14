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

import 'package:fluff/fluff.dart';
import 'package:flutter/material.dart' hide Typography;
import 'package:flutter/services.dart';

import 'package:fluentmoji/gitmoji/gitmoji.dart';
import 'package:fuzzy/fuzzy.dart';

const _appName = 'Fluentmoji';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FluffApp.init(
    useCustomWindow: true,
    showSystemTitleBar: false,
    initialSize: const Size(360, 480),
    minSize: const Size(360, 480),
    // FIXME: find a way to only allow resizing vertically
    maxSize: const Size(360, 20000),
  );

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  final _controller = TextEditingController();

  final List<Gitmoji> _sortedGitmojis = List.of(Gitmoji.all)
    ..sort((a, b) => a.code.compareTo(b.code));
  late final Fuzzy<Gitmoji> _gitmojiFuzzy;

  String _searchText = '';
  late List<Gitmoji> _filteredGitmojis;

  @override
  void initState() {
    super.initState();

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

    _controller.addListener(() {
      setState(() {
        _searchText = _controller.text;

        _filteredGitmojis = _gitmojiFuzzy
            .search(_searchText)
            .map((result) => result.item)
            .toList();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FluffApp(
      title: _appName,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            // Search
            TextBox(
              hint: 'Search your gitmoji',
              prefixIcon: SymbolIcons.searchMedium,
              controller: _controller,
            ),

            const SizedBox(height: 8),

            // List
            Expanded(
              child: ListView.builder(
                  itemCount: _filteredGitmojis.length,
                  itemBuilder: ((context, index) {
                    return GitmojiView(_filteredGitmojis[index]);
                  })),
            ),
          ],
        ),
      ),
    );
  }
}

class GitmojiView extends StatelessWidget {
  const GitmojiView(this.gitmoji, {super.key});

  final Gitmoji gitmoji;

  void onCopyCode(BuildContext context) {
    Clipboard.setData(ClipboardData(text: gitmoji.code));
    showCopiedSnackBar(context, gitmoji.code);
  }

  void onCopyEmoji(BuildContext context) {
    Clipboard.setData(ClipboardData(text: gitmoji.emoji));
    showCopiedSnackBar(context, gitmoji.emoji);
  }

  void showCopiedSnackBar(BuildContext context, String contentCopied) {
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
    return Tappable(
      onTap: () {},
      borderRadius: BorderRadius.circular(6),
      hoverColor: ColorPalette.fill.subtle.secondary,
      pressedColor: ColorPalette.fill.subtle.tertiary,
      builder: (context, state) => Container(
        constraints: const BoxConstraints(minHeight: 40),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Emoji
              Tappable(
                onTap: () => onCopyEmoji(context),
                borderRadius: BorderRadius.circular(6),
                cursor: SystemMouseCursors.click,
                hoverColor: ColorPalette.fill.subtle.secondary,
                child: Container(
                  width: 44,
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 6),
                    child: Label(gitmoji.emoji, typography: Typography.title),
                  ),
                ),
              ),

              Expanded(
                child: Tappable(
                  onTap: () => onCopyCode(context),
                  borderRadius: BorderRadius.circular(6),
                  hoverColor: ColorPalette.fill.subtle.secondary,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Code
                        Label(
                          gitmoji.code,
                          typography: Typography.body,
                          color: state == TappableState.pressed
                              ? ColorPalette.text.secondary
                              : ColorPalette.text.primary,
                        ),

                        const SizedBox(height: 2),

                        // Description
                        Label(
                          gitmoji.description,
                          typography: Typography.caption,
                          color: state == TappableState.pressed
                              ? ColorPalette.text.tertiary
                              : ColorPalette.text.secondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
