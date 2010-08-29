/**************************************************************************************************/
/** Nom :              cos_charmanips
/** Date de cr ation : 16/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/******************************************** ChangeLog *******************************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les fonctions relatives à la gestion des personnages.
/**************************************************************************************************/

/******************************************** INCLUDES ********************************************/

            // #include "usu_stringtokman"
        // #include "usu_locmanip"
        // #include "sql_constants"
    // #include "sql_main"
#include "sql_charmanips"
#include "cos_constants"

/******************************************* CONSTANTES *******************************************/

// Limite d'essai de la fonction jump to start location.
const int JUMP_ATTEMPT_LIMIT = 10;
// Durée entre chaque essai de jumping.
const float JUMP_ATTEMPT_DELAY = 2.0f;

/******************************************* PROTOTYPES *******************************************/

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
//   o location - Location récupère.
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
//   o string - chaîne récupère.
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
//   > object oPC - Personnage   traiter.
void cosLoadPCIdentifiers(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui charge la position de d part du personnage.
//   > object oPC - Personnage   traiter.
void cosLoadPCStartingLocation(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui charge les données de la base de donnée vers un Waypoint de donnée correspondant au personnage.
//   > object oPC - Personnage dont les identifiants sont   v rifier.
//   o int - TRUE si les identifiants sont valides, FALSE sinon.
int cosIsPCIdentifiersValid(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui met   jour la date de la dernière connexion du personnage et du compte joueur.
//   > object oPC - Personnage concern  par la mise   jour.
void cosUpdateLastConnexion(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui ram ne le personnage   la dernière position connue.
//   > object oPC - Personnage concern  que l'on veut d placer.
void cosJumpToPCStartingLocation(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui d termine si la position de d part est valide ou non.
//   > object oPC - Personnage dont on veut tester la position de d part.
//   o int - TRUE si la position de d part est valide, FALSE sinon.
int cosPCStartingLocationValid(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui envoie le personnage au centre de formation.
//   > object oPC - Personnage concern  que l'on veut d placer.
void cosJumpPCToTrainingCenter(object oPC);

/**************************************** IMPLEMENTATIONS *****************************************/

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

    // On v rifie que le compte du personnage est le bon.
    if (sqlGetAccountIdFromPCId(iPCId) != iAccountId) {
        // Le personnage   été déplacé dans le servervault !
        return FALSE;
    }

    return TRUE;
}

void cosUpdateLastConnexion(object oPC) {
    sqlUpdateLastConnexion(cosGetIntFromPC(oPC, PC_ID), cosGetIntFromPC(oPC, PC_ACCOUNT_ID));
}

int cosIsBan(object oPC) {
    // On v rifie si le compte est banni.
    if (sqlIsAccountBan(cosGetIntFromPC(oPC, PC_ACCOUNT_ID)) ||
        sqlIsKeyBan(cosGetIntFromPC(oPC, PC_KEY_ID)) ||
        sqlIsPCBan(cosGetIntFromPC(oPC, PC_ID))) {
        return TRUE;
    }
    return FALSE;
}

/* Private function */
void pv_cosJumpPC(object oPC, location lLoc, int iAttempt = 0) {
    // On s'arr te au nombre d'essai maximal configur  par constante.
    if (iAttempt < JUMP_ATTEMPT_LIMIT) {
        // On attend que le personnage soit dans une zone valide pour le t l porter.
        if (GetArea(oPC) == OBJECT_INVALID) {
            // On relance la commande dans deux secondes.
            DelayCommand(JUMP_ATTEMPT_DELAY, pv_cosJumpPC(oPC, lLoc, ++iAttempt));
        }
        // Personnage correctement dispos  pour le saut.
        AssignCommand(oPC, JumpToLocation(lLoc));
    }
}

void cosJumpToPCStartingLocation(object oPC) {
    pv_cosJumpPC(oPC, cosGetLocationFromPC(oPC, PC_STARTING_LOCATION));
}

int cosPCStartingLocationValid(object oPC) {
    return sqlPCStartingLocationValid(cosGetIntFromPC(oPC, PC_ID));
}
