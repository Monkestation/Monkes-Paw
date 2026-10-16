https://github.com/Monkestation/Monkes-Paw/pull/7

## Slime Rancher

Module ID: SLIME_RANCHER

### Description:

rips out slimecore xenobio and replaces it with the slime rancher loop i wrote for OculisStation.

the short version:

- slimes live in pens. a pen is just four corner posts
- adult slimes turn the health they drain into extracts. feed them certain items (or let them drain certain critters) and they mutate instead
- the vacuum pack sucks up slimes to move them around, and turns critters into biomass. the biomass recycler turns that into monkey cubes and breeding pellets
- transformative extracts (made in the extract compressor) permanently change a slime *and* its babies. cat slimes, cleaner slimes, that kinda thing. max three per slime. cat slimes also hop over and harmlessly bounce off of people now and then
- bored slimes stack on top of each other, up to four high
- cleaner slimes roam off to find messes (and sometimes a player), and can take stairs to do it. calm slimes let people walk right through them
- slimes can be picked up if they trust you, and a thrown slime latches onto whoever it hits
- slimes drain livestock too (cows, pigs, sheep, goats, chickens, rabbits)
- radios work inside the rainbow warping pocket room, and ghosts can walk in and out of it

the slime mob itself is just tg's basic slime, but with the AI rewritten in `code/slime_ai.dm`.

slimecore isn't deleted btw, it's still on disk, just unticked. that way upstream merges still apply cleanly instead of exploding. `code/legacy_slimecore.dm` converts the old slimecore map objects so existing maps don't break.

### TG Proc/File Changes:

- `tgstation.dme`: unticked most of slimecore. no PAW EDIT markers here, bc Dream Maker rewrites the include block and would eat them anyways
- the unticked slimecore files under `monkestation/code/modules/slimecore/` each have a marker on line 1
- `code/modules/unit_tests/linked_xenobio_pens.dm`: commented out (it tests slimecore's pen consoles, which are gone), and excluded in `tools/ticked_file_enforcement/schemas/unit_tests.json`
- swapped slimecore API calls for the basic slime ones in:
	- `code/modules/reagents/chemistry/recipes/slime_extracts.dm`
	- `code/modules/research/xenobiology/xenobiology.dm`
	- `code/modules/research/xenobiology/crossbreeding/` (`burning.dm`, `charged.dm`, `chilling.dm`, `regenerative.dm`, `_status_effects.dm`)
	- `code/modules/antagonists/abductor/equipment/glands/slime.dm`
	- `code/game/objects/effects/anomalies/anomalies_pyroclastic.dm`
	- `code/modules/mob_spawn/corpses/nonhuman_corpses.dm`
- yeeted slimecore items from:
	- `code/game/objects/items/stacks/sheets/sheet_types.dm`
	- `code/game/objects/items/robot/items/storage.dm`
	- `monkestation/code/modules/cargo/crates/science.dm` (this one also gets the new compressor board and vacuum pack)
- `code/__HELPERS/paths/path.dm`: pen barriers count as directional blockers on the tile a path leaves from, so mobs don't try to path straight through a fence
- `code/datums/components/orbiter.dm`: ending an orbit actually stops the spin animation, so a starborne weapon quits circling once it's picked up (upstream bug, nobody noticed bc ghosts restart their float animation right after)
- `tgui/packages/tgui/styles/main.scss`: loads the slime rancher stylesheets
- `code/datums/ai/movement/ai_movement_basic_adaptive.dm`: unticked, `code/movement/ai_movement_basic_adaptive.dm` replaces it (only slimes used it)
- `code/datums/ai/movement/_ai_movement.dm`: `close_enough()`, so A* doesn't "arrive" one floor below its target
- `code/datums/ai/_ai_controller.dm`: uses `close_enough()`; changing z-level or losing a client sets `get_expected_ai_status()` instead of forcing IDLE (mobs froze after taking stairs until someone walked up); stored behavior args are looked up by the behavior's type, not the controller's (upstream bug)
- `code/modules/mob/living/living.dm`: same `get_expected_ai_status()` fix when the last player leaves a z-level
- `code/__HELPERS/paths/astar.dm`: `smooth_path_diagonals()` pulls paths into straight lines instead of only cutting single corners
- `code/datums/components/orbiter.dm`: also sends `COMSIG_MOVABLE_STOPPED_ORBITING` to the orbiter, for starborne weapons
- `code/game/objects/items.dm`: pickup animation keeps `KEEP_TOGETHER`, so starborne stars stay clipped to the item
- radios hear through warped room runes: `code/game/machinery/telecomms/broadcasting.dm`, `code/game/machinery/telecomms/machines/message_server.dm`, `code/game/objects/items/devices/radio/radio.dm`, `code/game/objects/items/devices/radio/intercom.dm`
- `code/modules/food_and_drinks/machinery/smartfridge.dm`: the panel overlay is drawn in `update_overlays()`, screwdriving a fridge used to `cut_overlays()` and wipe its contents and light (upstream bug)
- `code/modules/unit_tests/_unit_tests.dm`: includes `~paw/slime_ranching.dm`
- `code/modules/research/xenobiology/crossbreeding/industrial.dm`: output lands in the bag the extract is in, or its drop location, instead of always the turf
- `code/game/objects/items/blueprints.dm`: slime blueprints tint with `SATURATION_OVERRIDE`, so the area color actually shows

### Modular Overrides:

all under `z_modular_paw/master_files/code/`:

- `__HELPERS/paths/path.dm`
- `datums/ai/monkey/monkey_behaviors.dm`
- `datums/ai/monkey/monkey_controller.dm`
- `game/objects/items/storage/bags.dm`
- `modules/food_and_drinks/machinery/smartfridge.dm`
- `modules/mob/living/basic/basic.dm`
- `modules/mob/living/basic/farm_animals/` (`cow/_cow.dm`, `goat/_goat.dm`, `pig.dm`, `rabbit.dm`): biomass and slime meal values
- `datums/components/pet_commands/obeys_commands.dm`
- `datums/components/pet_commands/pet_command.dm`

and under `z_modular_paw/master_files/monkestation/code/modules/ranching/`: `chickens/_chicken.dm`, `sheep/_base.dm`
- `modules/research/techweb/service_nodes.dm`
- `modules/research/xenobiology/crossbreeding/__corecross.dm`

### Defines:

- `code/__DEFINES/~paw_defines/slime_rancher.dm`

### Included files that are not contained in this module:

tgui stuff, bc tgui can't be modular. all under `tgui/packages/tgui/`:

- `interfaces/SlimePen.tsx`
- `interfaces/SlimeRancherScanner.tsx`
- `interfaces/common/SlimeRancher.tsx`
- `styles/interfaces/SlimePen.scss`
- `styles/interfaces/SlimeRancherScanner.scss`
- `styles/themes/slime_rancher.scss`

and one map, bc map templates have to live under `_maps/`:

- `_maps/templates/paw/warped_room.dmm` - the pocket room behind the rainbow warping rune

### Credits:

- Absolucy - the original rework ([OculisStation PR #472](https://github.com/OculisStation/OculisStation/pull/472)) and this port, plus the round 2 stuff from [OculisStation PR #546](https://github.com/OculisStation/OculisStation/pull/546) and [Monkestation PR #12711](https://github.com/Monkestation/Monkestation2.0/pull/12711)
- tgstation - the basic slime mob
- BeeStation and OculisStation - the warping crossbreeds and the warped room map
- sprites: see `icons/attributions.txt`
