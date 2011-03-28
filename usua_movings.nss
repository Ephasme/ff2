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

// DEF IN "usua_moving"
// Fonction qui permet de téléporter un personnage vers un objet. 
//   > object oPC - Personnage concerné.
//   > object oDest - Objet vers lequel le personnage sera téléporté. 
void usuJumpToObject(object oPC, object oDest);

// DEF IN "usua_moving"
// Fonction qui permet de faire marcher un personnage vers une localisation (en passant par un waypoint détruit à la fin du déplacement)
//   > object oPC - Personnage concerné.
//   > location lLoc - localisation vers laquelle le personnage devra marcher.
void usuRunToLoc(object oPC, location lLoc);

// DEF IN "usua_moving"
// Fonction qui permet de faire marcher un personnage vers un objet. 
//   > object oPC - Personnage concerné.
//   > object oDest - Objet vers lequel le personnage devra marcher. 
void usuRunToObject(object oPC, object oDest);

// DEF IN "usua_moving"
// Fonction qui permet de créer un waypoint à une localisation, qui y déplace le personnage (grâce à la fonction usuGotoObject) en marchant ou en le téléportant puis qui détruit le waypoint.
//   > object oPC - Personnage concerné.
//   > location lLoc - Localisation où sera créé le waypoint.
//   > int iRun = FALSE - Boléen initialisé à FALSE, s'il vaut TRUE, le personnage sera déplacé en marchant.
//   > int iJump = FALSE - Boléen initialisé à FALSE, s'il vaut TRUE, le personnage sera déplacé par téléportation.
void usuGoToLoc(object oPC, location lLoc, int iRun = FALSE, int iJump = FALSE);

// DEF IN "usua_moving"
// Focntion qui permet de déplacer le personnage vers un objet en marchant ou en le téléportant.
//   > object oPC - Personnage concerné.
//   > object oDest - Objet vers lequel sera déplacé le personnage 
//   > location lLoc - Localisation où sera créé le waypoint.
//   > int iRun = FALSE - Boléen initialisé à FALSE, s'il vaut TRUE, le personnage sera déplacé en marchant.
//   > int iJump = FALSE - Boléen initialisé à FALSE, s'il vaut TRUE, le personnage sera déplacé par téléportation.
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

