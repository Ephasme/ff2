/*********************************************************************/
/** Nom :              usuaf_movings
/** Date de création : 21/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script regroupant les fonctions de déplacement.
/*********************************************************************/

// TODO: Rendre plus fiable le déplacement d'un point à l'autre et éviter que les personnages.
// ne cessent de courir quand ils franchissent une transition.

/***************************** INCLUDES ******************************/

#include "usuaf_constants"

/***************************** PROTOTYPES ****************************/

// DEF IN "usuaf_movings"
// Fonction qui ramène le personnage à un endroit défini.
//   > object oPC - PJ que l'on projette de déplacer.
//   > location lLoc - Localisation où le PJ doit être déplacé.
//   > int iRun - Le personnage court si la valeur est fixée sur TRUE.
//   > int iJump - Le déplacement est instantané si la valeur est fixée sur TRUE.
void usuMoveToLocation(object oPC, location lLoc, int iRun = FALSE, int iJump = FALSE);

/************************** IMPLEMENTATIONS **************************/

void usuMoveToLocation(object oPC, location lLoc, int iRun = FALSE, int iJump = FALSE) {
    string sAreaName = GetName(GetAreaFromLocation(lLoc));
    vector vVect = GetPositionFromLocation(lLoc);
    string sPos = "("+FloatToString(vVect.x, 0, 2)+", "+
                      FloatToString(vVect.y, 0, 2)+", "+
                      FloatToString(vVect.z, 0, 2)+")";
    string sMess = USU_L_AUTOMATIC_MOVEMENT_UP_TO_THE_MAP+" "+sAreaName+".\n"+USU_L_TO_THE_POSITION+" :\n"+sPos+".";
    if (iJump) {
        sMess += USU_L_INSTANT_MOVING+".";
        AssignCommand(oPC, ActionJumpToLocation(lLoc));
    } else {
        // TODO: Fonction à terminer.
        // On crée une variable locale qui permet de déterminer si le personnage à atteint sa destination.
        AssignCommand(oPC, ActionMoveToLocation(lLoc, iRun));
    }
    SendMessageToPC(oPC, sMess);
}

