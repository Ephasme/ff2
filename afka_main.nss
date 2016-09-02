#include "afka_constants"
#include "cosa_pcmanips"
#include "stda_locmanips"
#include "stda_moving"
#include "nw_i0_generic"

void afkActivateAFK(object oPC);
void afkDeactivateAFK(object oPC);
int afkIsActivated(object oPC);
void afkToggleState(object oPC);

int afkIsActivated(object oPC) {
    return cosGetLocalInt(oPC, AFK_IS_ACTIVATED);
}

void afkToggleState(object oPC) {
    if (afkIsActivated(oPC)) {
        afkDeactivateAFK(oPC);
    } else {
        afkActivateAFK(oPC);
    }
}
void afkActivateAFK(object oPC) {
    if (!GetIsFighting(oPC)) {
        cosSetLocalLocation(oPC, AFK_LAST_LOCATION, GetLocation(oPC));
        cosSetLocalInt(oPC, AFK_IS_ACTIVATED, TRUE);
        stdJumpToObject(oPC, GetWaypointByTag(AFK_DEST_WP_TAG));
    }
}
void afkDeactivateAFK(object oPC) {
    location lLoc = cosGetLocalLocation(oPC, AFK_LAST_LOCATION);
    cosSetLocalInt(oPC, AFK_IS_ACTIVATED, FALSE);
    stdJumpToLoc(oPC, lLoc);
}
