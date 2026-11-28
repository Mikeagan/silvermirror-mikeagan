# Pokémon Silver Mirror — Custom Mod (Mikeagan)
**Base Version:** SM 1.2.2 | **Mod Version:** 26

A custom fork of *Pokémon Silver Mirror* adding quality-of-life improvements, rebalanced Poké Balls and shops, expanded learnsets, training tools, and new NPC utilities. For a version-by-version release history, see [CHANGELOG_MOD.md](CHANGELOG_MOD.md).

---

## Quality of Life & Controls
* **Dual Registered Key Items:** Assign two key items simultaneously from the Pack menu—**Tap `SELECT`** (`TAP.SEL`) to use the primary item, or **Hold `SELECT`** (`HOLD.SEL`) to use the secondary item. Selecting the same slot again unregisters the item.
* **Upgraded Itemfinder:** When detecting a hidden item nearby, the player automatically turns toward the item's direction (and spins in place twice when standing directly on top of it).
* **EXP Boost Option:** Added an **EXP Boost (`ON` / `OFF`)** toggle in the in-game Options menu that doubles all battle experience points earned when active.
* **In-Game Version Display:** Current base and mod versions are displayed dynamically on the Title Screen (`M.26`), Main Menu (`S.MIRROR:1.2.2` / `MIKEAGAN:26`), and Save confirmation prompt.
* **Summary Screen Happiness Display:** The Pokémon summary screen displays a heart icon alongside the Pokémon's exact friendship value out of **`/255`**.
* **Full 50-Contact Pokégear Phone:** Expanded Pokégear storage capacity to **50** phone numbers so every contact in the game can be registered without deleting existing entries.
* **5x Berry & Apricorn Yields:** Increased fruit/apricorn tree harvests across Johto and Kanto to **5** items per tree.
* **Pokémon Center Healing:** The player automatically turns downward away from Nurse Joy after healing.

---

## Experience, Items & Training
* **Unsplit Active Battle EXP:** Active battle participants always receive **100% unsplit EXP**, even when multiple Pokémon participate or when **EXP. SHARE** / **EXP. ALL** is active.
* **EXP. SHARE & EXP. ALL Redistribution:**
  * **EXP. SHARE:** Gifted by the Gentleman in **Mt. Moon Pokémon Center 1F** after purchasing the ¥500 Magikarp (grants **50% EXP** to the holder).
  * **EXP. ALL:** Toggleable key item awarded by Professor Oak's Aide at **Route 2 Gate** (grants **50% EXP** to all benched party members when toggled `ON`).
* **Booster Chip (`¥980`):** Available on **Celadon Dept. Store 5F** (`MartVitamins1`). Grants any non-traded Pokémon a permanent **1.5x traded EXP boost** without trade obedience penalties, marked by an upward triangle (**`▲`**) next to `EXP.POINTS` on the summary screen.
* **Vitamins (`¥980`):** Raised the Stat EXP cap per stat from **100** to **200** and doubled the gain per vitamin from **+10** to **+20**.
* **PP Up (`¥980`):** Functions like a **PP Max**, instantly applying all 3 PP Ups to a selected move in a single use.
* **Pokérus Battle Trigger:** Non-Egg party Pokémon holding a **Nugget** have a **~10% chance** of contracting active Pokérus upon entering battle (preserving existing Pokérus or Booster Chip flags).
* **Wild Held Item Drops:** Defeated wild Pokémon automatically drop their held item directly into the player's bag (if space is available).
* **Starter Held Items:** All six starter Pokémon in Oak's Lab come holding an **Oran Berry**.

---

## Custom Poké Ball Multipliers & Mechanics
* **Catch Formula & PC Storage Fixes:** Fixed the High-HP (>341 Max HP) integer overflow bug in the capture formula and resolved a fallthrough bug when sending caught Pokémon to Bill's PC.
* **Standard & Special Poké Balls:**
  * **Poké Ball (`¥20`):** `1x` catch rate.
  * **Great Ball (`¥60`):** Increased from `1.5x` to **`2x`** catch rate.
  * **Ultra Ball (`¥120`):** Increased from `2x` to **`4x`** catch rate.
  * **Safari & Park Balls:** Increased to **`8x`** catch rate.
* **Kurt's Custom Apricorn Balls (`¥1,000` each):** Each ball provides an **`8x` catch rate** on matching target types and sets the captured Pokémon's base friendship to **200** (both in party and PC storage):
  * **Heavy Ball:** `8x` on **Ground**, **Rock**, and **Steel** types.
  * **Level Ball:** `8x` on **Flying** and **Ice** types.
  * **Net Ball:** `8x` on **Water** and **Bug** types.
  * **Fast Ball:** `8x` on **Electric** and **Fighting** types.
  * **Friend Ball:** `8x` on **Grass** and **Normal** types.
  * **Dusk Ball:** `8x` on **Dark**, **Ghost**, and **Poison** types.
  * **Love Ball:** `8x` on **Dragon**, **Fire**, and **Psychic** types.

---

## Shops & Prize Rebalances
* **General Item Price Reductions:** Lowered standard prices on **Poké Balls** (`¥20`/`¥60`/`¥120`), **Vitamins** (`¥980`), **PP Up** (`¥980`), and **Rare Candy** (`¥480`).
* **New 7- & 8-Badge Mart Tiers:** Added 7-badge Poké Ball and 8-badge Medicine tiers across Johto and Kanto Poké Marts and Dept. Stores, making **Master Ball** purchasable after **7 badges** and **Max Revive** / **Full Restore** purchasable after **8 badges**. **Master Ball** may be actually after **8 badges**, will test
* **Celadon Dept. Store 4F (`MartEvolution1`):** Expanded to stock 11 items including **Fire**, **Thunder**, **Water**, **Leaf**, **Sun**, **Moon**, and **Dusk Stones**, plus **Metal Coat**, **Dragon Scale**, and **Linking Cord**.
* **Goldenrod Underground Bargain Shop:** Shifted schedule from morning-only on select days to **every night (`NITE`) across all 7 days of the week**.
* **Buena's Password Prizes:** Reduced prize costs to **1 point** (**Ultra Ball**, **Full Restore**, **Rare Candy**) and **2 points** (**PP Up** and all **Vitamins**).

---

## Pokémon & Move Changes
* **Stone Evolution Level-Up Movesets:** Added complete post-evolution level-up learnsets to **Raichu**, **Nidoqueen**, **Nidoking**, **Clefable**, **Ninetales**, **Wigglytuff**, **Vileplume**, **Arcanine**, **Poliwrath**, **Victreebel**, **Cloyster**, **Exeggutor**, **Starmie**, **Bellossom**, and **Honchkrow**.
* **Caterpie, Weedle & Butterfree:** Lowered **Bug Bite** learnset level to **9** on Caterpie and Weedle, and added **Bug Bite** at level **28** to Butterfree.
* **Abra:** Added **Kinesis** at level **8** and **Disable** at level **10**.
* **Magikarp & Gyarados:** Updated Magikarp's learnset to **Splash** (Lv. 1), **Flail** (Lv. 5), **Tackle** (Lv. 10), **Water Gun** (Lv. 15), and **Bounce** (Lv. 19) with **Water Gun** TM compatibility, and added **Bounce** (Lv. 50) to Gyarados.

---

## World, NPCs & Events
* **Oak's Lab Aide (Pallet Town):** Evaluates party Pokémon genetics, rerolling any DV below **10** up to **10–15**, and offering to maximize all DVs to **15** once stats are solid (`>= 10`).
* **Mr. Psychic (Saffron City):** Evaluates any party Pokémon across three screens: **DVs**, **Stat EXP** (all 5 stats out of `65535`), and **Hidden Power type**.
* **Fighting Dojo (Saffron City):** Both **Hitmonlee** and **Hitmonchan** can be claimed after defeating the Karate Master, and winning the post-rematch battle awards a **Lv. 30 Hitmontop**.
* **Silph Co. 11F:** The President rewards **5 Master Balls** (up from 1).
* **Lavender Mart:** Added a Cooltrainer dialogue hint pointing to the **Nugget** Pokérus secret.
* **Celadon Cafe:** Added a hidden **Leftovers** pickup.
* **Mt. Moon Pokémon Center 1F:** Added a readable Team Rocket newspaper on the table.

---

## Future Ideas (Planned)
* **Fast Berry & Apricorn Tree Respawns:** Possibly Remove the daily reset lock in `engine/events/fruit_trees.asm` so fruit and Apricorn trees replenish immediately without waiting for midnight.
* **Oak's Lab Aide Leaf Costs:** Require a **Silver Leaf** to reroll low DVs up to good stats (`10–15`) and a **Gold Leaf** to maximize good DVs to perfect (`15`).
