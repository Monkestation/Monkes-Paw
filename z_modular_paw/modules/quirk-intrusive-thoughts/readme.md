<!-- This should be copy-pasted into the root of your module folder as readme.md -->

https://github.com/Monkestation/Monkes-Paw/pull/<!--PR Number-->

## Intrusive Thoughts Quirk <!--Title of your addition.-->

Module ID: Quirk_Intrusive_Thoughts<!-- Uppercase, UNDERSCORE_CONNECTED name of your module, that you use to mark files. This is so people can case-sensitive search for your edits, if any. -->

### Description:

<!-- Here, try to describe what your PR does, what features it provides and any other directly useful information. -->
Role-play oriented neutral quirk that gives the quirk holder a variant of the split personality brain trauma.
Differences from split personality:
- permanent trauma
- polls for two minutes
- backseat role can force the host body to speak
- very low chance of giving backseat control; very high chance of swapping back; effectively, every so often backseat gets ~1 second of control of the body

### TG Proc/File Changes:

- N/A
<!-- If you edited any core procs, you should list them here. You should specify the files and procs you changed.
E.g:
- `code/modules/mob/living.dm`: `proc/overriden_proc`, `var/overriden_var`
  -->

### Modular Overrides:

- N/A
<!-- If you added a new modular override (file or code-wise) for your module, you should list it here. Code files should specify what procs they changed, in case of multiple modules using the same file.
E.g:
- `z_modular_paw/master_files/sound/my_cool_sound.ogg`
- `z_modular_paw/master_files/code/my_modular_override.dm`: `proc/overriden_proc`, `var/overriden_var`
  -->

### Defines:

- `z_modular_paw\modules\quirk-intrusive-thoughts\datums\actions\mobs\intrude_thought.dm`: `datum/action/intrude_thought`
- `z_modular_paw\modules\quirk-intrusive-thoughts\datums\quirks\neutral_quirks\intrusivethoughts.dm`: `datum/quirk/intrusivethoughts`
- `z_modular_paw\modules\quirk-intrusive-thoughts\datums\brain_damage\intrusive_thoughts.dm`: `datum/brain_trauma/special/intrusive_thoughts`
<!-- - N/A -->
<!-- If you needed to add any defines, mention the files you added those defines in, along with the name of the defines. -->

### Included files that are not contained in this module:

- N/A
<!-- Likewise, be it a non-modular file or a modular one that's not contained within the folder belonging to this specific module, it should be mentioned here. Good examples are icons or sounds that are used between multiple modules, or other such edge-cases. -->

### Credits:

<!-- Here go the credits to you, dear coder, and in case of collaborative work or ports, credits to the original source of the code. -->
