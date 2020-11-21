desc:UACC Articulation Controller
//slider1:art_type=0<0,2,1{C1/C2,C1/C7 (Cello),C6/C7}>Articulation KS Config

in_pin:none
out_pin:none

@init
function blip_note(offset, note) (
  midisend(offset, $x90, note, 127);
  midisend(offset, $x80, note, 0);
);

// this is the last articulation set by an actual PC message
pc_art = 0;
generic_long = 1;  // UACC for default long/sustain. Could make this an option in the UI

// this is the articulation last set by a notation
active_notn_art = 0;
art_notn = 1;
note_on_ctr = 1;

function parse_notation(msg) (
  artic = 0;
  // These are the spitfire UACC mappings, found at:
  // https://spitfireaudio.zendesk.com/hc/en-us/articles/115002450966-What-is-UACC-and-how-do-I-use-it-
  // Anything zero hasn't been mapped yet
  match("*custom spiccato", #msg) ? artic = 42;
  match("*custom col-legno", #msg) ? artic = 58;
  match("*custom con-sordino", #msg) ? artic = 7;
  match("*ornament pluck", #msg) ? artic = 56;  // pizz
  match("*phrase %d slur*", #msg) ? artic = 20;
  match("*ornament tremolo", #msg) ? artic = 11;
  match("*articulation marcato", #msg) ? artic = 52;
  match("*articulation staccato", #msg) ? artic = 40;
  match("*custom sus phrase*", #msg) ? artic = 20;
  match("*custom sfz ornament tremolo", #msg) ? artic = 14;
  match("*phrase %d slur*technique bend", #msg) ? artic = 33;
  match("*articulation marcato ornament tremolo", #msg) ? artic = 14;
  artic;
);


@block
while (midirecv_str(offset, #str)) (
  msg1 = str_getchar(#str, 0);
  msg2 = str_getchar(#str, 1);
  msg3 = str_getchar(#str, 2);
  
  // Look for a string event which is a notation
  msg1 == $xFF && msg2 == $x0F ? (
    strcpy_from(#msg, #str, 2);
    (art_notn = parse_notation(#msg)) ? (
      active_notn_art != art_notn ? (
        midisend(offset, $xB0, 32, art_notn);
        active_notn_art = art_notn;
      );
      
      // two note-on messages will reset notation-articulation
      note_on_ctr = 2;
    );
  ) : (

    msg1 == $x90 && msg3 > 0 && note_on_ctr ? (
      note_on_ctr -=1 ;
      note_on_ctr == 0 ? (
        midisend(offset, $xB0, 32, generic_long);
        active_notn_art = 0;
      );
    ) : ( 
      active_notn_art = 0;  // PC disables active articulation
    );
    midisend_str(offset, #str); // passthrough other events
  );
); 
