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

#include "dbga_main"

#include "afka_constants"
#include "cosa_pcmanips"
#include "usua_locmanips"
#include "usua_movings"
#include "NW_I0_GENERIC"

/***************************** PROTOTYPES ****************************/

// TODO : Documenter les fonctions.

void afkActivateAFK(object oPC);
void afkDeactivateAFK(object oPC);
int afkIsActivated(object oPC);
void afkToggleState(object oPC);

/************************** IMPLEMENTATIONS **************************/

int afkIsActivated(object oPC) {
    return cosGetLocalInt(oPC, AFK_IS_ACTIVATED);
}

void afkToggleState(object oPC) {
/*DEBUG*/ dbgChangeSource("afkToggleState");
/*DEBUG*/ dbgWrite("Get AFK mode : ");
    if (afkIsActivated(oPC)) {
/*DEBUG*/ dbgWrite("AFK mode Activated ");
        afkDeactivateAFK(oPC);
    } else {
/*DEBUG*/ dbgWrite("AFK mode Deactivated ");
        afkActivateAFK(oPC);
    }
}
void afkActivateAFK(object oPC) {
/*DEBUG*/ dbgChangeSource("afkActivateAFK");
    if (!GetIsFighting(oPC)) {
/*DEBUG*/ dbgWrite("PC not fighting : move.");
        cosSetLocalLocation(oPC, AFK_LAST_LOCATION, GetLocation(oPC));
/*DEBUG*/ dbgWrite("Save Loc : "+usuLocationToString(cosGetLocalLocation(oPC, AFK_LAST_LOCATION)));
        cosSetLocalInt(oPC, AFK_IS_ACTIVATED, TRUE);
/*DEBUG*/ dbgWrite("Set AFK mode = " + IntToString(cosGetLocalInt(oPC, AFK_IS_ACTIVATED)));
/*DEBUG*/ dbgWrite("And Jump to !");
        usuJumpToObject(oPC, GetWaypointByTag(AFK_DEST_WP_TAG));
    }
/*DEBUG*/ else { dbgWrite("PC is Fighting : dont move."); }
}
void afkDeactivateAFK(object oPC) {
/*DEBUG*/ dbgChangeSource("afkDeactivateAFK");
    location lLoc = cosGetLocalLocation(oPC, AFK_LAST_LOCATION);
/*DEBUG*/ dbgWrite("Get location saved : "+usuLocationToString(lLoc));
    cosSetLocalInt(oPC, AFK_IS_ACTIVATED, FALSE);
/*DEBUG*/ dbgWrite("Set AFK mode = " + IntToString(cosGetLocalInt(oPC, AFK_IS_ACTIVATED)));
/*DEBUG*/ dbgWrite("And Jump to !");
    usuJumpToLoc(oPC, lLoc);
}

