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

/***************************** PROTOTYPES ****************************/

void rspMoveToRespawnArea(object oPC);

/************************** IMPLEMENTATIONS **************************/

void rspMoveToRespawnArea(object oPC) {
	object oWP = GetWaypointByTag(RSP_DEST_WP_TAG);
	if (GetIsObjectValid(oWP)) {
		stdJumpToObject(oPC, oWP);
	} else {
		stdRaiseException(RSP_ERR_CANNOT_FIND_DEST_WAYPOINT, RSP_SYS_NAME, RSP_SYS_ACRO);
	}
}