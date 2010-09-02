/*********************************************************************/
/** Nom :              sqlaf_charmanips
/** Date de création : 23/08/2010
/** Version :          1.0.0
/** Createur :         Loup Peluso
/***************************** ChangeLog *****************************/
/** V1.0.0 :
/**      Mise en place des fonctions de manipulation des données SQL
/**   des personnages.
/*********************************************************************/

/***************************** INCLUDES ******************************/

        // #include "usuaf_strtokman"
    // #include "usuaf_locmanip"
    // #include "sqlaf_constants"
#include "sqlaf_main"

/***************************** PROTOTYPES ****************************/

// DEF IN "sqlaf_charmanips"
// Cette fonction récupère un identifiant de compte joueur en fonction de son nom.
// Si le nom de compte est nouveau, elle crée une entr e dans la base de donnée.
//   > string sAccountName - Nom du compte joueur.
//   o int - Identifiant de ce compte.
int sqlGetAccountId(string sAccountName);

// DEF IN "sqlaf_charmanips"
// Cette fonction récupère un identifiant de personnage en fonction de son nom.
// Si le personnage est nouveau, elle crée une entr e dans la base de donnée.
//   > string sAccountName - Nom du personnage.
//   > int iAccountId - Identifiant du compte associ    ce personnage.
//   o int - Identifiant de ce personnage.
int sqlGetPCId(string sPCName, int iAccountId);

// DEF IN "sqlaf_charmanips"
// Cette fonction récupère un identifiant de clef CD en fonction de son nom.
// Si le nom de compte est nouveau, elle crée une entr e dans la base de donnée.
//   > string sKey - Clef CD du joueur.
//   > int iAccountId - Identifiant du compte associ    ce personnage.
//   o int - Identifiant de cette clef.
int sqlGetKeyId(string sKey, int iAccountId);

// DEF IN "sqlaf_charmanips"
// Cette fonction crée un lien entre une clef CD et un compte joueur.
//   > int iKeyId - Identifiant de la clef CD.
//   > int iAccountId - Identifiant du compte associ    ce personnage.
//   o int - Identifiant du lien clef/compte joueur.
int sqlGetCDKeyAccountLinkId(int iKeyId, int iAccountId);

// DEF IN "sqlaf_charmanips"
// Cette fonction récupère un identifiant de compte en fonction d'un
// identifiant de personnage.
//   > int iKeyId - Identifiant du personnage.
//   o int - Identifiant du compte qui lui est associ .
int sqlGetAccountIdFromPCId(int iPCId);

// DEF IN "sqlaf_charmanips"
// Cette fonction met   jour la date de dernière connexion du joueur et de
// son personnage dans la base de donnée.
//   > int iPCId - Identifiant du personnage.
//   > int iAccountId - Identifiant du compte joueur.
void sqlUpdateLastConnexion(int iPCId, int iAccountId);

// DEF IN "sqlaf_charmanips"
// Cette fonction d termine si le compte est bloqu .
//   > int iAccountId - Identifiant du compte.
//   o int - TRUE si le compte est bloqu , FALSE sinon.
int sqlIsAccountBan(int iAccountId);

// DEF IN "sqlaf_charmanips"
// Cette fonction d termine si le PC est bloqu .
//   > int iAccountId - Identifiant du PC.
//   o int - TRUE si le PC est bloqu , FALSE sinon.
int sqlIsPCBan(int iPCId);

// DEF IN "sqlaf_charmanips"
// Cette fonction d termine si la clef CD est bloqu e.
//   > int iKeyId - Identifiant de la clef.
//   o int - TRUE si la clef est bloqu e, FALSE sinon.
int sqlIsKeyBan(int iKeyId);

// DEF IN "sqlaf_charmanips"
// Renvoi de la position du PC lors de la dernière d connexion.
//   > int iPCId - Identifiant du PJ.
//   o location - Point de d part.
location sqlGetPCStartingLocation(int iPCId);

// DEF IN "sqlaf_charmanips"
// D termine si la position de d part du PC est valide.
//   > int iPCId - Identifiant du PJ.
//   o int - TRUE si la position est valide, FALSE sinon.
int sqlPCStartingLocationValid(int iPCId);

/************************** IMPLEMENTATIONS **************************/

int sqlGetAccountId(string sAccountName) {
    return sqlEAFDSingleIntOrInsert(
        "SELECT "+SQL_F_ID+" FROM "+SQL_T_ACCOUNTS+" WHERE "+SQL_F_NAME+" = "+sqlQuote(sAccountName)+";",
        "INSERT INTO "+SQL_T_ACCOUNTS+" ("+SQL_F_NAME+", "+SQL_F_CREATION+", "+SQL_F_LAST_CNX+") VALUES ("+sqlQuote(sAccountName)+", NOW(), NOW());"
    );
}

int sqlGetPCId(string sPCName, int iAccountId) {
    string sAccountId = IntToString(iAccountId);
    return sqlEAFDSingleIntOrInsert(
        "SELECT "+SQL_F_ID+" FROM "+SQL_T_CHARS+" WHERE "+SQL_F_NAME+" = "+sqlQuote(sPCName)+";",
        "INSERT INTO "+SQL_T_CHARS+" ("+SQL_F_ID_ACCOUNT+", "+SQL_F_NAME+", "+SQL_F_CREATION+", "+SQL_F_LAST_CNX+") VALUES ("+sAccountId+", "+sqlQuote(sPCName)+", NOW(), NOW());"
    );
}

int sqlGetKeyId(string sKey, int iAccountId) {
    return sqlEAFDSingleIntOrInsert(
        "SELECT "+SQL_F_ID+" FROM "+SQL_T_CDKEYS+" WHERE "+SQL_F_CDKEY+" = '"+sKey+"';",
        "INSERT INTO "+SQL_T_CDKEYS+" ("+SQL_F_CDKEY+") VALUES ('"+sKey+"');"
    );
}

int sqlGetCDKeyAccountLinkId(int iKeyId, int iAccountId) {
    string sKeyId = IntToString(iKeyId);
    string sAccountId = IntToString(iAccountId);
    return sqlEAFDSingleIntOrInsert(
        "SELECT "+SQL_F_ID+" FROM "+SQL_T_CDKEY_ACCOUNT_LINKS+" WHERE "+SQL_F_ID_CDKEY+" = "+sKeyId+" AND "+SQL_F_ID_ACCOUNT+" = "+sAccountId+";",
        "INSERT INTO "+SQL_T_CDKEY_ACCOUNT_LINKS+" ("+SQL_F_ID_ACCOUNT+", "+SQL_F_ID_CDKEY+") VALUES ("+sAccountId+", "+sKeyId+")"
    );
}

int sqlGetAccountIdFromPCId(int iPCId) {
    return sqlEAFDSingleInt("SELECT "+SQL_F_ID_ACCOUNT+" FROM "+SQL_T_CHARS+" WHERE "+SQL_F_ID+" = "+IntToString(iPCId)+";");
}

void sqlUpdateLastConnexion(int iPCId, int iAccountId) {
    sqlExecDirect("UPDATE "+SQL_T_CHARS+" SET "+SQL_F_LAST_CNX+" = NOW() WHERE "+SQL_F_ID+" = "+IntToString(iPCId)+";");
    sqlExecDirect("UPDATE "+SQL_T_ACCOUNTS+" SET "+SQL_F_LAST_CNX+" = NOW() WHERE "+SQL_F_ID+" = "+IntToString(iAccountId)+";");
}

/* Private function */
int pv_sqlIsBan(string sTable, int iId) {
    return sqlEAFDSingleInt("SELECT "+SQL_F_BAN+" FROM "+sTable+" WHERE "+SQL_F_ID+" = "+IntToString(iId)+";");
}

int sqlIsAccountBan(int iAccountId) {
    return pv_sqlIsBan(SQL_T_ACCOUNTS, iAccountId);
}

int sqlIsPCBan(int iPCId) {
    return pv_sqlIsBan(SQL_T_CHARS, iPCId);
}

int sqlIsKeyBan(int iKeyId) {
    return pv_sqlIsBan(SQL_T_CDKEYS, iKeyId);
}

location sqlGetPCStartingLocation(int iPCId) {
    return sqlEAFDSingleLocation("SELECT "+SQL_F_START_LOC+" FROM "+SQL_T_CHARS+" WHERE "+SQL_F_ID+" = "+IntToString(iPCId)+";");
}

int sqlPCStartingLocationValid(int iPCId) {
    sqlExecDirect("SELECT "+SQL_F_START_LOC+" FROM "+SQL_T_CHARS+" WHERE "+SQL_F_ID+" = "+IntToString(iPCId)+";");
    sqlFetch();
    string sRes = sqlGetData(1);
    return (sRes != ""); 
}