/**************************************************************************************************/
/** Nom :              cosaf_pcmanips
/** Date de cr�ation : 16/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/******************************************** ChangeLog *******************************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les fonctions relatives � la gestion des personnages.
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
// Dur�e entre chaque essai de jumping.
const float JUMP_ATTEMPT_DELAY = 2.0f;

/******************************************* PROTOTYPES *******************************************/

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de r�cup�rer le Waypoint contenant les donn�es du personnage.
//   > object oPC - Personnage � traiter.
//   o object - Waypoint de donn�e.
object cosGetPCWaypoint(object oPC);

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de cr�er le Waypoint contenant les donn�es du personnage.
//   > object oPC - Personnage � traiter.
//   o object - Waypoint de donn�e.
object cosCreatePCWaypoint(object oPC);

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de sauver un entier stock� sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � r�cup�rer.
//   > int - Integer � stocker.
void cosSaveIntOnPC(object oPC, string sVarName, int iValue);

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de r�cup�rer un entier stock� sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � r�cup�rer.
//   o int - Integer r�cup�r�.
int cosGetIntFromPC(object oPC, string sVarName);

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de sauver une location stock�e sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � stocker.
//   > location - Location � sauvegarder.
void cosSaveLocationOnPC(object oPC, string sVarName, location lLocation);

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de r�cup�rer une location stock�e sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � r�cup�rer.
//   o location - Location r�cup�re.
location cosGetLocationFromPC(object oPC, string sVarName);

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de sauver une cha�ne stock�e sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � stocker.
//   > string - Cha�ne � stocker.
void cosSaveStringOnPC(object oPC, string sVarName, string sString);

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de r�cup�rer une cha�ne stock�e sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � r�cup�rer.
//   o string - cha�ne r�cup�re.
string cosGetStringFromPC(object oPC, string sVarName);

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de sauver un objet stock� sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � r�cup�rer.
//   > object - Objet � stocker.
void cosSaveObjectOnPC(object oPC, string sVarName, object oObject);

// DEF IN "cosaf_pcmanips"
// Fonction qui permet de r�cup�rer un objet stock� sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � r�cup�rer.
//   o object - Objet r�cup�r�.
object cosGetObjectFromPC(object oPC, string sVarName);

// DEF IN "cosaf_pcmanips"
// Cette fonction r�cup�re un identifiant de compte joueur en fonction de son nom.
// Si le nom de compte est nouveau, elle cr�e une entr�e dans la base de donn�e.
//   > string sAccountName - Nom du compte joueur.
//   o int - Identifiant de ce compte.
int cosGetAccountId(string sAccountName);

// DEF IN "cosaf_pcmanips"
// Cette fonction r�cup�re un identifiant de personnage en fonction de son nom.
// Si le personnage est nouveau, elle cr�e une entr�e dans la base de donn�e.
//   > object oPC - PJ concern.
//   o int - Identifiant de ce personnage.
int cosGetPCId(object oPC);

// DEF IN "cosaf_pcmanips"
// Cette fonction r�cup�re un identifiant de clef CD en fonction de son nom.
// Si le nom de compte est nouveau, elle cr�e une entr e dans la base de donn�e.
//   > string sKey - Clef CD du joueur.
//   > int iAccountId - Identifiant du compte associ    ce personnage.
//   o int - Identifiant de cette clef.
int cosGetKeyId(string sKey, int iAccountId);

// DEF IN "cosaf_pcmanips"
// Cette fonction cr�e un lien entre une clef CD et un compte joueur.
//   > int iKeyId - Identifiant de la clef CD.
//   > int iAccountId - Identifiant du compte associ    ce personnage.
//   o int - Identifiant du lien clef/compte joueur.
int cosGetCDKeyAccountLinkId(int iKeyId, int iAccountId);

// DEF IN "cosaf_pcmanips"
// Cette fonction r�cup�re un identifiant de compte en fonction d'un
// identifiant de personnage.
//   > int iKeyId - Identifiant du personnage.
//   o int - Identifiant du compte qui lui est associ .
int cosGetAccountIdFromPCId(int iPCId);

// DEF IN "cosaf_pcmanips"
// Fonction qui charge les identifiants du personnage.
//   > object oPC - Personnage � traiter.
void cosLoadPCIdentifiers(object oPC);

// DEF IN "cosaf_pcmanips"
// Fonction qui charge la position de d�part du personnage.
//   > object oPC - Personnage � traiter.
void cosLoadPCStartingLocation(object oPC);

// DEF IN "cosaf_pcmanips"
// Fonction qui charge les donn�es de la base de donn�e vers un Waypoint de donn�e correspondant au personnage.
//   > object oPC - Personnage dont les identifiants sont � v�rifier.
//   o int - TRUE si les identifiants sont valides, FALSE sinon.
int cosIsPCIdentifiersValid(object oPC);

// DEF IN "cosaf_pcmanips"
// Fonction qui ram ne le personnage � la derni�re position connue.
//   > object oPC - Personnage concern� que l'on veut d�placer.
void cosJumpToPCStartingLocation(object oPC);

// DEF IN "cosaf_pcmanips"
// Fonction qui d termine si la position de d part est valide ou non.
//   > object oPC - Personnage dont on veut tester la position de d part.
//   o int - TRUE si la position de d part est valide, FALSE sinon.
int cosPCStartingLocationValid(object oPC);

// DEF IN "cosaf_pcmanips"
// Fonction qui met   jour la date de la derni�re connexion du personnage et du compte joueur.
//   > object oPC - Personnage concern� par la mise   jour.
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
// Renvoi de la position du PC lors de la derni�re d�connexion.
//   > object oPC - PJ concern�.
//   o location - Point de d�part.
location cosGetPCStartingLocation(object oPC);

// DEF IN "sqlaf_charmanips"
// D�termine si la position de d�part du PC est valide.
//   > object oPC - PJ concern�.
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
    // Si l'identifiant a d�j� �t� stock�, on le renvoie directement.
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

    // On v�rifie que le compte du personnage est le bon.
    if (cosGetAccountIdFromPCId(iPCId) != iAccountId) {
        // Le personnage � �t� d�plac� dans le servervault !
        return FALSE;
    }

    return TRUE;
}

int cosIsBan(object oPC) {
    // On v�rifie si le compte est banni.
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
