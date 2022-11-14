// Copyright (c) 2022 Beta Kuang <beta.kuang@gmail.com>
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

import 'package:fluentmoji/gitmoji/gitmoji.dart';

class GitmojiView extends StatelessWidget {
  const GitmojiView(
    this.gitmoji, {
    super.key,
    required this.selected,
    required this.onCopyCode,
    required this.onCopyEmoji,
  });

  final Gitmoji gitmoji;
  final bool selected;
  final void Function(Gitmoji gitmoji) onCopyCode;
  final void Function(Gitmoji gitmoji) onCopyEmoji;

  @override
  Widget build(BuildContext context) {
    return Tappable(
      onTap: () {},
      borderRadius: BorderRadius.circular(6),
      color: selected
          ? ColorPalette.fill.subtle.secondary
          : ColorPalette.fill.subtle.transparent,
      hoverColor: selected
          ? ColorPalette.fill.subtle.tertiary
          : ColorPalette.fill.subtle.secondary,
      pressedColor: selected
          ? ColorPalette.fill.subtle.secondary
          : ColorPalette.fill.subtle.tertiary,
      builder: (context, state) => Container(
        constraints: const BoxConstraints(minHeight: 40),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Left part: selection indicator & emoji
              MouseRegion(
                hitTestBehavior: HitTestBehavior.opaque,
                child: Tappable(
                  onTap: () => onCopyEmoji(gitmoji),
                  borderRadius: BorderRadius.circular(6),
                  cursor: SystemMouseCursors.click,
                  hoverColor: ColorPalette.fill.subtle.secondary,
                  child: SizedBox(
                    width: 47,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Selection indicator
                        Container(
                          width: 3,
                          padding: const EdgeInsets.only(top: 14),
                          child: Container(
                            height: 16,
                            decoration: BoxDecoration(
                              color: selected
                                  ? ColorPalette.fill.accent.primary
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),

                        // Emoji
                        Expanded(
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 6),
                              child: Label(
                                gitmoji.emoji,
                                typography: Typography.title.copyWith(
                                  fontFamily: 'Segoe UI Emoji',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Right part: code & description
              Expanded(
                child: Tappable(
                  onTap: () => onCopyCode(gitmoji),
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
                          color: _getCodeColor(state),
                        ),

                        const SizedBox(height: 2),

                        // Description
                        Label(
                          gitmoji.description,
                          typography: Typography.caption,
                          color: _getDescriptionColor(state),
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

  Color _getCodeColor(TappableState state) {
    switch (state) {
      case TappableState.pressed:
        return selected
            ? ColorPalette.text.secondary
            : ColorPalette.text.secondary;
      default:
        return ColorPalette.text.primary;
    }
  }

  Color _getDescriptionColor(TappableState state) {
    switch (state) {
      case TappableState.pressed:
        return selected
            ? ColorPalette.text.tertiary
            : ColorPalette.text.tertiary;
      default:
        return ColorPalette.text.secondary;
    }
  }
}
