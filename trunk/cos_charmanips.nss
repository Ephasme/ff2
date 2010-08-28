/*********************************************************************/
/** Nom :              cos_charmanips
/** Date de création : 16/07/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les fonctions relatives à la gestion des
/**    personnages.
/*********************************************************************/

/***************************** INCLUDES ******************************/

        // #include "usu_locmanip"
    // #include "sql_main"
#include "sql_charmanips"

/***************************** CONSTANTES ****************************/

// Nom du waypoint associé à chaque personnage. Ce waypoint contient toutes les données
// du personnage, ce qui permet d'éviter leur modification en mode DM.
const string COS_PC_WP_VARNAME = "xx_cos_wp000_char_data";
const string COS_PC_WP_TAG = "xx_cos_wp000_char_data";
const string COS_PC_WP_RESREF = "cos_wp000_chdt";

// Variables stockant les données du personnage.
const string PC_ID = "PC_ID";
const string PC_ACCOUNT_ID = "PC_ACCOUNT_ID";
const string PC_KEY_ID = "PC_KEY_ID";
const string PC_KEY_ACCOUNT_LINK_ID = "PC_KEY_ACCOUNT_LINK_ID";
const string PC_STARTING_LOCATION = "PC_STARTING_LOCATION";

// Limite d'essai de la fonction jump to start location.
const int JUMP_ATTEMPT_LIMIT = 10;
// Durée entre chaque essai de jumping.
const float JUMP_ATTEMPT_DELAY = 2.0f;

/***************************** PROTOTYPES ****************************/

// DEF IN "cos_charmanips"
// Fonction qui permet de récupérer le Waypoint contenant les données du personnage.
//   > object oPC - Personnage à traiter.
//   o object - Waypoint de donnée.
object cosGetPCWaypoint(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui permet de créer le Waypoint contenant les données du personnage.
//   > object oPC - Personnage à traiter.
//   o object - Waypoint de donnée.
object cosCreatePCWaypoint(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui permet de sauver un entier stocké sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à récupérer.
//   > int - Integer à stocker.
void cosSaveIntOnPC(object oPC, string sVarName, int iValue);

// DEF IN "cos_charmanips"
// Fonction qui permet de récupérer un entier stocké sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à récupérer.
//   o int - Integer récupéré.
int cosGetIntFromPC(object oPC, string sVarName);

// DEF IN "cos_charmanips"
// Fonction qui permet de sauver une location stockée sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à stocker.
//   > location - Location à sauvegarder.
void cosSaveLocationOnPC(object oPC, string sVarName, location lLocation);

// DEF IN "cos_charmanips"
// Fonction qui permet de récupérer une location stockée sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à récupérer.
//   o location - Location récupérée.
location cosGetLocationFromPC(object oPC, string sVarName);

// DEF IN "cos_charmanips"
// Fonction qui permet de sauver une chaîne stockée sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à stocker.
//   > string - Chaîne à stocker.
void cosSaveStringOnPC(object oPC, string sVarName, string sString);

// DEF IN "cos_charmanips"
// Fonction qui permet de récupérer une chaîne stockée sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à récupérer.
//   o string - Chaîne récupérée.
string cosGetStringFromPC(object oPC, string sVarName);

// DEF IN "cos_charmanips"
// Fonction qui permet de sauver un objet stocké sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à récupérer.
//   > object - Objet à stocker.
void cosSaveObjectOnPC(object oPC, string sVarName, object oObject);

// DEF IN "cos_charmanips"
// Fonction qui permet de récupérer un objet stocké sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à récupérer.
//   o object - Objet récupéré.
object cosGetObjectFromPC(object oPC, string sVarName);

// DEF IN "cos_charmanips"
// Fonction qui charge les identifiants du personnage.
//   > object oPC - Personnage à traiter.
void cosLoadPCIdentifiers(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui charge la position de départ du personnage.
//   > object oPC - Personnage à traiter.
void cosLoadPCStartingLocation(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui charge les données de la base de donnée vers un Waypoint de donnée correspondant au personnage.
//   > object oPC - Personnage dont les identifiants sont à vérifier.
//   o int - TRUE si les identifiants sont valides, FALSE sinon.
int cosIsPCIdentifiersValid(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui met à jour la date de la dernière connexion du personnage et du compte joueur.
//   > object oPC - Personnage concerné par la mise à jour.
void cosUpdateLastConnexion(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui ramène le personnage à la dernière position connue.
//   > object oPC - Personnage concerné que l'on veut déplacer.
void cosJumpToPCStartingLocation(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui détermine si la position de départ est valide ou non.
//   > object oPC - Personnage dont on veut tester la position de départ.
//   o int - TRUE si la position de départ est valide, FALSE sinon.
int cosPCStartingLocationValid(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui envoie le personnage au centre de formation.
//   > object oPC - Personnage concerné que l'on veut déplacer.
void cosJumpPCToTrainingCenter(object oPC);

/************************** IMPLEMENTATIONS **************************/

object cosGetPCWaypoint(object oPC) {
    object oPCWP = GetLocalObject(oPC, COS_PC_WP_VARNAME);
    if (!GetIsObjectValid(oPCWP)) {
        oPCWP = CreateObject(OBJECT_TYPE_WAYPOINT, COS_PC_WP_RESREF, GetStartingLocation(), FALSE, COS_PC_WP_TAG);
        if (GetIsObjectValid(oPCWP)) {
            SetLocalObject(oPC, COS_PC_WP_VARNAME, oPCWP);
        }
    }
    return oPCWP;
}

void cosSaveIntOnPC(object oPC, string sVarName, int iValue) {
    object oPCWP = cosGetPCWaypoint(oPC);
    if (GetIsObjectValid(oPCWP)) {
        SetLocalInt(oPCWP, sVarName, iValue);
    }
}

int cosGetIntFromPC(object oPC, string sVarName) {
    int iRes;
    object oPCWP = cosGetPCWaypoint(oPC);
    if (GetIsObjectValid(oPCWP)) {
        iRes = GetLocalInt(oPCWP, sVarName);
    }
    return iRes;
}

void cosSaveLocationOnPC(object oPC, string sVarName, location lLocation) {
    object oPCWP = cosGetPCWaypoint(oPC);
    if (GetIsObjectValid(oPCWP)) {
        SetLocalLocation(oPCWP, sVarName, lLocation);
    }
}

location cosGetLocationFromPC(object oPC, string sVarName) {
    location lLoc;
    object oPCWP = cosGetPCWaypoint(oPC);
    if (GetIsObjectValid(oPCWP)) {
        lLoc = GetLocalLocation(oPCWP, sVarName);
    }
    return lLoc;
}

void cosSaveStringOnPC(object oPC, string sVarName, string sString) {
    object oPCWP = cosGetPCWaypoint(oPC);
    if (GetIsObjectValid(oPCWP)) {
        SetLocalString(oPCWP, sVarName, sString);
    }
}

string cosGetStringFromPC(object oPC, string sVarName) {
    string sRes;
    object oPCWP = cosGetPCWaypoint(oPC);
    if (GetIsObjectValid(oPCWP)) {
        sRes = GetLocalString(oPCWP, sVarName);
    }
    return sRes;
}

void cosSaveObjectOnPC(object oPC, string sVarName, object oObject) {
    object oPCWP = cosGetPCWaypoint(oPC);
    if (GetIsObjectValid(oPCWP)) {
        SetLocalObject(oPCWP, sVarName, oObject);
    }
}

object cosGetObjectFromPC(object oPC, string sVarName) {
    object oRes;
    object oPCWP = cosGetPCWaypoint(oPC);
    if (GetIsObjectValid(oPCWP)) {
        oRes = GetLocalObject(oPCWP, sVarName);
    }
    return oRes;
}

void cosLoadPCIdentifiers(object oPC) {
    int iAccountId = sqlGetAccountId(GetPCPlayerName(oPC));
    int iKeyId = sqlGetKeyId(GetPCPublicCDKey(oPC), iAccountId);
    cosSaveIntOnPC(oPC, PC_ACCOUNT_ID, iAccountId);
    cosSaveIntOnPC(oPC, PC_ID, sqlGetPCId(GetName(oPC), iAccountId));
    cosSaveIntOnPC(oPC, PC_KEY_ID, iKeyId);
    cosSaveIntOnPC(oPC, PC_KEY_ACCOUNT_LINK_ID, sqlGetCDKeyAccountLinkId(iKeyId, iAccountId));
}

void cosLoadPCStartingLocation(object oPC) {
    location lLoc = sqlGetPCStartingLocation(cosGetIntFromPC(oPC, PC_ID));
    cosSaveLocationOnPC(oPC, PC_STARTING_LOCATION, lLoc);
}

int cosIsPCIdentifiersValid(object oPC) {
    int iAccountId = cosGetIntFromPC(oPC, PC_ACCOUNT_ID);
    int iKeyId = cosGetIntFromPC(oPC, PC_KEY_ID);
    int iPCId = cosGetIntFromPC(oPC, PC_ID);
    int iKeyAccountLinkId = cosGetIntFromPC(oPC, PC_KEY_ACCOUNT_LINK_ID);

    if (iAccountId == SQL_ERROR || iKeyId == SQL_ERROR || iPCId == SQL_ERROR || iKeyAccountLinkId == SQL_ERROR) {
        return FALSE;
    }

    // On vérifie que le compte du personnage est le bon.
    if (sqlGetAccountIdFromPCId(iPCId) != iAccountId) {
        // Le personnage à été déplacé dans le servervault !
        return FALSE;
    }

    return TRUE;
}

void cosUpdateLastConnexion(object oPC) {
    sqlUpdateLastConnexion(cosGetIntFromPC(oPC, PC_ID), cosGetIntFromPC(oPC, PC_ACCOUNT_ID));
}

int cosIsBan(object oPC) {
    // On vérifie si le compte est banni.
    if (sqlIsAccountBan(cosGetIntFromPC(oPC, PC_ACCOUNT_ID)) ||
        sqlIsKeyBan(cosGetIntFromPC(oPC, PC_KEY_ID)) ||
        sqlIsPCBan(cosGetIntFromPC(oPC, PC_ID))) {
        return TRUE;
    }
    return FALSE;
}

/* Private function */
void pv_cosJumpPC(object oPC, location lLoc, int iAttempt = 0) {
    // On s'arrête au nombre d'essai maximal configuré par constante.
    if (iAttempt < JUMP_ATTEMPT_LIMIT) {
        // On attend que le personnage soit dans une zone valide pour le téléporter.
        if (GetArea(oPC) == OBJECT_INVALID) {
            // On relance la commande dans deux secondes.
            DelayCommand(JUMP_ATTEMPT_DELAY, pv_cosJumpPC(oPC, lLoc, ++iAttempt));
        }
        // Personnage correctement disposé pour le saut.
        AssignCommand(oPC, JumpToLocation(lLoc));
    }
}

void cosJumpToPCStartingLocation(object oPC) {
    pv_cosJumpPC(oPC, cosGetLocationFromPC(oPC, PC_STARTING_LOCATION));
}

int cosPCStartingLocationValid(object oPC) {
    return sqlPCStartingLocationValid(cosGetIntFromPC(oPC, PC_ID));
}