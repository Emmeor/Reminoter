# AI usage

This project was built with AI assistance. This file is the record of it. It is
graded as the finals badge, and it is worth 100 points.

Start it in week 1 and keep it up as you go. The commit history of this file is
part of the evidence: a file written all at once the night before the deadline
looks exactly like what it is.

## 1. How I used AI

At least six entries. One per real use. Every entry needs a commit link.

### 2026-09-28 - Test

- **Tool: Claude**
- **What I asked for: Base Template of a timer with notes app**
- **What it gave back: **
- **What I kept, what I changed, and why: I didn't keep anything as its a test to see where i can start**
- **Commit: https://github.com/Emmeor/Reminoter/commit/1506ad6db08bba7b438af8047b8465118bcf90d3#diff-4fdca03c201f192aaf1392dc374796f008067863793db2824a5426bca9b20699** 

### 2026-09-30 - Testing Themes

- **Tool: Claude**
- **What I asked for: Integration of themes **
- **What it gave back: basic theme selection that are customizable **
- **What I kept, what I changed, and why: I didn't keep anything as its a test if I could put dark, light or sunset as the app's theme which later then removed and added a color picker as its replacement**
- **Commit: https://github.com/Emmeor/Reminoter/commit/ae5cbeea5221540cdbd33e8da3790123c7d939cf ** 

### 2026-10-04 - Timer Format

- **Tool: Claude**
- **What I asked for: Timer format **
- **What it gave back: Universal Timer format **
- **What I kept, what I changed, and why: I actually have no experience with app design and specially clocks but, I know a clock timer when I see one and so i kept it untouched **
- **Commit: https://github.com/Emmeor/Reminoter/commit/ebe5563f66d9a14e010163cb29f0c8ec938bcef2 ** 

### 2026-10-08 - Ringtone

- **Tool: Copilot **
- **What I asked for: A ringtone **
- **What it gave back: ringtone.wav that was created using frequencies **
- **What I kept, what I changed, and why: This is the sound that I want to have and I think in my end it's loud enough since I can still hear it when im outside and my laptop only has one speaker. **
- **Commit: https://github.com/Emmeor/Reminoter/commit/5cbfacd360b80a854c1b7f66f591e97c2aea89b0 ** 

### 2026-10-08 - ThemePickerSheet

- **Tool: Claude **
- **What I asked for: A Theme Color Picker **
- **What it gave back: A Theme color wheel picker **
- **What I kept, what I changed, and why: I kept most of it since what it gave doesn't just change all of the colors into one and instead, some elements have accent on them so it does not seem weird and will look like a real app to the feel. **
- **Commit: https://github.com/Emmeor/Reminoter/commit/5cbfacd360b80a854c1b7f66f591e97c2aea89b0 ** 



## 2. Where the AI got it wrong

Three cases. Be specific. If you write that the AI was never wrong, this section
scores zero.

### Case 1 - timer_storage.dart

- **What it gave me: A storage where it uses SharedPreferences **
- **What was wrong with it: there were no imports and the code was incomplete. **
- **What I did instead: I looked up online about how to use sharedpreferences and used what the ai gave as a template **
- **Commit: https://github.com/Emmeor/Reminoter/commit/bc06940e94087fcd254178730c284c83cb5404a1 ** 

## 3. Who wrote what

### Written by me

- **File: home_screen.dart (partial code not all) **
- **Commit: https://github.com/Emmeor/Reminoter/commit/be9c0afa47c56e23490a4e006b6abede964e8118 (I forgot to update my commits on the home screen TwT ) **
- **What it does and why it is built this way: it is to show the specific timers with specific title or note. **

- **File: timer_card.dart (partial code not all) **
- **Commit: https://github.com/Emmeor/Reminoter/commit/6649cffb3e78b973d630be68d8ed87b6c979e55e **
- **What it does and why it is built this way: It was updated to make sure that the user does not accidentally press the delete button when trying to organize the timers. **

- **File: timer_storage.dart **
- **Commit: https://github.com/Emmeor/Reminoter/commit/bc06940e94087fcd254178730c284c83cb5404a1 **
- **What it does and why it is built this way: It is built this way so the timers survive locally and is saved in order the user left them as. **

- **File: theme_storage.dart **
- **Commit: https://github.com/Emmeor/Reminoter/commit/53691c796a2082cb814e6643fd5bb6cc2127a06e **
- **What it does and why it is built this way: almost the same as timer_storage.dart they both use keys but the difference is obviously that this file stores themes. **

- **File: roast_messages.dart **
- **Commit: https://github.com/Emmeor/Reminoter/commit/7856dcd5c1ad568bf5db17277208fb60ae8ec84d **
- **What it does and why it is built this way: It is the storages of the nudge messages that comes as playful nudges with english and tagalog roasts and it is built this way so it could be used by notification_services.dart to nudge the user on a given timeframe. **

### The AI-written part I understand best

- **File: theme_controller.dart **
- **Commit: https://github.com/Emmeor/Reminoter/commit/1052968c4086b23773c62317e0da091fc5fe3554 **
- **What it does and why we kept it: It is responsible for the color of the theme and saving the theme color that the user selects. **
