/*********************************************************************/
/** Nom :              cmda_c_mov
/** Date de cr�ation : 08/08/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant la liste des commandes relatives aux
/**    d�placements des personnages.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "cmda_utils"
#include "stda_moving"
#include "atha_main"

/***************************** PROTOTYPES ****************************/

// DEF IN "cmda_c_mov"
// Fonction qui d�place un personnage vers un point du module.
//   > string sCommand - Commande � tra�ter.
//   > object oPC - Source de la requ�te.
//   o string - Cha�ne vide.
string cmd_movMoveToCommand(string sCommand, object oPC);

// DEF IN "cmda_c_mov"
// Fonction qui sauvegarde la position actuelle du personnage.
//   > string sCommand - Commande � tra ter.
//   > object oPC - Source de la requ te.
//   o string - Cha�ne vide.
string cmd_movSaveLocCommand(string sCommand, object oPC);

/************************** IMPLEMENTATIONS **************************/

string cmd_movSaveLocCommand(string sCommand, object oPC) {
    // On r�cup�re le nom de la variable choisi par le joueur.
    string sVarName = cmdGetParameterValue(sCommand, CMD_PAR_LOCAL_LOCATION_VARIABLE_NAME);
    // On r�cup�re la position actuelle du PJ.
    if (GetIsPC(oPC)) {
        location lLoc = GetLocation(oPC);
        // On sauvegarde la position de fa on persistante.
        SetLocalLocation(oPC, sVarName, lLoc);
        SendMessageToPC(oPC, CMD_M_YOU_SAVED_THIS_POSITION_IN_THE_VARIABLE+" "+sVarName+".\n"+
                             CMD_M_YOU_CAN_REUSE_IT_TO_RETURN_THERE_AUTOMATICALLY);
    }
    return CMD_EMPTY_RESULT;
}

string cmd_movMoveToCommand(string sCommand, object oPC) {
    // Est-ce que le personnage source est valide ?
    if (!GetIsPC(oPC)) {
        return CMD_EMPTY_RESULT;
    }

    // Est-ce qu'on se d�place vers une location ?
    int iToLocation = cmdIsParameterDefined(sCommand, CMD_PAR_TO_LOCATION);
    // Est-ce qu'on se d�place vers un waypoint ?
    int iToWaypoint = cmdIsParameterDefined(sCommand, CMD_PAR_TO_WAYPOINT);

    // Impossible de faire les deux.
    if (iToLocation && iToWaypoint) {
        cmdSendErrorMessage(oPC, ERR_IMPOSSIBLE_TO_MOVE_TO_WAYPOINT_AND_TO_RENT);
        return CMD_EMPTY_RESULT;
    }

    // Au moins un des deux doit �tre d�fini.
    if (!(iToLocation || iToWaypoint)) {
        cmdSendErrorMessage(oPC, ERR_MOVING_TYPE_NOT_DEFINED);
        return CMD_EMPTY_RESULT;
    }

    // Variables contenant les informations pass�es en param�tre de la commande pour d�placer le PJ.
    location lDest;
    string sWaypointTag;
    string sLocalLocationVarName;

    if (iToLocation) {
        // On r�cup�re la location de destination.
        sLocalLocationVarName = cmdGetParameterValue(sCommand, CMD_PAR_LOCAL_LOCATION_VARIABLE_NAME);
        if (sLocalLocationVarName == CMD_EMPTY_PARAMETER) {
            cmdSendErrorMessage(oPC, ERR_VARIABLE_NAME_PARAMETER_NOT_PASSED_ON);
            return CMD_EMPTY_RESULT;
        }
        lDest = GetLocalLocation(oPC, sLocalLocationVarName);
    } else if (iToWaypoint) {
        sWaypointTag = cmdGetParameterValue(sCommand, CMD_PAR_WAYPOINT_TAG);
        object oWP = GetWaypointByTag(sWaypointTag);
        if (!GetIsObjectValid(oWP)) {
            cmdSendErrorMessage(oPC, ERR_WAYPOINT_DESTINATION_INVALID);
            return CMD_EMPTY_RESULT;
        }
        lDest = GetLocation(oWP);
    }

    // Est-ce le PJ va se d�placer en courant ?
    int iRun = cmdIsParameterDefined(sCommand, CMD_PAR_RUN);

    // Est-ce que l'on va d�placer le PJ instantan�ment ?
    int iJump = cmdIsParameterDefined(sCommand, CMD_PAR_JUMP);

    // ==== Syst�me ATH ====
    // Peut-il se t�l�porter ?
    if (iJump && !athIsAllowed(ATH_JUMP, oPC)) {
        athSendNotAllowedMessage(ATH_JUMP, oPC);
    } else {
        // On d�place le personnage jusqu'� la location sauv�e.
        stdGoToLoc(oPC, lDest, iRun, iJump);
    }

    return CMD_EMPTY_RESULT;
}
