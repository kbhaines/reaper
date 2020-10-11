is_new,name,sec,cmd,rel,res,val = reaper.get_action_context()
reaper.ShowConsoleMsg(cmd .. name .. "\nrel: " .. rel .. "\nres: " .. res .. "\nval = " .. val .. "\n")

function add_artic(artic_id)
  take = reaper.MIDIEditor_GetTake(reaper.MIDIEditor_GetActive())
  if not take then
    return
  end

  sel_note = reaper.MIDI_EnumSelNotes(take, 0)
  if sel_note > -1 then
    note,_,_,ppq = reaper.MIDI_GetNote(take, sel_note)
  else
    ppq = reaper.MIDI_GetPPQPosFromProjTime(take, reaper.GetCursorPosition())
  end
  reaper.MIDI_InsertCC(take, false, false, ppq, 0xc0, 0, artic_id, 0)

end

if cmd == -1 then
  reaper.ShowConsoleMsg("No action")
else
  add_artic(17)
end
