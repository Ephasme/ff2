/*********************************************************************/
/** Nom :              stda_moving
/** Date de création : 21/07/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script regroupant les fonctions de déplacement.
/*********************************************************************/

// TODO : Tester les fonctions.

/***************************** INCLUDES ******************************/

#include "stda_constants"
#include "stda_exceptions"

/***************************** PROTOTYPES ****************************/

// DEF IN "stda_moving"
// Fonction qui permet de téléporter un personnage vers un objet. 
//   > object oPC - Personnage concerné.
//   > object oDest - Objet vers lequel le personnage sera téléporté. 
void stdJumpToObject(object oPC, object oDest);

// DEF IN "stda_moving"
// Fonction qui permet de faire courir un personnage vers une localisation.
//   > object oPC - Personnage concerné.
//   > location lLoc - localisation vers laquelle le personnage devra courir.
void stdRunToLoc(object oPC, location lLoc);

// DEF IN "stda_moving"
// Fonction qui permet de faire courir un personnage vers un objet. 
//   > object oPC - Personnage concerné.
//   > object oDest - Objet vers lequel le personnage devra courir. 
void stdRunToObject(object oPC, object oDest);

// DEF IN "stda_moving"
// Fonction qui permet de créer un waypoint à une localisation, qui y déplace le
// personnage (grâce à la fonction stdGotoObject) en courant ou en le
// téléportant puis qui détruit le waypoint.
//   > object oPC - Personnage concerné.
//   > location lLoc - Localisation où sera créé le waypoint.
//   > int iRun = FALSE - Booléen initialisé à FALSE, s'il vaut TRUE, le personnage sera déplacé en courant.
//   > int iJump = FALSE - Booléen initialisé à FALSE, s'il vaut TRUE, le personnage sera déplacé par téléportation.
void stdGoToLoc(object oPC, location lLoc, int iRun = FALSE, int iJump = FALSE);

// DEF IN "stda_moving"
// Focntion qui permet de déplacer le personnage vers un objet en marchant ou en
// le téléportant.
//   > object oPC - Personnage concerné.
//   > object oDest - Objet vers lequel sera déplacé le personnage 
//   > location lLoc - Localisation où sera créé le waypoint.
//   > int iRun = FALSE - Boléen initialisé à FALSE, s'il vaut TRUE, le personnage sera déplacé en courant.
//   > int iJump = FALSE - Boléen initialisé à FALSE, s'il vaut TRUE, le personnage sera déplacé par téléportation.
void stdGoToObject(object oPC, object oDest, int iRun = FALSE, int iJump = FALSE);

/************************** IMPLEMENTATIONS **************************/

void stdJumpToLoc(object oPC, location lLoc) {
    stdGoToLoc(oPC, lLoc, FALSE, TRUE);
}

void stdJumpToObject(object oPC, object oDest) {
    stdGoToObject(oPC, oDest, FALSE, TRUE);
}

void stdRunToLoc(object oPC, location lLoc) {
    stdGoToLoc(oPC, lLoc, TRUE);
}

void stdRunToObject(object oPC, object oDest) {
    stdGoToObject(oPC, oDest, TRUE);
}

void stdGoToLoc(object oPC, location lLoc, int iRun = FALSE, int iJump = FALSE) {
    object oDest = CreateObject(OBJECT_TYPE_WAYPOINT, STD_CIBLE_WP_RESREF, lLoc);
    stdGoToObject(oPC, oDest, iRun, iJump);
    AssignCommand(oPC, ActionDoCommand(DestroyObject(oDest, STD_TIME_BEFORE_DESTROY_WP)));
}

void stdGoToObject(object oPC, object oDest, int iRun = FALSE, int iJump = FALSE) {
	if (!GetIsObjectValid(oDest)) {
		stdRaiseException(STD_ERR_CANNOT_FIND_DESTINATION, STD_SYS_NAME, STD_SYS_ACRO);
	}
	if (!GetIsObjectValid(oPC)) {
		stdRaiseException(STD_ERR_CHARACTER_INVALID, STD_SYS_NAME, STD_SYS_ACRO);
	}
    AssignCommand(oPC, ClearAllActions());
    if (iJump) {
        AssignCommand(oPC, JumpToObject(oDest));
    } else {
        AssignCommand(oPC, ActionMoveToObject(oDest, iRun, STD_DISTANCE_BETWEEN_CIBLE));
    }
}