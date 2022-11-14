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

class Gitmoji {
  const Gitmoji._({
    required this.name,
    required this.emoji,
    required this.code,
    required this.description,
  });

  final String name;
  final String emoji;
  final String code;
  final String description;

  @override
  String toString() {
    return '$name $emoji $code : $description';
  }

  static const all = [
    art,
    zap,
    fire,
    bug,
    ambulance,
    sparkles,
    memo,
    rocket,
    lipstick,
    tada,
    whiteCheckMark,
    lock_,
    closedLockWithKey,
    bookmark,
    rotatingLight,
    construction,
    greenHeart,
    arrowDown,
    arrowUp,
    pushpin,
    constructionWorker,
    chartWithUpwardsTrend,
    recycle,
    heavyPlusSign,
    heavyMinusSign,
    wrench,
    hammer,
    globeWithMeridians,
    pencil2,
    poop,
    rewind,
    twistedRightwardsArrows,
    package,
    alien,
    truck,
    pageFacingUp,
    boom,
    bento,
    wheelchair,
    bulb,
    beers,
    speechBalloon,
    cardFileBox,
    loudSound,
    mute,
    bustsInSilhouette,
    childrenCrossing,
    buildingConstruction,
    iphone,
    clownFace,
    egg,
    seeNoEvil,
    cameraFlash,
    alembic,
    mag,
    label,
    seedling,
    triangularFlagOnPost,
    goalNet,
    animation,
    wastebasket,
    passportControl,
    adhesiveBandage,
    monocleFace,
    coffin,
    testTube,
    necktie,
    stethoscope,
    bricks,
    technologist,
    moneyWithWings,
    thread,
    safetyVest,
  ];

  static const art = Gitmoji._(
    name: 'art',
    emoji: '🎨',
    code: ':art:',
    description: 'Improve structure / format of the code.',
  );
  static const zap = Gitmoji._(
    name: 'zap',
    emoji: '⚡️',
    code: ':zap:',
    description: 'Improve performance.',
  );
  static const fire = Gitmoji._(
    name: 'fire',
    emoji: '🔥',
    code: ':fire:',
    description: 'Remove code or files.',
  );
  static const bug = Gitmoji._(
    name: 'bug',
    emoji: '🐛',
    code: ':bug:',
    description: 'Fix a bug.',
  );
  static const ambulance = Gitmoji._(
    name: 'ambulance',
    emoji: '🚑️',
    code: ':ambulance:',
    description: 'Critical hotfix.',
  );
  static const sparkles = Gitmoji._(
    name: 'sparkles',
    emoji: '✨',
    code: ':sparkles:',
    description: 'Introduce new features.',
  );
  static const memo = Gitmoji._(
    name: 'memo',
    emoji: '📝',
    code: ':memo:',
    description: 'Add or update documentation.',
  );
  static const rocket = Gitmoji._(
    name: 'rocket',
    emoji: '🚀',
    code: ':rocket:',
    description: 'Deploy stuff.',
  );
  static const lipstick = Gitmoji._(
    name: 'lipstick',
    emoji: '💄',
    code: ':lipstick:',
    description: 'Add or update the UI and style files.',
  );
  static const tada = Gitmoji._(
    name: 'tada',
    emoji: '🎉',
    code: ':tada:',
    description: 'Begin a project.',
  );
  static const whiteCheckMark = Gitmoji._(
    name: 'white-check-mark',
    emoji: '✅',
    code: ':white_check_mark:',
    description: 'Add, update, or pass tests.',
  );
  static const lock_ = Gitmoji._(
    name: 'lock',
    emoji: '🔒️',
    code: ':lock:',
    description: 'Fix security issues.',
  );
  static const closedLockWithKey = Gitmoji._(
    name: 'closed-lock-with-key',
    emoji: '🔐',
    code: ':closed_lock_with_key:',
    description: 'Add or update secrets.',
  );
  static const bookmark = Gitmoji._(
    name: 'bookmark',
    emoji: '🔖',
    code: ':bookmark:',
    description: 'Release / Version tags.',
  );
  static const rotatingLight = Gitmoji._(
    name: 'rotating-light',
    emoji: '🚨',
    code: ':rotating_light:',
    description: 'Fix compiler / linter warnings.',
  );
  static const construction = Gitmoji._(
    name: 'construction',
    emoji: '🚧',
    code: ':construction:',
    description: 'Work in progress.',
  );
  static const greenHeart = Gitmoji._(
    name: 'green-heart',
    emoji: '💚',
    code: ':green_heart:',
    description: 'Fix CI Build.',
  );
  static const arrowDown = Gitmoji._(
    name: 'arrow-down',
    emoji: '⬇️',
    code: ':arrow_down:',
    description: 'Downgrade dependencies.',
  );
  static const arrowUp = Gitmoji._(
    name: 'arrow-up',
    emoji: '⬆️',
    code: ':arrow_up:',
    description: 'Upgrade dependencies.',
  );
  static const pushpin = Gitmoji._(
    name: 'pushpin',
    emoji: '📌',
    code: ':pushpin:',
    description: 'Pin dependencies to specific versions.',
  );
  static const constructionWorker = Gitmoji._(
    name: 'construction-worker',
    emoji: '👷',
    code: ':construction_worker:',
    description: 'Add or update CI build system.',
  );
  static const chartWithUpwardsTrend = Gitmoji._(
    name: 'chart-with-upwards-trend',
    emoji: '📈',
    code: ':chart_with_upwards_trend:',
    description: 'Add or update analytics or track code.',
  );
  static const recycle = Gitmoji._(
    name: 'recycle',
    emoji: '♻️',
    code: ':recycle:',
    description: 'Refactor code.',
  );
  static const heavyPlusSign = Gitmoji._(
    name: 'heavy-plus-sign',
    emoji: '➕',
    code: ':heavy_plus_sign:',
    description: 'Add a dependency.',
  );
  static const heavyMinusSign = Gitmoji._(
    name: 'heavy-minus-sign',
    emoji: '➖',
    code: ':heavy_minus_sign:',
    description: 'Remove a dependency.',
  );
  static const wrench = Gitmoji._(
    name: 'wrench',
    emoji: '🔧',
    code: ':wrench:',
    description: 'Add or update configuration files.',
  );
  static const hammer = Gitmoji._(
    name: 'hammer',
    emoji: '🔨',
    code: ':hammer:',
    description: 'Add or update development scripts.',
  );
  static const globeWithMeridians = Gitmoji._(
    name: 'globe-with-meridians',
    emoji: '🌐',
    code: ':globe_with_meridians:',
    description: 'Internationalization and localization.',
  );
  static const pencil2 = Gitmoji._(
    name: 'pencil2',
    emoji: '✏️',
    code: ':pencil2:',
    description: 'Fix typos.',
  );
  static const poop = Gitmoji._(
    name: 'poop',
    emoji: '💩',
    code: ':poop:',
    description: 'Write bad code that needs to be improved.',
  );
  static const rewind = Gitmoji._(
    name: 'rewind',
    emoji: '⏪️',
    code: ':rewind:',
    description: 'Revert changes.',
  );
  static const twistedRightwardsArrows = Gitmoji._(
    name: 'twisted-rightwards-arrows',
    emoji: '🔀',
    code: ':twisted_rightwards_arrows:',
    description: 'Merge branches.',
  );
  static const package = Gitmoji._(
    name: 'package',
    emoji: '📦️',
    code: ':package:',
    description: 'Add or update compiled files or packages.',
  );
  static const alien = Gitmoji._(
    name: 'alien',
    emoji: '👽️',
    code: ':alien:',
    description: 'Update code due to external API changes.',
  );
  static const truck = Gitmoji._(
    name: 'truck',
    emoji: '🚚',
    code: ':truck:',
    description: 'Move or rename resources (e.g.: files, paths, routes).',
  );
  static const pageFacingUp = Gitmoji._(
    name: 'page-facing-up',
    emoji: '📄',
    code: ':page_facing_up:',
    description: 'Add or update license.',
  );
  static const boom = Gitmoji._(
    name: 'boom',
    emoji: '💥',
    code: ':boom:',
    description: 'Introduce breaking changes.',
  );
  static const bento = Gitmoji._(
    name: 'bento',
    emoji: '🍱',
    code: ':bento:',
    description: 'Add or update assets.',
  );
  static const wheelchair = Gitmoji._(
    name: 'wheelchair',
    emoji: '♿️',
    code: ':wheelchair:',
    description: 'Improve accessibility.',
  );
  static const bulb = Gitmoji._(
    name: 'bulb',
    emoji: '💡',
    code: ':bulb:',
    description: 'Add or update comments in source code.',
  );
  static const beers = Gitmoji._(
    name: 'beers',
    emoji: '🍻',
    code: ':beers:',
    description: 'Write code drunkenly.',
  );
  static const speechBalloon = Gitmoji._(
    name: 'speech-balloon',
    emoji: '💬',
    code: ':speech_balloon:',
    description: 'Add or update text and literals.',
  );
  static const cardFileBox = Gitmoji._(
    name: 'card-file-box',
    emoji: '🗃️',
    code: ':card_file_box:',
    description: 'Perform database related changes.',
  );
  static const loudSound = Gitmoji._(
    name: 'loud-sound',
    emoji: '🔊',
    code: ':loud_sound:',
    description: 'Add or update logs.',
  );
  static const mute = Gitmoji._(
    name: 'mute',
    emoji: '🔇',
    code: ':mute:',
    description: 'Remove logs.',
  );
  static const bustsInSilhouette = Gitmoji._(
    name: 'busts-in-silhouette',
    emoji: '👥',
    code: ':busts_in_silhouette:',
    description: 'Add or update contributor(s).',
  );
  static const childrenCrossing = Gitmoji._(
    name: 'children-crossing',
    emoji: '🚸',
    code: ':children_crossing:',
    description: 'Improve user experience / usability.',
  );
  static const buildingConstruction = Gitmoji._(
    name: 'building-construction',
    emoji: '🏗️',
    code: ':building_construction:',
    description: 'Make architectural changes.',
  );
  static const iphone = Gitmoji._(
    name: 'iphone',
    emoji: '📱',
    code: ':iphone:',
    description: 'Work on responsive design.',
  );
  static const clownFace = Gitmoji._(
    name: 'clown-face',
    emoji: '🤡',
    code: ':clown_face:',
    description: 'Mock things.',
  );
  static const egg = Gitmoji._(
    name: 'egg',
    emoji: '🥚',
    code: ':egg:',
    description: 'Add or update an easter egg.',
  );
  static const seeNoEvil = Gitmoji._(
    name: 'see-no-evil',
    emoji: '🙈',
    code: ':see_no_evil:',
    description: 'Add or update a .gitignore file.',
  );
  static const cameraFlash = Gitmoji._(
    name: 'camera-flash',
    emoji: '📸',
    code: ':camera_flash:',
    description: 'Add or update snapshots.',
  );
  static const alembic = Gitmoji._(
    name: 'alembic',
    emoji: '⚗️',
    code: ':alembic:',
    description: 'Perform experiments.',
  );
  static const mag = Gitmoji._(
    name: 'mag',
    emoji: '🔍️',
    code: ':mag:',
    description: 'Improve SEO.',
  );
  static const label = Gitmoji._(
    name: 'label',
    emoji: '🏷️',
    code: ':label:',
    description: 'Add or update types.',
  );
  static const seedling = Gitmoji._(
    name: 'seedling',
    emoji: '🌱',
    code: ':seedling:',
    description: 'Add or update seed files.',
  );
  static const triangularFlagOnPost = Gitmoji._(
    name: 'triangular-flag-on-post',
    emoji: '🚩',
    code: ':triangular_flag_on_post:',
    description: 'Add, update, or remove feature flags.',
  );
  static const goalNet = Gitmoji._(
    name: 'goal-net',
    emoji: '🥅',
    code: ':goal_net:',
    description: 'Catch errors.',
  );
  static const animation = Gitmoji._(
    name: 'animation',
    emoji: '💫',
    code: ':dizzy:',
    description: 'Add or update animations and transitions.',
  );
  static const wastebasket = Gitmoji._(
    name: 'wastebasket',
    emoji: '🗑️',
    code: ':wastebasket:',
    description: 'Deprecate code that needs to be cleaned up.',
  );
  static const passportControl = Gitmoji._(
    name: 'passport-control',
    emoji: '🛂',
    code: ':passport_control:',
    description:
        'Work on code related to authorization, roles and permissions.',
  );
  static const adhesiveBandage = Gitmoji._(
    name: 'adhesive-bandage',
    emoji: '🩹',
    code: ':adhesive_bandage:',
    description: 'Simple fix for a non-critical issue.',
  );
  static const monocleFace = Gitmoji._(
    name: 'monocle-face',
    emoji: '🧐',
    code: ':monocle_face:',
    description: 'Data exploration/inspection.',
  );
  static const coffin = Gitmoji._(
    name: 'coffin',
    emoji: '⚰️',
    code: ':coffin:',
    description: 'Remove dead code.',
  );
  static const testTube = Gitmoji._(
    name: 'test-tube',
    emoji: '🧪',
    code: ':test_tube:',
    description: 'Add a failing test.',
  );
  static const necktie = Gitmoji._(
    name: 'necktie',
    emoji: '👔',
    code: ':necktie:',
    description: 'Add or update business logic',
  );
  static const stethoscope = Gitmoji._(
    name: 'stethoscope',
    emoji: '🩺',
    code: ':stethoscope:',
    description: 'Add or update healthcheck.',
  );
  static const bricks = Gitmoji._(
    name: 'bricks',
    emoji: '🧱',
    code: ':bricks:',
    description: 'Infrastructure related changes.',
  );
  static const technologist = Gitmoji._(
    name: 'technologist',
    emoji: '🧑‍💻',
    code: ':technologist:',
    description: 'Improve developer experience',
  );
  static const moneyWithWings = Gitmoji._(
    name: 'money-with-wings',
    emoji: '💸',
    code: ':money_with_wings:',
    description: 'Add sponsorships or money related infrastructure.',
  );
  static const thread = Gitmoji._(
    name: 'thread',
    emoji: '🧵',
    code: ':thread:',
    description: 'Add or update code related to multithreading or concurrency.',
  );
  static const safetyVest = Gitmoji._(
    name: 'safety-vest',
    emoji: '🦺',
    code: ':safety_vest:',
    description: 'Add or update code related to validation.',
  );
}
