/*********************************************************************/
/** Nom :              rspa_main
/** Date de création :
/** Version :          1.0.0
/** Createur :         Loup Peluso
/***************************** ChangeLog *****************************/
/** V1.0.0 :
/**      Fonctions de gestion du respawn.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "stda_exceptions"
#include "stda_moving"
#include "rspa_constants"

/***************************** PROTOTYPES ****************************/

// TODO (Anael) : Documenter fonctions.
void rspMoveToRespawnDestination(object oPC);
void rspMoveToRespawnOrigin(object oPC);

/************************** IMPLEMENTATIONS **************************/

/* Private function */
void pv_moveTo(object oPC, string sWPTag) {
    object oWP = GetWaypointByTag(sWPTag);
    if (GetIsObjectValid(oWP)) {
        stdJumpToObject(oPC, oWP);
    } else {
        stdRaiseException(RSP_ERR_CANNOT_FIND_WAYPOINT, RSP_SYS_NAME, RSP_SYS_ACRO);
    }
}

void rspMoveToRespawnDestination(object oPC) {
    pv_moveTo(oPC, RSP_DEST_WP_TAG);
}

void rspMoveToRespawnOrigin(object oPC) {
    pv_moveTo(oPC, RSP_ORIG_WP_TAG);
}
