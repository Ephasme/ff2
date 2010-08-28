/*********************************************************************/
/** Nom :              cos_charmanips
/** Date de cr�ation : 16/07/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les fonctions relatives � la gestion des
/**    personnages.
/*********************************************************************/

/***************************** INCLUDES ******************************/

        // #include "usu_locmanip"
    // #include "sql_main"
#include "sql_charmanips"

/***************************** CONSTANTES ****************************/

// Nom du waypoint associ� � chaque personnage. Ce waypoint contient toutes les donn�es
// du personnage, ce qui permet d'�viter leur modification en mode DM.
const string COS_PC_WP_VARNAME = "xx_cos_wp000_char_data";
const string COS_PC_WP_TAG = "xx_cos_wp000_char_data";
const string COS_PC_WP_RESREF = "cos_wp000_chdt";

// Variables stockant les donn�es du personnage.
const string PC_ID = "PC_ID";
const string PC_ACCOUNT_ID = "PC_ACCOUNT_ID";
const string PC_KEY_ID = "PC_KEY_ID";
const string PC_KEY_ACCOUNT_LINK_ID = "PC_KEY_ACCOUNT_LINK_ID";
const string PC_STARTING_LOCATION = "PC_STARTING_LOCATION";

// Limite d'essai de la fonction jump to start location.
const int JUMP_ATTEMPT_LIMIT = 10;
// Dur�e entre chaque essai de jumping.
const float JUMP_ATTEMPT_DELAY = 2.0f;

/***************************** PROTOTYPES ****************************/

// DEF IN "cos_charmanips"
// Fonction qui permet de r�cup�rer le Waypoint contenant les donn�es du personnage.
//   > object oPC - Personnage � traiter.
//   o object - Waypoint de donn�e.
object cosGetPCWaypoint(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui permet de cr�er le Waypoint contenant les donn�es du personnage.
//   > object oPC - Personnage � traiter.
//   o object - Waypoint de donn�e.
object cosCreatePCWaypoint(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui permet de sauver un entier stock� sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � r�cup�rer.
//   > int - Integer � stocker.
void cosSaveIntOnPC(object oPC, string sVarName, int iValue);

// DEF IN "cos_charmanips"
// Fonction qui permet de r�cup�rer un entier stock� sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � r�cup�rer.
//   o int - Integer r�cup�r�.
int cosGetIntFromPC(object oPC, string sVarName);

// DEF IN "cos_charmanips"
// Fonction qui permet de sauver une location stock�e sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � stocker.
//   > location - Location � sauvegarder.
void cosSaveLocationOnPC(object oPC, string sVarName, location lLocation);

// DEF IN "cos_charmanips"
// Fonction qui permet de r�cup�rer une location stock�e sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � r�cup�rer.
//   o location - Location r�cup�r�e.
location cosGetLocationFromPC(object oPC, string sVarName);

// DEF IN "cos_charmanips"
// Fonction qui permet de sauver une cha�ne stock�e sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � stocker.
//   > string - Cha�ne � stocker.
void cosSaveStringOnPC(object oPC, string sVarName, string sString);

// DEF IN "cos_charmanips"
// Fonction qui permet de r�cup�rer une cha�ne stock�e sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � r�cup�rer.
//   o string - Cha�ne r�cup�r�e.
string cosGetStringFromPC(object oPC, string sVarName);

// DEF IN "cos_charmanips"
// Fonction qui permet de sauver un objet stock� sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � r�cup�rer.
//   > object - Objet � stocker.
void cosSaveObjectOnPC(object oPC, string sVarName, object oObject);

// DEF IN "cos_charmanips"
// Fonction qui permet de r�cup�rer un objet stock� sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � r�cup�rer.
//   o object - Objet r�cup�r�.
object cosGetObjectFromPC(object oPC, string sVarName);

// DEF IN "cos_charmanips"
// Fonction qui charge les identifiants du personnage.
//   > object oPC - Personnage � traiter.
void cosLoadPCIdentifiers(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui charge la position de d�part du personnage.
//   > object oPC - Personnage � traiter.
void cosLoadPCStartingLocation(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui charge les donn�es de la base de donn�e vers un Waypoint de donn�e correspondant au personnage.
//   > object oPC - Personnage dont les identifiants sont � v�rifier.
//   o int - TRUE si les identifiants sont valides, FALSE sinon.
int cosIsPCIdentifiersValid(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui met � jour la date de la derni�re connexion du personnage et du compte joueur.
//   > object oPC - Personnage concern� par la mise � jour.
void cosUpdateLastConnexion(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui ram�ne le personnage � la derni�re position connue.
//   > object oPC - Personnage concern� que l'on veut d�placer.
void cosJumpToPCStartingLocation(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui d�termine si la position de d�part est valide ou non.
//   > object oPC - Personnage dont on veut tester la position de d�part.
//   o int - TRUE si la position de d�part est valide, FALSE sinon.
int cosPCStartingLocationValid(object oPC);

// DEF IN "cos_charmanips"
// Fonction qui envoie le personnage au centre de formation.
//   > object oPC - Personnage concern� que l'on veut d�placer.
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

    // On v�rifie que le compte du personnage est le bon.
    if (sqlGetAccountIdFromPCId(iPCId) != iAccountId) {
        // Le personnage � �t� d�plac� dans le servervault !
        return FALSE;
    }

    return TRUE;
}

void cosUpdateLastConnexion(object oPC) {
    sqlUpdateLastConnexion(cosGetIntFromPC(oPC, PC_ID), cosGetIntFromPC(oPC, PC_ACCOUNT_ID));
}

int cosIsBan(object oPC) {
    // On v�rifie si le compte est banni.
    if (sqlIsAccountBan(cosGetIntFromPC(oPC, PC_ACCOUNT_ID)) ||
        sqlIsKeyBan(cosGetIntFromPC(oPC, PC_KEY_ID)) ||
        sqlIsPCBan(cosGetIntFromPC(oPC, PC_ID))) {
        return TRUE;
    }
    return FALSE;
}

/* Private function */
void pv_cosJumpPC(object oPC, location lLoc, int iAttempt = 0) {
    // On s'arr�te au nombre d'essai maximal configur� par constante.
    if (iAttempt < JUMP_ATTEMPT_LIMIT) {
        // On attend que le personnage soit dans une zone valide pour le t�l�porter.
        if (GetArea(oPC) == OBJECT_INVALID) {
            // On relance la commande dans deux secondes.
            DelayCommand(JUMP_ATTEMPT_DELAY, pv_cosJumpPC(oPC, lLoc, ++iAttempt));
        }
        // Personnage correctement dispos� pour le saut.
        AssignCommand(oPC, JumpToLocation(lLoc));
    }
}

void cosJumpToPCStartingLocation(object oPC) {
    pv_cosJumpPC(oPC, cosGetLocationFromPC(oPC, PC_STARTING_LOCATION));
}

int cosPCStartingLocationValid(object oPC) {
    return sqlPCStartingLocationValid(cosGetIntFromPC(oPC, PC_ID));
}