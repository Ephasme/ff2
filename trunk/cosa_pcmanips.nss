/**************************************************************************************************/
/** Nom :              cosa_pcmanips
/** Date de cr�ation : 16/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/******************************************** ChangeLog *******************************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les fonctions relatives � la gestion des personnages.
/**************************************************************************************************/

/******************************************** INCLUDES ********************************************/

#include "sqla_main"
#include "usua_locmanips"
#include "cosa_constants"

/******************************************* PROTOTYPES *******************************************/

// DEF IN "cosa_pcmanips"
// Fonction qui permet de r�cup�rer le Waypoint contenant les donn�es du personnage.
//   > object oPC - Personnage � traiter.
//   o object - Waypoint de donn�e.
object cosGetPCWaypoint(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui permet de cr�er le Waypoint contenant les donn�es du personnage.
//   > object oPC - Personnage � traiter.
//   o object - Waypoint de donn�e.
object cosCreatePCWaypoint(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui permet de sauver un couple valeur/PJ dans la base de donn�e.
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � stocker.
//   > string sValue - Donn�e � sauvegarder.
void cosSaveLocalValue(object oPC, string sVarName, string sValue);

// DEF IN "cosa_pcmanips"
// Fonction qui permet de sauver un entier stock� sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � r�cup�rer.
//   > int iPersistant - TRUE par d�faut. La valeur est stock�e en base de donn�e.
//   > int - Integer � stocker.
void cosSetLocalInt(object oPC, string sVarName, int iValue, int iPersistant = TRUE);

// DEF IN "cosa_pcmanips"
// Fonction qui permet de r�cup�rer un entier stock� sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � r�cup�rer.
//   > int iPersistant - TRUE par d�faut. Si la recherche est infructueuse, la fonction regarde
//                       dans la base de donn�e.
//   o int - Integer r�cup�r�.
int cosGetLocalInt(object oPC, string sVarName, int iPersistant = TRUE);

// DEF IN "cosa_pcmanips"
// Fonction qui permet de sauver une cha�ne stock�e sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � stocker.
//   > int iPersistant - TRUE par d�faut. La valeur est stock�e en base de donn�e.
//   > string - Cha�ne � stocker.
void cosSetLocalString(object oPC, string sVarName, string sString, int iPersistant = TRUE);

// DEF IN "cosa_pcmanips"
// Fonction qui permet de r�cup�rer une cha�ne stock�e sur un PJ (� travers le Waypoint de donn�e).
//   > object oPC - Personnage concern�.
//   > string sVarName - Nom de la variable contenant la valeur � r�cup�rer.
//   > int iPersistant - TRUE par d�faut. Si la recherche est infructueuse, la fonction regarde
//                       dans la base de donn�e.
//   o string - cha�ne r�cup�re.
string cosGetLocalString(object oPC, string sVarName, int iPersistant = TRUE);

// TODO : � documenter.
void cosSetLocalLocation(object oPC, string sVarName, location lLoc, int iPersistant = TRUE);

// TODO : � documenter.
location cosGetLocalLocation(object oPC, string sVarName, int iPersistant = TRUE);

// DEF IN "cosa_pcmanips"
// Fonction qui renvoie l'identifiant du personnage.
//   > object oPC - Personnage concern�.
//   o int - Identifiant.
int cosGetPCId(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui teste si le personnage est nouveau sur le serveur.
//   > object oPC - Personnage concern�.
//   o int - TRUE s'il est nouveau, FALSE sinon.
int cosIsNewPC(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui cr�e un nouvel identifiant de personnage.
// Si n�cessaire elle cr�e aussi un nouvel identifiant de compte, de clef CD
// et elle lie le compte avec la clef.
//   > object oPC - Personnage concern�.
void cosCreatePCId(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui renvoie l'identifiant du compte.
//   > object oPC - Personnage concern�.
//   o int - Identifiant.
int cosGetAccountId(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui teste si le compte est nouveau sur le serveur.
//   > object oPC - Personnage concern�.
//   o int - TRUE s'il est nouveau, FALSE sinon.
int cosHasNewAccount(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui cr�e un nouvel identifiant de compte.
//   > object oPC - Personnage concern�.
void cosCreateAccountId(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui renvoie l'identifiant de la clef CD.
//   > object oPC - Personnage concern�.
//   o int - Identifiant.
int cosGetPublicCDKeyId(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui teste si la clef CD est nouvelle sur le serveur.
//   > object oPC - Personnage concern�.
//   o int - TRUE si elle est nouvelle, FALSE sinon.
int cosHasNewPublicCDKey(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui cr�e un nouvel identifiant de clef CD.
//   > object oPC - Personnage concern�.
void cosCreatePublicCDKeyId(object oPC);

// DEF IN "cosa_pcmanips"
// Fonction qui cr�e un lien entre la clef CD et le compte du personnage.
//   > object oPC - Personnage concern�.
//   o int - Identifiant.
void cosLinkAccountToKey(object oPC);

// DEF IN "cosa_pcmanips"
// Boucle qui sauvegarde la position actuelle du personnage comme sa derni�re position connue toute les X secondes.
//   > object oPC - Personnage concern�.
void cosSavePCLocationLoop(object oPC);

// DEF IN "cosa_pcmanips"
// D�place le personnage jusqu'� sa derni�re position connue.
//   > object oPC - Personnage concern�.
void cosMovePCToStartLocation(object oPC);

// DEF IN "cosa_pcmanips"
// Met � jour la date de derni�re connexion.
//   > object oPC - Personnage concern�.
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

// TODO : Changer la boucle de sauvegarde de position par une boucle g�n�rale
// dans laquelle faire des choses plus larges comme v�rifier l'�tat d'AFK.

/* Private function */
// Boucle de sauvegarde de la position du personnage.
void pv_cosSaveLocLoop(object oPC) {
    if (GetIsPC(oPC) && GetIsObjectValid(oPC)) {
        cosSetLocalString(oPC, COS_PC_STARTLOC, usuLocationToString(GetLocation(oPC)));
        // TODO : Ajouter un brin d'al�atoire...
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

// TODO : Fonction � tester
void cosUpdateLastConnexion(object oPC) {
    sqlExecDirect("UPDATE "+COS_SQLT_CHAR+" SET "+COS_SQLF_LAST_CNX+"=NOW();");
}
