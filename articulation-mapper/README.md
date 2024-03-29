# Articulation Mapper

This JSFX plugin allows you to define articulations which are triggered via
Reaper's built-in notation features. This is similar to Expression Maps in
Cubase or Articulation Sets in LogicPro.

Features:

- Articulations are triggered by notation attached to notes
- Midi Notes and CC triggers, up to 4 per articulation
- Simultaneous notes can have different articulations (no need to slightly separate the notes)
- Up to 80 articulations per instance
- UI displays currently triggered articulation
- Default articulation can be set (when notes have no notation attached)
- Default articulation can be changed by keyswitch (allows you to mix keyswitching & notation)
- Simple text file based configuration (examples for Spitfire & VSL included)

Example of the UI:

![Screenshot of UI](ui1.png)

# Installation

Use [ReaPack](https://reapack.com/user-guide) to install (preferred).

Alternatively:

- Copy the [JSFX](Articulation-KS-Mapper.jsfx) to your `REAPER/Effects` folder.
- Copy the [articulation maps folder](articulation-maps) into the `REAPER/Data` folder.

# Usage

- Select the articulation map you want to use from the drop down

- Set a default articulation for when a note has no notation associated with it;
if you leave this as 0 then the articulations will 'latch' to the last selected
articulation.

- Add notation to your notes!

# Articulation File Format and Example

## Format Overview

The file format supports the following elements (or combinations thereof):

- Keyswitch (i.e. note) - e.g `C#1`  (**NOTES ARE UPPERCASE!**)
- Midi CC e.g `cc20.64` sets CC20 to 64 (**CCs are LOWERCASE!**)
- UACC/KS (Spitfire Audio 'standard') e.g. `C-1.1` sends C-1 at velocity 1

Note:
* Elements are **CASE SENSITIVE**
* UACC/KS is specific to Spitfire; this plugin only supports UACC/KS keyswitches on a 'C' note 

You can put **up to 4** of these elements together in a sequence.  Elements in the
sequence are sent in the order specified; all notes are set to ON, then all
notes are set to OFF. Any intervening Midi CC elements are sent when the notes
are being turned ON.

Example: `C1cc20.64D1 articulation marcato` will match notes with the marcato
articulation set on them, and the effect will then send:

- Note C1 ON
- Midi CC20 = 64
- Note D1 ON
- Note C1 OFF
- Note D1 OFF

NOTE: C4 is middle C (midi #60)

The plugin will ignore any lines it can't parse/recognise; you can see the
active articulations in the UI.

(Also, see the [articulation maps](articulation-maps) folder for more examples and
starting points for your own use)

## Example

The following example demonstrates configuration for an imaginary library,
relating to the notation given in the following Reaper midi item:

![Example Articulations]( example1.png )

```
; Any lines that don't match an articulation specification are ignored so you
; can put free-form comments in the file, like this comment.  Semicolons are
; used at the start of comments in the example just to make it clearer

; Articulations are searched in order for a match - the first matching notation
; will be used, and the corresponding sequence will be sent.

C1 custom _generic_long; Everything after a semicolon is ignored

; NOTE: you'll need to define custom notations such as that above whenever there
; isn't a corresponding Reaper notation 'articulation' or 'ornament' etc.

; You don't actually need to put this articulation on long notes, instead
; you can just set an articulation to be a default when no notation has 
; been put on the note (see the UI above)

; A note's notation must *exactly* match the string, so don't put whitespace on
; the end of the line!

C#1 articulation staccato
D1 articulation marcato
D#1 ornament tremolo

; The next one is a multi-key switch; D1 and D#1 will be pressed then released
; before the actual note is sent; this example might work well for libraries
; from Spitfire that allow you to layer articulations.
; 
; It will also work for VSL, where the Synchron player uses 'dimensions'
; comprising multiple keys to get to a single articulation.

D1D#1 articulation marcato ornament tremolo

; Alternatively, this uses a MIDI CC value hard-coded to set the amount of tremolo:
; (NB it won't 'fire' because the articulation above matches first)

D1D#1cc20.64 articulation marcato ornament tremolo

E1 ornament pluck; Pizzicato
```
