/**************************************************************************************************/
/** Nom :              cosaf_pcmanips
/** Date de création : 16/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/******************************************** ChangeLog *******************************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les fonctions relatives à la gestion des personnages.
/**************************************************************************************************/

/******************************************** INCLUDES ********************************************/

            // #include "usuaf_constants"
        // #include "usuaf_strtokman"
    //#include "usuaf_locmanip"
    //#include "sqlaf_constants"
#include "sqlaf_main"
#include "cosaf_constants"

/******************************************* CONSTANTES *******************************************/

// Limite d'essai de la fonction jump to start location.
const int JUMP_ATTEMPT_LIMIT = 10;
// Durée entre chaque essai de jumping.
const float JUMP_ATTEMPT_DELAY = 2.0f;

/******************************************* PROTOTYPES *******************************************/

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de récupérer le Waypoint contenant les données du personnage.
//   > object oPC - Personnage à traiter.
//   o object - Waypoint de donnée.
object cosGetPCWaypoint(object oPC);

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de créer le Waypoint contenant les données du personnage.
//   > object oPC - Personnage à traiter.
//   o object - Waypoint de donnée.
object cosCreatePCWaypoint(object oPC);

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de sauver un entier stocké sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à récupérer.
//   > int - Integer à stocker.
void cosSaveIntOnPC(object oPC, string sVarName, int iValue);

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de récupérer un entier stocké sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à récupérer.
//   o int - Integer récupéré.
int cosGetIntFromPC(object oPC, string sVarName);

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de sauver une location stockée sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à stocker.
//   > location - Location à sauvegarder.
void cosSaveLocationOnPC(object oPC, string sVarName, location lLocation);

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de récupérer une location stockée sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à récupérer.
//   o location - Location récupère.
location cosGetLocationFromPC(object oPC, string sVarName);

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de sauver une chaîne stockée sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à stocker.
//   > string - Chaîne à stocker.
void cosSaveStringOnPC(object oPC, string sVarName, string sString);

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de récupérer une chaîne stockée sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à récupérer.
//   o string - chaîne récupère.
string cosGetStringFromPC(object oPC, string sVarName);

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de sauver un objet stocké sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à récupérer.
//   > object - Objet à stocker.
void cosSaveObjectOnPC(object oPC, string sVarName, object oObject);

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de récupérer un objet stocké sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à récupérer.
//   o object - Objet récupéré.
object cosGetObjectFromPC(object oPC, string sVarName);

// DEF IN "cosaf_pcmanips"
// Cette fonction récupère un identifiant de compte joueur en fonction de son nom.
// Si le nom de compte est nouveau, elle crée une entrée dans la base de donnée.
//   > string sAccountName - Nom du compte joueur.
//   o int - Identifiant de ce compte.
int cosGetAccountId(string sAccountName);

// DEF IN "cosaf_pcmanips"
// Cette fonction récupère un identifiant de personnage en fonction de son nom.
// Si le personnage est nouveau, elle crée une entrée dans la base de donnée.
//   > object oPC - PJ concern.
//   o int - Identifiant de ce personnage.
int cosGetPCId(object oPC);

// DEF IN "cosaf_pcmanips"
// Cette fonction récupère un identifiant de clef CD en fonction de son nom.
// Si le nom de compte est nouveau, elle crée une entr e dans la base de donnée.
//   > string sKey - Clef CD du joueur.
//   > int iAccountId - Identifiant du compte associ    ce personnage.
//   o int - Identifiant de cette clef.
int cosGetKeyId(string sKey, int iAccountId);

// DEF IN "cosaf_pcmanips"
// Cette fonction crée un lien entre une clef CD et un compte joueur.
//   > int iKeyId - Identifiant de la clef CD.
//   > int iAccountId - Identifiant du compte associ    ce personnage.
//   o int - Identifiant du lien clef/compte joueur.
int cosGetCDKeyAccountLinkId(int iKeyId, int iAccountId);

// DEF IN "cosaf_pcmanips"
// Cette fonction récupère un identifiant de compte en fonction d'un
// identifiant de personnage.
//   > int iKeyId - Identifiant du personnage.
//   o int - Identifiant du compte qui lui est associ .
int cosGetAccountIdFromPCId(int iPCId);

// DEF IN "cosaf_pcmanips"
// Fonction qui charge les identifiants du personnage.
//   > object oPC - Personnage à traiter.
void cosLoadPCIdentifiers(object oPC);

// DEF IN "cosaf_pcmanips"
// Fonction qui charge la position de départ du personnage.
//   > object oPC - Personnage à traiter.
void cosLoadPCStartingLocation(object oPC);

// DEF IN "cosaf_pcmanips"
// Fonction qui charge les données de la base de donnée vers un Waypoint de donnée correspondant au personnage.
//   > object oPC - Personnage dont les identifiants sont à vérifier.
//   o int - TRUE si les identifiants sont valides, FALSE sinon.
int cosIsPCIdentifiersValid(object oPC);

// DEF IN "cosaf_pcmanips"
// Fonction qui ram ne le personnage à la dernière position connue.
//   > object oPC - Personnage concerné que l'on veut déplacer.
void cosJumpToPCStartingLocation(object oPC);

// DEF IN "cosaf_pcmanips"
// Fonction qui d termine si la position de d part est valide ou non.
//   > object oPC - Personnage dont on veut tester la position de d part.
//   o int - TRUE si la position de d part est valide, FALSE sinon.
int cosPCStartingLocationValid(object oPC);

// DEF IN "cosaf_pcmanips"
// Fonction qui met   jour la date de la dernière connexion du personnage et du compte joueur.
//   > object oPC - Personnage concerné par la mise   jour.
void cosUpdateLastConnexion(object oPC);

// DEF IN "cosaf_pcmanips"
// Cette fonction d termine si le compte est bloqu .
//   > int iAccountId - Identifiant du compte.
//   o int - TRUE si le compte est bloqu , FALSE sinon.
int cosIsAccountBan(int iAccountId);

// DEF IN "cosaf_pcmanips"
// Cette fonction d termine si le PC est bloqu .
//   > int iAccountId - Identifiant du PC.
//   o int - TRUE si le PC est bloqu , FALSE sinon.
int cosIsPCBan(int iPCId);

// DEF IN "cosaf_pcmanips"
// Cette fonction d termine si la clef CD est bloqu e.
//   > int iKeyId - Identifiant de la clef.
//   o int - TRUE si la clef est bloqu e, FALSE sinon.
int cosIsKeyBan(int iKeyId);

// DEF IN "sqlaf_charmanips"
// Renvoi de la position du PC lors de la dernière déconnexion.
//   > object oPC - PJ concerné.
//   o location - Point de départ.
location cosGetPCStartingLocation(object oPC);

// DEF IN "sqlaf_charmanips"
// Détermine si la position de départ du PC est valide.
//   > object oPC - PJ concerné.
//   o int - TRUE si la position est valide, FALSE sinon.
int cosPCStartingLocationValid(object oPC);

/**************************************** IMPLEMENTATIONS *****************************************/

object cosGetPCWaypoint(object oPC) {
    object oPCWP = GetLocalObject(oPC, COS_WP_CHARDATA_VARNAME);
    if (!GetIsObjectValid(oPCWP)) {
        oPCWP = CreateObject(OBJECT_TYPE_WAYPOINT, COS_WP_CHARDATA_RESREF, GetStartingLocation(), FALSE, COS_WP_CHARDATA_TAG);
        if (GetIsObjectValid(oPCWP)) {
            SetLocalObject(oPC, COS_WP_CHARDATA_VARNAME, oPCWP);
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

int cosGetAccountId(string sAccountName) {
    return sqlEAFDSingleIntOrInsert(
        "SELECT "+COS_SQLF_ID+" FROM "+COS_SQLT_ACCOUNT+" WHERE "+COS_SQLF_NAME+" = "+sqlQuote(sAccountName)+";",
        "INSERT INTO "+COS_SQLT_ACCOUNT+" ("+COS_SQLF_NAME+", "+COS_SQLF_CREATION+", "+COS_SQLF_LAST_CNX+") VALUES ("+sqlQuote(sAccountName)+", NOW(), NOW());"
    );
}

int cosGetPCId(object oPC) {
    // Si l'identifiant a déjà été stocké, on le renvoie directement.
    int iId = cosGetIntFromPC(oPC, COS_PC_ID);
    if (iId != 0) {
       return iId;
    }
    // Sinon on va le chercher dans la BDD.       
    string sPCName = GetName(oPC);
    string sAccountId = IntToString(cosGetAccountId(GetPCPlayerName(oPC)));
    return sqlEAFDSingleIntOrInsert(
        "SELECT "+COS_SQLF_ID+" FROM "+COS_SQLT_CHAR+" WHERE "+COS_SQLF_NAME+" = "+sqlQuote(sPCName)+";",
        "INSERT INTO "+COS_SQLT_CHAR+" ("+COS_SQLF_ID_ACCOUNT+", "+COS_SQLF_NAME+", "+COS_SQLF_CREATION+", "+COS_SQLF_LAST_CNX+") VALUES ("+sAccountId+", "+sqlQuote(sPCName)+", NOW(), NOW());"
    );
}

int cosGetKeyId(string sKey, int iAccountId) {
    return sqlEAFDSingleIntOrInsert(
        "SELECT "+COS_SQLF_ID+" FROM "+COS_SQLT_CDKEY+" WHERE "+COS_SQLF_CDKEY+" = '"+sKey+"';",
        "INSERT INTO "+COS_SQLT_CDKEY+" ("+COS_SQLF_CDKEY+") VALUES ('"+sKey+"');"
    );
}

int cosGetCDKeyAccountLinkId(int iKeyId, int iAccountId) {
    string sKeyId = IntToString(iKeyId);
    string sAccountId = IntToString(iAccountId);
    return sqlEAFDSingleIntOrInsert(
        "SELECT "+COS_SQLF_ID+" FROM "+COS_SQLT_CDKEY_TO_ACCOUNT+" WHERE "+COS_SQLF_ID_CDKEY+" = "+sKeyId+" AND "+COS_SQLF_ID_ACCOUNT+" = "+sAccountId+";",
        "INSERT INTO "+COS_SQLT_CDKEY_TO_ACCOUNT+" ("+COS_SQLF_ID_ACCOUNT+", "+COS_SQLF_ID_CDKEY+") VALUES ("+sAccountId+", "+sKeyId+")"
    );
}

int cosGetAccountIdFromPCId(int iPCId) {
    return sqlEAFDSingleInt("SELECT "+COS_SQLF_ID_ACCOUNT+" FROM "+COS_SQLT_CHAR+" WHERE "+COS_SQLF_ID+" = "+IntToString(iPCId)+";");
}

void cosLoadPCIdentifiers(object oPC) {
    int iPCId = cosGetPCId(oPC);
    int iAccountId = cosGetAccountId(GetPCPlayerName(oPC));
    int iKeyId = cosGetKeyId(GetPCPublicCDKey(oPC), iAccountId);
    int iLinkId = cosGetCDKeyAccountLinkId(iKeyId, iAccountId);
    cosSaveIntOnPC(oPC, COS_PC_ACCOUNT_ID, iAccountId);
    cosSaveIntOnPC(oPC, COS_PC_ID, iPCId);
    cosSaveIntOnPC(oPC, COS_PC_KEY_ID, iKeyId);
    cosSaveIntOnPC(oPC, COS_PC_KEY_ACCOUNT_LINK_ID, iLinkId);
}

void cosLoadPCStartingLocation(object oPC) {
    cosSaveLocationOnPC(oPC, COS_PC_STARTLOC, cosGetPCStartingLocation(oPC));
}

int cosIsPCIdentifiersValid(object oPC) {
    int iAccountId = cosGetIntFromPC(oPC, COS_PC_ACCOUNT_ID);
    int iKeyId = cosGetIntFromPC(oPC, COS_PC_KEY_ID);
    int iPCId = cosGetIntFromPC(oPC, COS_PC_ID);
    int iKeyAccountLinkId = cosGetIntFromPC(oPC, COS_PC_KEY_ACCOUNT_LINK_ID);

    if (iAccountId == SQL_ERROR || iKeyId == SQL_ERROR || iPCId == SQL_ERROR || iKeyAccountLinkId == SQL_ERROR) {
        return FALSE;
    }

    // On vérifie que le compte du personnage est le bon.
    if (cosGetAccountIdFromPCId(iPCId) != iAccountId) {
        // Le personnage à été déplacé dans le servervault !
        return FALSE;
    }

    return TRUE;
}

int cosIsBan(object oPC) {
    // On vérifie si le compte est banni.
    if (cosIsAccountBan(cosGetIntFromPC(oPC, COS_PC_ACCOUNT_ID)) ||
        cosIsKeyBan(cosGetIntFromPC(oPC, COS_PC_KEY_ID)) ||
        cosIsPCBan(cosGetIntFromPC(oPC, COS_PC_ID))) {
        return TRUE;
    }
    return FALSE;
}

void cosUpdateLastConnexion(object oPC) {
    sqlExecDirect("UPDATE "+COS_SQLT_CHAR+" SET "+COS_SQLF_LAST_CNX+" = NOW() WHERE "+COS_SQLF_ID+" = "+IntToString(cosGetIntFromPC(oPC, COS_PC_ID))+";");
    sqlExecDirect("UPDATE "+COS_SQLT_ACCOUNT+" SET "+COS_SQLF_LAST_CNX+" = NOW() WHERE "+COS_SQLF_ID+" = "+IntToString(cosGetIntFromPC(oPC, COS_PC_ACCOUNT_ID))+";");
}

/* Private function pour :
- cosJumpToPCStartingLocation */
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
    pv_cosJumpPC(oPC, cosGetLocationFromPC(oPC, COS_PC_STARTLOC));
}

/* Private function pour :
- cosIsAccountBan
- cosIsPCBan
- cosIsKeyBan */
int pv_cosIsBan(string sTable, int iId) {
    return sqlEAFDSingleInt("SELECT "+COS_SQLF_BAN+" FROM "+sTable+" WHERE "+COS_SQLF_ID+" = "+IntToString(iId)+";");
}

int cosIsAccountBan(int iAccountId) {
    return pv_cosIsBan(COS_SQLT_ACCOUNT, iAccountId);
}

int cosIsPCBan(int iPCId) {
    return pv_cosIsBan(COS_SQLT_CHAR, iPCId);
}

int cosIsKeyBan(int iKeyId) {
    return pv_cosIsBan(COS_SQLT_CDKEY, iKeyId);
}

location cosGetPCStartingLocation(object oPC) {
    return sqlEAFDSingleLocation("SELECT "+COS_SQLF_START_LOC+" FROM "+COS_SQLT_CHAR+" WHERE "+COS_SQLF_ID+" = "+IntToString(cosGetPCId(oPC))+";");
}

int cosPCStartingLocationValid(object oPC) {
    sqlExecDirect("SELECT "+COS_SQLF_START_LOC+" FROM "+COS_SQLT_CHAR+" WHERE "+COS_SQLF_ID+" = "+IntToString(cosGetPCId(oPC))+";");
    sqlFetch();
    string sRes = sqlGetData(1);
    return (sRes != "");
}
