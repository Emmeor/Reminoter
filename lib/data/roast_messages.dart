import 'dart:math';

/// Mild, harmless "cussing". Swap this for an API call if you want real AI.
const _roasts = [
  "BUDDY, are you diagnosed with ADHD?",
  "Bruh, why do you even install me in the first place?",
  "Imong mama.",
  "What the flip dewd? Diba new years resolution mo magbabago kana.",
  "Pasalamat ka wala akong katawan kasi pag nakita kita babanatan kita.",
  "Ok lang na di moko gamitin, di naman ako nagtatampo hmph.",
  "Ermmm akshully its time to use ur timers...",
  "Pag ikaw dimoko ginamit dds ka.",
  "HOY! pano ka magkakatrabaho nyan.",
  "Wee woo wee woo pag eto dimo pinansin dedelete ko sarili ko.",
];

const timerDoneMessage = "Time's up, you legend. Now do the damn thing.";

final _rng = Random();

String randomRoast() => _roasts[_rng.nextInt(_roasts.length)];
