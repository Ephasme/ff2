const string TAG_WP_WEST_SIDE = "016_bridge_west_side";
const string TAG_WP_EAST_SIDE = "016_bridge_east_side";

const string TAG_PL_TRACKS_TO_EAST = "016_go_to_east";
const string TAG_PL_TRACKS_TO_WEST = "016_go_to_west";


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

    if (sTag == TAG_PL_TRACKS_TO_EAST || sTag == TAG_PL_TRACKS_TO_WEST) {
        FadeToBlack(oPC, FADE_SPEED_FAST);
        SetCutsceneMode(oPC, TRUE);
        if (sTag == TAG_PL_TRACKS_TO_EAST) {
            DelayCommand(2.0f, pv_Jump(oPC, TAG_WP_EAST_SIDE));
        } else {
            DelayCommand(2.0f, pv_Jump(oPC, TAG_WP_WEST_SIDE));
        }
    }
}
