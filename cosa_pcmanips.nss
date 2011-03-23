/**************************************************************************************************/
/** Nom :              cosa_pcmanips
/** Date de création : 16/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/******************************************** ChangeLog *******************************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les fonctions relatives à la gestion des personnages.
/**************************************************************************************************/

/******************************************** INCLUDES ********************************************/

#include "sqla_main"
#include "usua_locmanips"
#include "cosa_constants"

/******************************************* PROTOTYPES *******************************************/

// DEF IN "cosa_pcmanips"
// Fonction qui permet de récupérer le Waypoint contenant les données du personnage.
//   > object oPC - Personnage à traiter.
//   o object - Waypoint de donnée.
object cosGetPCWaypoint(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui permet de créer le Waypoint contenant les données du personnage.
//   > object oPC - Personnage à traiter.
//   o object - Waypoint de donnée.
object cosCreatePCWaypoint(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui permet de sauver un couple valeur/PJ dans la base de donnée.
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à stocker.
//   > string sValue - Donnée à sauvegarder.
void cosSaveLocalValue(object oPC, string sVarName, string sValue);

// DEF IN "cosa_pcmanips"
// Fonction qui permet de sauver un entier stocké sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à récupérer.
//   > int iPersistant - TRUE par défaut. La valeur est stockée en base de donnée.
//   > int - Integer à stocker.
void cosSetLocalInt(object oPC, string sVarName, int iValue, int iPersistant = TRUE);

// DEF IN "cosa_pcmanips"
// Fonction qui permet de récupérer un entier stocké sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à récupérer.
//   > int iPersistant - TRUE par défaut. Si la recherche est infructueuse, la fonction regarde
//                       dans la base de donnée.
//   o int - Integer récupéré.
int cosGetLocalInt(object oPC, string sVarName, int iPersistant = TRUE);

// DEF IN "cosa_pcmanips"
// Fonction qui permet de sauver une chaîne stockée sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à stocker.
//   > int iPersistant - TRUE par défaut. La valeur est stockée en base de donnée.
//   > string - Chaîne à stocker.
void cosSetLocalString(object oPC, string sVarName, string sString, int iPersistant = TRUE);

// DEF IN "cosa_pcmanips"
// Fonction qui permet de récupérer une chaîne stockée sur un PJ (à travers le Waypoint de donnée).
//   > object oPC - Personnage concerné.
//   > string sVarName - Nom de la variable contenant la valeur à récupérer.
//   > int iPersistant - TRUE par défaut. Si la recherche est infructueuse, la fonction regarde
//                       dans la base de donnée.
//   o string - chaîne récupère.
string cosGetLocalString(object oPC, string sVarName, int iPersistant = TRUE);

// TODO : à documenter.
void cosSetLocalLocation(object oPC, string sVarName, location lLoc, int iPersistant = TRUE);

// TODO : à documenter.
location cosGetLocalLocation(object oPC, string sVarName, int iPersistant = TRUE);

// DEF IN "cosa_pcmanips"
// Fonction qui renvoie l'identifiant du personnage.
//   > object oPC - Personnage concerné.
//   o int - Identifiant.
int cosGetPCId(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui teste si le personnage est nouveau sur le serveur.
//   > object oPC - Personnage concerné.
//   o int - TRUE s'il est nouveau, FALSE sinon.
int cosIsNewPC(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui crée un nouvel identifiant de personnage.
// Si nécessaire elle crée aussi un nouvel identifiant de compte, de clef CD
// et elle lie le compte avec la clef.
//   > object oPC - Personnage concerné.
void cosCreatePCId(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui renvoie l'identifiant du compte.
//   > object oPC - Personnage concerné.
//   o int - Identifiant.
int cosGetAccountId(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui teste si le compte est nouveau sur le serveur.
//   > object oPC - Personnage concerné.
//   o int - TRUE s'il est nouveau, FALSE sinon.
int cosHasNewAccount(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui crée un nouvel identifiant de compte.
//   > object oPC - Personnage concerné.
void cosCreateAccountId(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui renvoie l'identifiant de la clef CD.
//   > object oPC - Personnage concerné.
//   o int - Identifiant.
int cosGetPublicCDKeyId(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui teste si la clef CD est nouvelle sur le serveur.
//   > object oPC - Personnage concerné.
//   o int - TRUE si elle est nouvelle, FALSE sinon.
int cosHasNewPublicCDKey(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui crée un nouvel identifiant de clef CD.
//   > object oPC - Personnage concerné.
void cosCreatePublicCDKeyId(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui crée un lien entre la clef CD et le compte du personnage.
//   > object oPC - Personnage concerné.
//   o int - Identifiant.
void cosLinkAccountToKey(object oPC);

// DEF IN "cosa_pcmanips"
// Boucle qui sauvegarde la position actuelle du personnage comme sa dernière position connue toute les X secondes.
//   > object oPC - Personnage concerné.
void cosSavePCLocationLoop(object oPC);

// DEF IN "cosa_pcmanips"
// Déplace le personnage jusqu'à sa dernière position connue.
//   > object oPC - Personnage concerné.
void cosMovePCToStartLocation(object oPC);

// DEF IN "cosa_pcmanips"
// Met à jour la date de dernière connexion.
//   > object oPC - Personnage concerné.
void cosUpdateLastConnexion(object oPC);

/**************************************** IMPLEMENTATIONS *****************************************/

int cosGetPCId(object oPC) {
    int iId = cosGetLocalInt(oPC, COS_PC_ID, FALSE);
    if (iId == 0) {
        iId = sqlEAFDSingleInt("SELECT "+COS_SQLF_ID+" FROM "+COS_SQLT_CHAR+" WHERE "+COS_SQLF_NAME+" = "+sqlQuote(GetName(oPC))+";");
        if (iId != 0) {
            cosSetLocalInt(oPC, COS_PC_ID, iId, FALSE);
        }
    }
    return iId;
}

int cosIsNewPC(object oPC) {
    if (cosGetPCId(oPC) == 0) {
        return TRUE;
    }
    return FALSE;
}

void cosCreatePCId(object oPC) {
   if (cosHasNewAccount(oPC)) {
       cosCreateAccountId(oPC);
   }
   if (cosHasNewPublicCDKey(oPC)) {
       cosCreatePublicCDKeyId(oPC);
   }
   cosLinkAccountToKey(oPC);
   sqlExecDirect("INSERT INTO "+COS_SQLT_CHAR+" ("+COS_SQLF_NAME+","+COS_SQLF_ID_ACCOUNT+","+COS_SQLF_CREATION+") VALUES ("+sqlQuote(GetName(oPC))+","+IntToString(cosGetAccountId(oPC))+", NOW());");
}

int cosGetAccountId(object oPC) {
    int iId = cosGetLocalInt(oPC, COS_PC_ACCOUNT_ID, FALSE);
    if (iId == 0) {
        iId = sqlEAFDSingleInt("SELECT "+COS_SQLF_ID+" FROM "+COS_SQLT_ACCOUNT+" WHERE "+COS_SQLF_NAME+" = "+sqlQuote(GetPCPlayerName(oPC))+";");
        if (iId != 0) {
            cosSetLocalInt(oPC, COS_PC_ACCOUNT_ID, iId, FALSE);
        }
    }
    return iId;
}

int cosHasNewAccount(object oPC) {
     if (cosGetAccountId(oPC) == 0) {
         return TRUE;
     }
     return FALSE;
}

void cosCreateAccountId(object oPC) {
     sqlExecDirect("INSERT INTO "+COS_SQLT_ACCOUNT+" ("+COS_SQLF_NAME+","+COS_SQLF_CREATION+") VALUES ("+sqlQuote(GetPCPlayerName(oPC))+", NOW());");
}

int cosGetPublicCDKeyId(object oPC) {
    int iKey = cosGetLocalInt(oPC, COS_PC_KEY_ID, FALSE);
    if (iKey == 0) {
        iKey = sqlEAFDSingleInt("SELECT "+COS_SQLF_ID+" FROM "+COS_SQLT_CDKEY+" WHERE "+COS_SQLF_VALUE+" = "+sqlQuote(GetPCPublicCDKey(oPC))+";");
        if (iKey != 0) {
            cosSetLocalInt(oPC, COS_PC_KEY_ID, iKey, FALSE);
        }
    }
    return iKey;
}

int cosHasNewPublicCDKey(object oPC) {
     if (sqlEAFDSingleInt("SELECT "+COS_SQLF_ID+" FROM "+COS_SQLT_CDKEY+" WHERE "+COS_SQLF_VALUE+" = "+sqlQuote(GetPCPublicCDKey(oPC))+";") == 0) {
         return TRUE;
     }
     return FALSE;
}

void cosCreatePublicCDKeyId(object oPC) {
     sqlExecDirect("INSERT INTO "+COS_SQLT_CDKEY+" ("+COS_SQLF_VALUE+","+COS_SQLF_CREATION+") VALUES ("+sqlQuote(GetPCPublicCDKey(oPC))+", NOW());");
}

void cosLinkAccountToKey(object oPC) {
     if (!cosHasNewAccount(oPC) && !cosHasNewPublicCDKey(oPC)) {
         sqlExecDirect("INSERT IGNORE INTO "+COS_SQLT_CDKEY_TO_ACCOUNT+" ("+COS_SQLF_ID_ACCOUNT+","+COS_SQLF_ID_CDKEY+","+COS_SQLF_CREATION+") VALUES ("+IntToString(cosGetAccountId(oPC))+","+IntToString(cosGetPublicCDKeyId(oPC))+", NOW());");
     }
}

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

void cosSaveLocalValue(object oPC, string sVarName, string sValue) {
    string sSQL = "INSERT INTO "+COS_SQLT_CHAR_DATA+" ("+COS_SQLF_ID_CHAR+","+COS_SQLF_NAME+","+COS_SQLF_VALUE+","+COS_SQLF_CREATION+","+COS_SQLF_LAST_UPDATE+")"+
                  " VALUES ("+IntToString(cosGetPCId(oPC))+","+sqlQuote(sVarName)+","+sqlQuote(sValue)+",NOW(),NOW()) "+
                  "ON DUPLICATE KEY UPDATE"+
                  " "+COS_SQLF_VALUE+"="+sqlQuote(sValue)+","+
                  " "+COS_SQLF_LAST_UPDATE+"=NOW();";
    sqlExecDirect(sSQL);
}

void cosSetLocalInt(object oPC, string sVarName, int iValue, int iPersistant = TRUE) {
    object oPCWP = cosGetPCWaypoint(oPC);
    if (GetIsObjectValid(oPCWP)) {
        SetLocalInt(oPCWP, sVarName, iValue);
        if (iPersistant) {
            cosSaveLocalValue(oPC, sVarName, IntToString(iValue));
        }
    }
}

int cosGetLocalInt(object oPC, string sVarName, int iPersistant = TRUE) {
    int iRes;
    object oPCWP = cosGetPCWaypoint(oPC);
    if (GetIsObjectValid(oPCWP)) {
        iRes = GetLocalInt(oPCWP, sVarName);
        if (iRes == 0 && iPersistant) {
            iRes = sqlEAFDSingleInt("SELECT "+COS_SQLF_VALUE+" FROM "+COS_SQLT_CHAR_DATA+" WHERE "+COS_SQLF_ID_CHAR+" = "+IntToString(cosGetPCId(oPC))+" AND "+COS_SQLF_NAME+" = "+sqlQuote(sVarName)+";");
            if (iRes != 0) {
                cosSetLocalInt(oPC, sVarName, iRes);
            }
        }
    }
    return iRes;
}

void cosSetLocalString(object oPC, string sVarName, string sString, int iPersistant = TRUE) {
    object oPCWP = cosGetPCWaypoint(oPC);
    if (GetIsObjectValid(oPCWP)) {
        SetLocalString(oPCWP, sVarName, sString);
        if (iPersistant) {
            cosSaveLocalValue(oPC, sVarName, sString);
        }
    }
}

string cosGetLocalString(object oPC, string sVarName, int iPersistant = TRUE) {
    string sRes;
    object oPCWP = cosGetPCWaypoint(oPC);
    if (GetIsObjectValid(oPCWP)) {
        sRes = GetLocalString(oPCWP, sVarName);
        if (sRes == "" && iPersistant) {
            sRes = sqlEAFDSingleString("SELECT "+COS_SQLF_VALUE+" FROM "+COS_SQLT_CHAR_DATA+" WHERE "+COS_SQLF_ID_CHAR+" = "+IntToString(cosGetPCId(oPC))+" AND "+COS_SQLF_NAME+" = "+sqlQuote(sVarName)+";");
            if (sRes != "") {
                cosSetLocalString(oPC, sVarName, sRes);
            }
        }
    }
    return sRes;
}

void cosSetLocalLocation(object oPC, string sVarName, location lLoc, int iPersistant = TRUE) {
    cosSetLocalString(oPC, sVarName, usuLocationToString(lLoc), iPersistant);
}

location cosGetLocalLocation(object oPC, string sVarName, int iPersistant = TRUE) {
    return usuStringToLocation(cosGetLocalString(oPC, sVarName, iPersistant));
}

// TODO : Changer la boucle de sauvegarde de position par une boucle générale
// dans laquelle faire des choses plus larges comme vérifier l'état d'AFK.

/* Private function */
// Boucle de sauvegarde de la position du personnage.
void pv_cosSaveLocLoop(object oPC) {
    if (GetIsPC(oPC) && GetIsObjectValid(oPC)) {
        cosSetLocalString(oPC, COS_PC_STARTLOC, usuLocationToString(GetLocation(oPC)));
        // TODO : Ajouter un brin d'aléatoire...
        DelayCommand(COS_SAVEPOS_DELAY, pv_cosSaveLocLoop(oPC));
    }
}

void cosSavePCLocationLoop(object oPC) {
    pv_cosSaveLocLoop(oPC);
}

void cosMovePCToStartLocation(object oPC) {
    string sLoc = cosGetLocalString(oPC, COS_PC_STARTLOC);
    if (sLoc == "") {
        sLoc = usuLocationToString(GetStartingLocation());
    }
    AssignCommand(oPC, ActionJumpToLocation(usuStringToLocation(sLoc)));
}

// TODO : Fonction à tester
void cosUpdateLastConnexion(object oPC) {
    sqlExecDirect("UPDATE "+COS_SQLT_CHAR+" SET "+COS_SQLF_LAST_CNX+"=NOW();");
}
