/*********************************************************************/
/** Nom :              usua_movings
/** Date de création : 21/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script regroupant les fonctions de déplacement.
/*********************************************************************/

// TODO : Tester les fonctions.

/***************************** INCLUDES ******************************/

#include "usua_constants"

/***************************** PROTOTYPES ****************************/

// TODO (Anael) : Documenter les fonctions.

void usuJumpToLoc(object oPC, location lLoc);
void usuJumpToObject(object oPC, object oDest);
void usuRunToLoc(object oPC, location lLoc);
void usuRunToObject(object oPC, object oDest);
void usuGoToLoc(object oPC, location lLoc, int iRun = FALSE, int iJump = FALSE);
void usuGoToObject(object oPC, object oDest, int iRun = FALSE, int iJump = FALSE);

/************************** IMPLEMENTATIONS **************************/

void usuJumpToLoc(object oPC, location lLoc) {
    usuGoToLoc(oPC, lLoc, FALSE, TRUE);
}

void usuJumpToObject(object oPC, object oDest) {
    usuGoToObject(oPC, oDest, FALSE, TRUE);
}

void usuRunToLoc(object oPC, location lLoc) {
    usuGoToLoc(oPC, lLoc, TRUE);
}

void usuRunToObject(object oPC, object oDest) {
    usuGoToObject(oPC, oDest, TRUE);
}

// TODO (Anael) : Remplacer les valeurs littérales par des constantes
// stockées dans le fichier usua_constants.nss en sachant que les constantes
// devront commencer par le préfixe USU_ pour se différencier des autres.
void usuGoToLoc(object oPC, location lLoc, int iRun = FALSE, int iJump = FALSE) {
    object oDest = CreateObject(OBJECT_TYPE_WAYPOINT, "nw_waypoint001", lLoc);
    usuGoToObject(oPC, oDest, iRun, iJump);
    AssignCommand(oPC, ActionDoCommand(DestroyObject(oDest, 1.0f)));
}

void usuGoToObject(object oPC, object oDest, int iRun = FALSE, int iJump = FALSE) {
    AssignCommand(oPC, ClearAllActions());
    if (iJump) {
        AssignCommand(oPC, JumpToObject(oDest));
    } else {
        AssignCommand(oPC, ActionMoveToObject(oDest, iRun, 1.0f));
    }
}

