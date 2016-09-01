/*********************************************************************/
/** Nom :              afka_main.nss
/** Date de création : 22/03/2011
/** Version :          1.0.0
/** Createur :         Loup Peluso
/***************************** ChangeLog *****************************/
/** V1.0.0 :
/**     Script gérant la mise en mode AFK des personnages.
/*********************************************************************/

// TODO : Effectuer une vérification dans une boucle de personnage.
// (voir dans PCMANIPS la boucle de sauvegarde de position => élargir)

/***************************** INCLUDES ******************************/

#include "afka_constants"
#include "cosa_pcmanips"
#include "stda_locmanips"
#include "stda_moving"
#include "nw_i0_generic"

/***************************** PROTOTYPES ****************************/

// TODO (Anael) : Documenter les fonctions.

void afkActivateAFK(object oPC);
void afkDeactivateAFK(object oPC);
int afkIsActivated(object oPC);
void afkToggleState(object oPC);

/************************** IMPLEMENTATIONS **************************/

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
        stdJumpToObject(oPC, GetWaypointByTag(AFK_DESTINATION_WAYPOINT_TAG));
    }
}
void afkDeactivateAFK(object oPC) {
    location lLoc = cosGetLocalLocation(oPC, AFK_LAST_LOCATION);
    cosSetLocalInt(oPC, AFK_IS_ACTIVATED, FALSE);
    stdJumpToLoc(oPC, lLoc);
}

