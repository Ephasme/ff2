void pv_Jump(object oPC, string sTag) {
    location lLoc = GetLocation(GetWaypointByTag(sTag));
    float fFacing = GetFacingFromLocation(lLoc);
    AssignCommand(oPC, JumpToLocation(lLoc));
    AssignCommand(oPC, SetFacing(fFacing));
    FadeFromBlack(oPC, FADE_SPEED_FAST);
    SetCutsceneMode(oPC, FALSE);
}

void main()
{
    object oPC = GetLastUsedBy();
    string sTag = GetTag(OBJECT_SELF);

    SendMessageToPC(oPC, "On teleporte !!");

    if (sTag == "test" || sTag == "test") {
        FadeToBlack(oPC, FADE_SPEED_FAST);
        SetCutsceneMode(oPC, TRUE);
        if (sTag == "test") {
            DelayCommand(2.0f, pv_Jump(oPC, "test"));
        } else {
            DelayCommand(2.0f, pv_Jump(oPC, "test"));
        }
    }
}
