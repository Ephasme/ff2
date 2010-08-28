/*********************************************************************/
/** Nom :              scm_cmmoving
/** Date de création : 08/08/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant la liste des commandes relatives aux
/**    déplacements des personnages.
/*********************************************************************/

/***************************** INCLUDES ******************************/

    // Donnees de config.
    // #include "cos_config"

    // Fonctions de manipulation des chaînes de caractères.
    // #include "usu_stringtokman"
// Fonctions de manipulation et de traîtement.
#include "scm_utils"

// Fonctions de déplacement.
#include "usu_movings"

/***************************** CONSTANTES ****************************/

// Constantes de langue.
const string L_YOU_SAVED_THIS_POSITION_IN_THE_VARIABLE = "Vous avez sauvegardé cette position dans la variable";
const string L_YOU_CAN_REUSE_IT_TO_RETURN_THERE_AUTOMATICALLY = "Vous pourrez la réutiliser pour y revenir automatiquement.";

// Nom des commandes.
const string SCM_CM_MOVE_TO = "moveto";
const string SCM_CM_SAVE_LOC = "savepos";

// Paramètres des commandes.
const string SCM_PAR_LOCAL_LOCATION_VARIABLE_NAME = "var";
const string SCM_PAR_WAYPOINT_TAG = "tag";
const string SCM_PAR_TO_LOCATION = "loc";
const string SCM_PAR_TO_WAYPOINT = "wp";
const string SCM_PAR_RUN = "run";
const string SCM_PAR_JUMP = "jump";

// Messages d'erreur.
const string ERR_IMPOSSIBLE_TO_MOVE_TO_WAYPOINT_AND_TO_RENT = "Impossible de se déplacer à la fois vers un Waypoint et vers une Location.";
const string ERR_VARIABLE_NAME_PARAMETER_NOT_PASSED_ON = "Paramètre de nom de variable non transmit.";
const string ERR_WAYPOINT_DESTINATION_INVALID = "Le Waypoint de destination est invalide.";
const string ERR_MOVING_TYPE_NOT_DEFINED = "Le type de déplacement (vers un Waypoint ou vers une Location) n'a pas été défini.";

/***************************** PROTOTYPES ****************************/

// DEF IN "scm_commands"
// Fonction qui déplace un personnage vers un point du module.
//   > string sCommand - Commande à traîter.
//   > object oPC - Source de la requête.
//   o string - Chaîne vide.
string scmMoveToCommand(string sCommand, object oPC);

// DEF IN "scm_commands"
// Fonction qui sauvegarde la position actuelle du personnage.
//   > string sCommand - Commande à traîter.
//   > object oPC - Source de la requête.
//   o string - Chaîne vide.
string scmSaveLocCommand(string sCommand, object oPC);

/************************** IMPLEMENTATIONS **************************/

string scmSaveLocCommand(string sCommand, object oPC) {
    // On récupère le nom de la variable choisi par le joueur.
    string sVarName = scmGetParameterValue(sCommand, SCM_PAR_LOCAL_LOCATION_VARIABLE_NAME);
    // On récupère la position actuelle du PJ.
    if (GetIsPC(oPC)) {
        location lLoc = GetLocation(oPC);
        // On sauvegarde la position de façon persistante.
        SetLocalLocation(oPC, sVarName, lLoc);
        SendMessageToPC(oPC, L_YOU_SAVED_THIS_POSITION_IN_THE_VARIABLE+" "+sVarName+".\n"+
                             L_YOU_CAN_REUSE_IT_TO_RETURN_THERE_AUTOMATICALLY);
    }
    return SCM_EMPTY_RESULT;
}

string scmMoveToCommand(string sCommand, object oPC) {
    // Est-ce que le personnage source est valide ?
    if (!GetIsPC(oPC)) {
        return SCM_EMPTY_RESULT; 
    }
    
    // Est-ce qu'on se déplace vers une location ?
    int iToLocation = scmIsParameterDefined(sCommand, SCM_PAR_TO_LOCATION);
    // Est-ce qu'on se déplace vers un waypoint ?
    int iToWaypoint = scmIsParameterDefined(sCommand, SCM_PAR_TO_WAYPOINT);
    
    // Impossible de faire les deux.
    if (iToLocation && iToWaypoint) {
        scmSendCommandErrorMessage(oPC, ERR_IMPOSSIBLE_TO_MOVE_TO_WAYPOINT_AND_TO_RENT);
        return SCM_EMPTY_RESULT;
    }
  
    // Au moins un des deux dois être défini.
    if (!(iToLocation || iToWaypoint)) {
        scmSendCommandErrorMessage(oPC, ERR_MOVING_TYPE_NOT_DEFINED);
        return SCM_EMPTY_RESULT;
    } 
    
    // Variables contenant les informations passées en paramètre de la commande pour déplacer le PJ.
    location lDest;
    string sWaypointTag;
    string sLocalLocationVarName;
    
    if (iToLocation) {
        // On récupère la location de destination.
        sLocalLocationVarName = scmGetParameterValue(sCommand, SCM_PAR_LOCAL_LOCATION_VARIABLE_NAME);
        if (sLocalLocationVarName == SCM_EMPTY_PARAMETER) {
            scmSendCommandErrorMessage(oPC, ERR_VARIABLE_NAME_PARAMETER_NOT_PASSED_ON);
            return SCM_EMPTY_RESULT;
        }
        lDest = GetLocalLocation(oPC, sLocalLocationVarName);
    } else if (iToWaypoint) {
        sWaypointTag = scmGetParameterValue(sCommand, SCM_PAR_WAYPOINT_TAG);
        object oWP = GetWaypointByTag(sWaypointTag);
        if (!GetIsObjectValid(oWP)) {
            scmSendCommandErrorMessage(oPC, ERR_WAYPOINT_DESTINATION_INVALID);
            return SCM_EMPTY_RESULT;
        }
        lDest = GetLocation(oWP);
    }
    
    // Est-ce le PJ va se déplacer en courant ?
    int iRun = scmIsParameterDefined(sCommand, SCM_PAR_RUN);

    // Est-ce qu'on va déplacer le PJ instantanément ?
    int iJump = scmIsParameterDefined(sCommand, SCM_PAR_JUMP);

    // On déplace le personnage jusqu'à la location sauvée.
    usuMoveToLocation(oPC, lDest, iRun, iJump);

    return SCM_EMPTY_RESULT;
}