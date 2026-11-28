# Silver Mirror (Mikeagan Mod) — Changelog

Full version history for custom changes built on *Pokémon Silver Mirror*. For a complete list of current features, see [README_MOD.md](README_MOD.md).

---

### Mod Version 26 (Base: SM 1.2.2) — 2026-11-28
* **Dynamic Title Screen Version Display (`engine/movie/title.asm`):** Rendered `M.{GAME_VERSION}` directly onto the top-left corner of the Title Screen via custom 1bpp font tiles in VRAM Bank 1, reverting `gfx/title/logo.png` to vanilla upstream so future upstream version bumps never cause binary merge conflicts.
* **Build Automation & Documentation Split (`Makefile`, `version.asm`, `README.md`, `README_MOD.md`, `CHANGELOG_MOD.md`):**
  * Fixed `sed` and `awk` string extraction in `Makefile` (`SM_VER`, `MOD_VER`, `make bump`, and `make upstream`) to match unescaped `EQUS` syntax in `version.asm`.
  * Updated `make bump` to automatically sync the version banner in `README_MOD.md` and prepend a new dated release heading into `CHANGELOG_MOD.md` on every bump.
  * Restored upstream `README.md` with a top-level link to `README_MOD.md`, and separated the project documentation into `README_MOD.md` (current feature guide) and `CHANGELOG_MOD.md` (full sequential release history).


### Mod Version 25 (Base: SM 1.2.2)
* **Wild Held Item Drops (`engine/battle/core.asm`, `engine/pokemon/health.asm`):** Added `DropWildMonHeldItem` inside `HandleEnemyMonFaint` (moved to `engine/pokemon/health.asm` and invoked via `farcall` to keep `Battle Core` within bank limits) so defeated wild Pokémon automatically drop their held item (`[wEnemyMonItem]`) directly into the player's bag with a pickup fanfare (`SFX_ITEM`) and confirmation message (`<PLAYER> found [Item]!`), safely skipping if the bag is full.
* **Build Pipeline & Documentation Cleanup (`Makefile`, `version.asm`, `README.md`, `MOD_CHANGES.md`):** Fixed shell line-continuation syntax in the `Makefile` BPS patch recipe, refined version parsing, and organized custom mod features into dedicated documentation.

### Mod Version 24 (Base: SM 1.2.2)
* **Dual-Target BPS Patching & Version Automation (`Makefile`):**
  * Added automated `.bps` patch generation for both **Crystal 1.0** (`baserom_crystal10.gbc` → `*.1.0.bps`) and **Crystal 1.1** (`baserom_crystal11.gbc` → `*.1.1.bps`), checking that both the base ROMs and `tools/flips.exe` are present before patching.
  * Added `make bump` (to increment `GAME_VERSION` and sync documentation) and `make upstream VER=X.Y.Z` (to update `SM_GAME_VERSION` when merging upstream releases) directly into the build workflow.

### Mod Version 23 (Base: SM 1.2.2)
* **Automated Versioned ROM & BPS Build Pipeline (`Makefile`, `version.asm`, `.gitignore`):**
  * Split `version.asm` into separate `SM_GAME_VERSION` and `GAME_VERSION` constants so the `Makefile` dynamically generates versioned outputs (`Pokemon Silver Mirror <SM>.M.<MOD>.gbc` and `.bps` via `flips.exe` against `baserom_crystal11.gbc`).
  * Added `*.bps` to `.gitignore` and updated `make tidy` to clean up generated `Pokemon Silver Mirror *.gbc` and `.bps` artifacts.
* **Dual Base & Mod Version Display (`engine/menus/main_menu.asm`, `data/text/common_3.asm`):** Updated both the Main Menu and the Save confirmation prompt (`_WouldYouLikeToSaveTheGameText`) to display `S.MIRROR:{SM_GAME_VERSION}` alongside `MIKEAGAN:{GAME_VERSION}`.

### Mod Version 22 (Base: SM 1.2.2)
* **Title Screen Logo Streamlined (`gfx/title/logo.png`):** Updated the title screen version banner to simply display **`1.2.1.M`** now that the Main Menu and Save confirmation screen render the full `M.VERSION` dynamically.
* **Oak's Lab Aide DV Perfection & Flow Polish (`maps/OaksLab.asm`):**
  * Added `CheckHasLowDVsAsm` to inspect all five DVs (including derived HP DV) before prompting, skipping the low-DV reroll confirmation when stats are already `>= 10`.
  * Added `CheckAlreadyMaxDVsAsm` and `MaxSelectedMonDVsAsm` so Pokémon with solid DVs (`>= 10`)—including ones just boosted by a reroll—are immediately offered the option to maximize all DVs to **15** (`$ff/$ff`).
  * Added an empty-party safety check (`OaksAssistant2NoPokemonText`), peak-DV check dialogue (`OaksAssistant2AlreadyMaxedText`), and clear confirmation warnings noting that maximizing DVs sets **Hidden Power** to **Dark** and makes the Pokémon **Shiny** (and **Female** if able).

### Mod Version 21 (Base: SM 1.2.2)
* **In-Game Version & Author Display (`version.asm`, `includes.asm`, `engine/menus/main_menu.asm`, `data/text/common_3.asm`, `gfx/title/logo.png`):**
  * Created `version.asm` (globally included via `includes.asm`) defining `GAME_VERSION` to track the mod build number.
  * Rendered `MOD BY MIKEAGAN` and `{GAME_VERSION}` on the Main Menu above the clock box, replaced the Save confirmation prompt's opening line with `{GAME_VERSION}`, and updated the title logo graphic.

### Mod Version 20 (Base: SM 1.2.2)
* **Oak's Lab Aide DV Reroll & Perfection (`maps/OaksLab.asm`, `engine/pokemon/party_menu.asm`, `engine/pokemon/health.asm`):**
  * Updated Oak's Lab Aide (`OaksLabScientist2Script`) to evaluate a selected party Pokémon's DVs, rerolling any DV under **10** up to **10–15** and offering to maximize all DVs to **15** if its stats are already strong.
  * Exported `SelectMonFromParty::` (`engine/pokemon/party_menu.asm`) and `HealPartyMon::` (`engine/pokemon/health.asm`) so the script can invoke the party selection menu and immediately recalculate stats and restore the Pokémon cleanly after DV modification.

### Mod Version 19 (Base: SM 1.2.2)
* **Upstream Merge:** Updated base codebase to *Pokémon Silver Mirror* **1.2.2**.
* **Pokérus Trigger Moved to Battle Start (`engine/battle/core.asm`, `engine/pokemon/health.asm`):**
  * Moved `CheckNuggetPokerusOnBattleStart` into `engine/pokemon/health.asm` and invoked it via `farcall` in `DoBattle` to conserve space in the `Battle Core` section.
  * Grants non-Egg party Pokémon holding a **Nugget** a **~10% chance** of contracting active Pokérus upon entering battle (preserving existing Pokérus or Booster Chip flags).
  * Removed the previous **25% chance** Nugget Pokérus trigger from `HealParty`.
* **EXP. SHARE & EXP. ALL Redistribution (`maps/MountMoonPokecenter1F.asm`, `maps/Route2Gate.asm`, `maps/OaksLab.asm`):**
  * **Mt. Moon Pokémon Center 1F:** The Gentleman now reacts with shock after you purchase the **¥500 Magikarp** and gifts **EXP. SHARE** out of pity to help train it (plus added a readable Team Rocket newspaper `bg_event` on the table).
  * **Route 2 Gate:** Professor Oak's Aide now awards **EXP. ALL** instead of **EXP. SHARE** (combined with his Pikachu Flash dialogue).
  * **Oak's Lab:** Removed **EXP. ALL** and Oak's reminder dialogue from Pallet Town.

### Mod Version 18 (Base: SM 1.2.1)
* **Fighting Dojo Gift Pokémon Overhaul (`maps/FightingDojo.asm`):**
  * Removed the single-choice restriction on the dojo Poké Balls so the player can obtain **both Hitmonlee and Hitmonchan** immediately after defeating the Karate Master (`"If you would like, please, take them."`).
  * Updated the Karate Master's post-rematch reward so he offers a **Lv. 30 Hitmontop** directly (with a `yesorno` prompt and party space check) instead of unlocking the second floor Poké Ball.

### Mod Version 17 (Base: SM 1.2.1)
* **Dual Registered Key Items (`engine/items/pack.asm`, `engine/menus/menu_2.asm`, `engine/overworld/events.asm`, `engine/overworld/select_menu.asm`, `ram/wram.asm`, `data/text/common_2.asm`):**
  * Expanded the Key Item registration menu to support two simultaneous quick-use slots: **Tap `SELECT`** (`TAP.SEL`) for the primary item and **Hold `SELECT`** (`HOLD.SEL`) for the secondary item.
  * Added toggle logic and `_UnregisteredItemText` so selecting `TAP.SEL` or `HOLD.SEL` on an already-registered item unregisters it cleanly.

### Mod Version 16 (Base: SM 1.2.1)
* **Upgraded Itemfinder (`engine/events/itemfinder.asm`, `engine/events/checkforhiddenitems.asm`):** Updated the Itemfinder so the player automatically turns toward the direction of a nearby hidden item (and spins in place twice when standing directly on top of it).
* **Celadon Cafe Hidden Item (`maps/CeladonCafe.asm`, `constants/event_flags.asm`):** Added a hidden **Leftovers** (`EVENT_CELADON_CAFE_HIDDEN_LEFTOVERS`) in the Celadon Cafe.
* **Pokémon Center Healing QoL (`engine/events/std_scripts.asm`):** Updated the Nurse Joy healing script so the player automatically turns downward away from the counter after healing.
* **Viridian Forest Sign Typo Fix (`maps/ViridianForest.asm`):** Fixed a typo in `ViridianForestTrainerTips3Text` (`"Cnly catch wild"` → `"Only catch wild"`).

### Mod Version 15 (Base: SM 1.2.1)
* **Booster Chip Bitflag Fix & UI Indicator (`engine/battle/core.asm`, `engine/items/item_effects.asm`, `engine/pokemon/stats_screen.asm`):**
  * Moved the permanent **Booster Chip** flag from bit 6 of `MON_CAUGHTDATA + 1` to **bit 3 of `MON_POKERUS`** to prevent collisions with caught gender, ball IDs, and landmark data that caused false positives on non-boosted Pokémon.
  * Added `.PlaceExpBoostMarker` to the summary screen's Pink Page (`LoadPinkPage`) to display an upward triangle (**`▲`**) next to `EXP.POINTS` whenever a Pokémon is traded or has a Booster Chip active.

### Mod Version 14 (Base: SM 1.2.1)
* **EXP. SHARE Unsplit Active EXP (`engine/battle/core.asm`):** Updated experience distribution so active battle participants receive **100% unsplit EXP** even when a party member is holding **EXP. SHARE** (which continues to grant **50% EXP** to the holder).
* **Booster Chip Item (`constants/item_constants.asm`, `data/items/*`, `engine/items/item_effects.asm`, `engine/battle/core.asm`):**
  * Added the **Booster Chip** (`BOOSTER_CHIP`), a permanent consumable item that grants a non-traded Pokémon the **1.5x traded EXP boost** without trade obedience penalties.
  * Added **Booster Chip** to **Celadon Dept. Store 5F** (`MartVitamins1`) for **¥980**.

### Mod Version 13 (Base: SM 1.2.1)
* **EXP. ALL Key Item (`engine/battle/core.asm`, `engine/items/item_effects.asm`, `maps/OaksLab.asm`, `constants/item_constants.asm`, `constants/event_flags.asm`, `data/items/*`, `data/text/*`):**
  * Added a toggleable **EXP. ALL** key item (`EVENT_EXP_ALL_ACTIVE` / `EVENT_GOT_EXP_ALL`) that grants **100% unsplit EXP** to active battle participants and **50% EXP** to benched party members (alongside a single consolidated party EXP battle message).
  * Awarded by Professor Oak's Aide in **Oak's Lab** (with reminder dialogue from Oak until obtained).

### Mod Version 12 (Base: SM 1.2.1)
* **Upstream Merge:** Updated base codebase to *Pokémon Silver Mirror* **1.2.1**.
* **EXP Boost Option (`engine/menus/options_menu.asm`, `engine/battle/core.asm`, `constants/wram_constants.asm`, `constants/event_flags.asm`):** Added an **EXP Boost (`ON` / `OFF`)** toggle to the in-game Options menu (using bit 3 of `wOptions2`) that doubles all battle experience points earned when enabled.

### Mod Version 11 (Base: SM 1.2.0)
* **Mr. Psychic Hidden Power Evaluation Enabled (`engine/events/specials.asm`, `data/text/common_2.asm`):**
  * Fixed the string buffer collision by migrating the Hidden Power type lookup from `wStringBuffer2` to `wStringBuffer4` (`GetHiddenPowerTypeToBuffer4`) with an explicit `@`-terminated copy loop and adding the missing `@` terminator to `_MeditationHiddenPowerText`.
  * Re-enabled Screen 3 in `MrPsychic` so he now reads **DVs**, **Stat EXP**, and **Hidden Power type** sequentially, and commented out unused legacy meditation text pointers.
* **Lavender Mart NPC Hint (`maps/LavenderMart.asm`):** Updated the Cooltrainer's dialogue (`LavenderMartCooltrainerMText`) to hint that giving a **Nugget** to a Pokémon can infect it with **Pokérus**.

### Mod Version 10 (Base: SM 1.2.0)
* **Mr. Psychic Stat EXP Window & Alignment Fixes (`engine/events/specials.asm`, `engine/pokemon/mon_stats.asm`):**
  * Shifted the `hlcoord` Y-positions up by 1 row (`Y = 2, 4, 6, 8, 10`) in `PrintTempMonStatExp` so all five Stat EXP values align properly with their labels (`HP`, `ATK`, `DEF`, `SPD`, `SPC`).
  * Added missing `WaitButton` pauses and `CloseText` cleanup around `PrintTempMonStatExp` so the Stat EXP window renders and clears without overlapping text boxes.
* **Hidden Power Evaluation Groundwork (`engine/events/specials.asm`, `data/text/common_2.asm`):** Added `GetHiddenPowerTypeToBuffer2` (decoding Attack and Defense DVs into all 16 Hidden Power type names into `wStringBuffer2`) and updated `_MeditationHiddenPowerText` to format `[Pokémon]'s hidden power is [Type]!` (hooked into `MrPsychic` as Screen 3, temporarily commented out while finalizing).

### Mod Version 9 (Base: SM 1.2.0)
* **Upstream Merge:** Updated base codebase to *Pokémon Silver Mirror* **1.2.0**.
* **Item Price Rebalance (`data/items/attributes.asm`):** Reduced shop prices by 90% (1/10th cost) across standard Poké Balls, Vitamins, Rare Candies, and PP Ups:
  * **Poké Ball / Great Ball / Ultra Ball:** Lowered from **¥200 / ¥600 / ¥1,200** to **¥20 / ¥60 / ¥120**.
  * **Vitamins (`HP Up`, `Protein`, `Iron`, `Carbos`, `Calcium`) & `PP Up`:** Lowered from **¥9,800** to **¥980**.
  * **Rare Candy:** Lowered from **¥4,800** to **¥480**.
* **Buena's Password Prizes (`data/items/buena_prizes.asm`):** Lowered point costs across the entire prize list:
  * **Ultra Ball, Full Restore, & Rare Candy:** Reduced from **2–3 points** to **1 point**.
  * **PP Up & Vitamins (`Protein`, `Iron`, `Carbos`, `Calcium`, `HP Up`):** Reduced from **3–5 points** to **2 points**.
* **Poké Ball Multiplier Overhaul & Bug Fixes (`engine/items/item_effects.asm`, `data/items/descriptions.asm`):**
  * **Catch Formula Fixes:** Replaced the single-pass HP division with `.shift_loop` to prevent overflow on wild Pokémon with >341 Max HP, and fixed a missing `jp .return_from_capture` when sending caught Pokémon to Bill's PC so captures no longer fall through into Bug Contest logic.
  * **Standard & Special Balls:** Increased **Great Ball** to **2x**, **Ultra Ball** to **4x**, and **Safari / Park Balls** to **8x**.
  * **8x Type-Specific Kurt's Balls (+200 Friendship):** Updated all seven Apricorn Balls to apply an **8x catch rate** on matching types and set captured Pokémon friendship to **200** (both in party and PC storage):
    * **Heavy Ball:** **Ground**, **Rock**, **Steel**
    * **Level Ball:** **Flying**, **Ice**
    * **Net Ball:** **Water**, **Bug**
    * **Fast Ball:** **Electric**, **Fighting**
    * **Friend Ball:** **Grass**, **Normal**
    * **Dusk Ball:** **Dark**, **Ghost**, **Poison**
    * **Love Ball:** **Dragon**, **Fire**, **Psychic**
* **Vitamin & PP Up Buffs (`engine/items/item_effects.asm`, `data/text/common_3.asm`):**
  * **Vitamins:** Raised the Stat EXP cap per stat from **100** to **200** and doubled the gain per vitamin from **+10** to **+20**.
  * **PP Up:** Reworked `RestorePPEffect` to function like a **PP Max**, applying all 3 PP Ups (`or $c0`) in a single use, fixing the usability check for partially boosted moves, and updating `_PPsIncreasedText` to `"maxed out!"`.
* **Goldenrod Underground Bargain Shop (`maps/GoldenrodUnderground.asm`):** Changed the Bargain Shop schedule from morning-only on select weekdays to **every night (`NITE`) across all 7 days of the week**.
* **Stone Evolution Level-Up Learnsets (`data/pokemon/evos_attacks.asm`):** Added full post-evolution level-up movesets to stone-evolving Pokémon (**Raichu**, **Nidoqueen**, **Nidoking**, **Clefable**, **Ninetales**, **Wigglytuff**, **Vileplume**, **Arcanine**, **Poliwrath**, **Victreebel**, **Cloyster**, **Exeggutor**, **Starmie**, **Bellossom**, and **Honchkrow**) so evolving early no longer locks them out of pre-evolution moves.
* **Abra, Magikarp & Gyarados Learnsets (`data/pokemon/evos_attacks.asm`, `data/pokemon/base_stats/magikarp.asm`):**
  * **Abra:** Added **Kinesis** at level **8** and **Disable** at level **10**.
  * **Magikarp:** Reworked learnset to **Splash** (Lv. 1), **Flail** (Lv. 5), **Tackle** (Lv. 10), **Water Gun** (Lv. 15), and **Bounce** (Lv. 19), plus enabled **Water Gun** via TM compatibility.
  * **Gyarados:** Added **Bounce** at level **50** (and added **Thrash** move to level **21**).
* **Stats Screen Happiness Display (`engine/pokemon/stats_screen.asm`):** Added `StatsScreen_PrintHappiness` to the Blue Page (`LoadBluePage`) to display a heart icon alongside the Pokémon's exact friendship value out of **`/255`**.
* **Mr. Psychic Stat EXP & Hidden Power Evaluation (`engine/events/specials.asm`, `engine/pokemon/mon_stats.asm`, `data/predef_pointers.asm`, `data/text/common_2.asm`):**
  * Implemented `PrintTempMonStatExp` to render a full-width window displaying all 5 **Stat EXP** values (`HP`, `ATK`, `DEF`, `SPD`, `SPC`) out of `/65535`, wired into Mr. Psychic's second evaluation screen.
  * Refactored `RevealHiddenPower` to calculate and display a party Pokémon's **Hidden Power** type and base power (`HiddenPower_StringBuffer1`), with egg validation and cleaned-up dialogue flow.
* **Pokérus Healing Trigger (`engine/pokemon/health.asm`):** Hooked `HealParty` so uninfected party Pokémon holding a **Nugget** have a **25% chance** of contracting active Pokérus (`$11`) when healed (keeping the Nugget intact).

### Mod Version 8 (Base: SM 1.1.0)
* **7-Badge Poké Ball Mart Tier (`MART_BALLS_SEVEN` / `MartBallsSeven`):** Added a new 7-badge Poké Ball mart tier and registered it in the `Marts` pointer table (`data/items/marts.asm`), moving **Master Ball** from the 5-badge tier (`MartBallsFive`) to the 7-badge tier.
* **8-Badge Medicine Mart Tier (`MART_MED_EIGHT` / `MartMedEight`):** Added a new 8-badge medicine mart tier in `data/items/marts.asm` stocking **Max Revive** and **Full Restore** alongside standard healing items.
* **Updated Mart Locations (`maps/*Mart.asm`, `CeladonDeptStore2F.asm`, `GoldenrodDeptStore2F.asm`):** Wired both new badge tiers into **Cherrygrove**, **Violet**, **Azalea**, **Goldenrod (2F)**, **Ecruteak**, **Olivine**, **Blackthorn**, **Viridian**, **Pewter**, **Cerulean**, **Vermilion**, **Lavender**, **Celadon (2F)**, **Saffron**, **Fuchsia**, and **Cinnabar** Marts.
* **Silph Co. 11F (`maps/SilphCo11F.asm`):** Updated the Silph Co. President to gift **5 Master Balls** (up from **1**) and tweaked his dialogue (`"You can't buy that anywhere YET!"`) to fit the new 7-badge mart availability.

### Mod Version 7 (Base: SM 1.1.0)
* **Pokégear Phone:** Expanded contact storage capacity to **50** phone numbers, allowing the player to register every contact in the game without deleting existing entries.

### Mod Version 6 (Base: SM 1.1.0)
* **Celadon Dept. Store 4F (`MartEvolution1`):** Expanded the evolution shop from **8** to **11** items by adding **Metal Coat**, **Dragon Scale**, and **Linking Cord**.

### Mod Version 5 (Base: SM 1.1.0)
* **Starter Pokémon (`maps/OaksLab.asm`):** Equipped all six starter Pokémon (**Charmander**, **Cyndaquil**, **Squirtle**, **Totodile**, **Bulbasaur**, and **Chikorita**) with a held **Oran Berry** upon receipt.

### Mod Version 4 (Base: SM 1.1.0)
* **Fruit & Apricorn Trees (`maps/*.asm`):** Increased harvest yields across Johto and Kanto routes to **5** items per tree (up from **1** for Apricorns and **2** for Berries).

### Mod Version 3 (Base: SM 1.1.0)
* **Kurt's Poké Balls (`data/items/attributes.asm`):** Increased shop price from **¥500** to **¥1,000** for all seven custom Apricorn Balls (**Heavy Ball**, **Level Ball**, **Net Ball** / `LURE_BALL`, **Fast Ball**, **Friend Ball**, **Dusk Ball** / `MOON_BALL`, and **Love Ball**).

### Mod Version 2 (Base: SM 1.1.0)
* **Caterpie (`CaterpieEvosAttacks`):** Lowered **Bug Bite** learnset level from **15** to **9**.
* **Weedle (`WeedleEvosAttacks`):** Lowered **Bug Bite** learnset level from **15** to **9**.
* **Butterfree (`ButterfreeEvosAttacks`):** Added **Bug Bite** at level **28** (replacing the duplicate **Silver Wind** entry).

### Mod Version 1 (Base: SM 1.1.0)
* **5-Badge Poké Mart (`MartBallsFive`):** Added **Master Ball** to standard Poké Marts after earning 5 badges.
* **Celadon Dept. Store 4F (`MartEvolution1`):** Added **Sun Stone** and **Moon Stone** to the evolution items shop.
* **Celadon Dept. Store 5F (`MartVitamins1`):** Added **PP Up** to the vitamin vendor's inventory.
