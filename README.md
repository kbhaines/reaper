# Reaper Plugins etc.

These are a collection of evolving Reaper scripts, quick and dirty since I'm not yet
proficient in JS.

## UACC.js

This plugin sends Spitfire-style UACC controls (i.e. CC 32) in response to how the notes have 
been annotated in Reaper's notation. E.g. marking a note staccato will cause it to send value 
40 to CC32. Anything not annotated gets defaulted to a good-old sustain note.

You need to turn on UACC support in your library:

https://spitfireaudio.zendesk.com/hc/en-us/articles/115002450966-What-is-UACC-and-how-do-I-use-it-

The advantage is that per-note articulations are now visible in the notation view, the 
disadvantage is that Reaper may not have all the possible articulations you need; 
in this case you need to define a custom annotation, or pick an unused existing one
and just accept the display won't be perfect!

I haven't mapped everything - only the ones I need for parts of my libraries (Albion 1), 
but it should be straightforward change/add anything you need.

To add a new articulation, work out what the notation is in text (using the
event view in Reaper after annotating the note) and add it into the list in 
`parse_notation` along with the corresponding CC32 value; try to keep the list 
sorted in string-length order and also keep the higher-priority items down the bottom (*).

(*) I'm aware this is not ideal and will try to improve it over time, but
it's not a priority for me right now.


## VSL SE 

TBD...
