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

import 'package:flutter/material.dart';

// Intents for keyboard shortcuts

class CopyCodeIntent extends Intent {
  const CopyCodeIntent();
}

class CopyEmojiIntent extends Intent {
  const CopyEmojiIntent();
}

class SelectPrevIntent extends Intent {
  const SelectPrevIntent();
}

class SelectNextIntent extends Intent {
  const SelectNextIntent();
}

class SelectPrevPageIntent extends Intent {
  const SelectPrevPageIntent();
}

class SelectNextPageIntent extends Intent {
  const SelectNextPageIntent();
}

class SelectFirstIntent extends Intent {
  const SelectFirstIntent();
}

class SelectLastIntent extends Intent {
  const SelectLastIntent();
}

class HideWindowIntent extends Intent {
  const HideWindowIntent();
}
