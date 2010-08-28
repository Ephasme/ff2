/*********************************************************************/
/** Nom :              sql_charmanips
/** Date de création : 23/08/2010
/** Version :          1.0.0
/** Createur :         Loup Peluso
/***************************** ChangeLog *****************************/
/** V1.0.0 :
/**      Mise en place des fonctions de manipulation des données SQL
/**   des personnages.
/*********************************************************************/

/***************************** INCLUDES ******************************/

    // #include "usu_locmanip"
#include "sql_main"

/***************************** PROTOTYPES ****************************/

// DEF IN "sql_charmanips"
// Cette fonction récupère un identifiant de compte joueur en fonction de son nom.
// Si le nom de compte est nouveau, elle crée une entrée dans la base de donnée.
//   > string sAccountName - Nom du compte joueur.
//   o int - Identifiant de ce compte.
int sqlGetAccountId(string sAccountName);

// DEF IN "sql_charmanips"
// Cette fonction récupère un identifiant de personnage en fonction de son nom.
// Si le personnage est nouveau, elle crée une entrée dans la base de donnée.
//   > string sAccountName - Nom du personnage.
//   > int iAccountId - Identifiant du compte associé à ce personnage.
//   o int - Identifiant de ce personnage.
int sqlGetPCId(string sPCName, int iAccountId);

// DEF IN "sql_charmanips"
// Cette fonction récupère un identifiant de clef CD en fonction de son nom.
// Si le nom de compte est nouveau, elle crée une entrée dans la base de donnée.
//   > string sKey - Clef CD du joueur.
//   > int iAccountId - Identifiant du compte associé à ce personnage.
//   o int - Identifiant de cette clef.
int sqlGetKeyId(string sKey, int iAccountId);

// DEF IN "sql_charmanips"
// Cette fonction crée un lien entre une clef CD et un compte joueur.
//   > int iKeyId - Identifiant de la clef CD.
//   > int iAccountId - Identifiant du compte associé à ce personnage.
//   o int - Identifiant du lien clef/compte joueur.
int sqlGetCDKeyAccountLinkId(int iKeyId, int iAccountId);

// DEF IN "sql_charmanips"
// Cette fonction récupère un identifiant de compte en fonction d'un
// identifiant de personnage.
//   > int iKeyId - Identifiant du personnage.
//   o int - Identifiant du compte qui lui est associé.
int sqlGetAccountIdFromPCId(int iPCId);

// DEF IN "sql_charmanips"
// Cette fonction met à jour la date de dernière connexion du joueur et de
// son personnage dans la base de donnée.
//   > int iPCId - Identifiant du personnage.
//   > int iAccountId - Identifiant du compte joueur.
void sqlUpdateLastConnexion(int iPCId, int iAccountId);

// DEF IN "sql_charmanips"
// Cette fonction détermine si le compte est bloqué.
//   > int iAccountId - Identifiant du compte.
//   o int - TRUE si le compte est bloqué, FALSE sinon.
int sqlIsAccountBan(int iAccountId);

// DEF IN "sql_charmanips"
// Cette fonction détermine si le PC est bloqué.
//   > int iAccountId - Identifiant du PC.
//   o int - TRUE si le PC est bloqué, FALSE sinon.
int sqlIsPCBan(int iPCId);

// DEF IN "sql_charmanips"
// Cette fonction détermine si la clef CD est bloquée.
//   > int iKeyId - Identifiant de la clef.
//   o int - TRUE si la clef est bloquée, FALSE sinon.
int sqlIsKeyBan(int iKeyId);

// DEF IN "sql_charmanips"
// Renvoi de la position du PC lors de la dernière déconnexion.
//   > int iPCId - Identifiant du PJ.
//   o location - Point de départ.
location sqlGetPCStartingLocation(int iPCId);

// DEF IN "sql_charmanips"
// Détermine si la position de départ du PC est valide.
//   > int iPCId - Identifiant du PJ.
//   o int - TRUE si la position est valide, FALSE sinon.
int sqlPCStartingLocationValid(int iPCId);

/************************** IMPLEMENTATIONS **************************/

int sqlGetAccountId(string sAccountName) {
    return sqlEAFDSingleIntOrInsert(
        "SELECT "+ID+" FROM "+TABLE_ACCOUNTS+" WHERE "+NAME+" = "+sqlQuote(sAccountName)+";",
        "INSERT INTO "+TABLE_ACCOUNTS+" ("+NAME+", "+CREATION+", "+LAST_CONNEXION+") VALUES ("+sqlQuote(sAccountName)+", NOW(), NOW());"
    );
}

int sqlGetPCId(string sPCName, int iAccountId) {
    string sAccountId = IntToString(iAccountId);
    return sqlEAFDSingleIntOrInsert(
        "SELECT "+ID+" FROM "+TABLE_CHARACTERS+" WHERE "+NAME+" = "+sqlQuote(sPCName)+";",
        "INSERT INTO "+TABLE_CHARACTERS+" ("+ID_ACCOUNT+", "+NAME+", "+CREATION+", "+LAST_CONNEXION+") VALUES ("+sAccountId+", "+sqlQuote(sPCName)+", NOW(), NOW());"
    );
}

int sqlGetKeyId(string sKey, int iAccountId) {
    return sqlEAFDSingleIntOrInsert(
        "SELECT "+ID+" FROM "+TABLE_CDKEYS+" WHERE "+CDKEY+" = '"+sKey+"';",
        "INSERT INTO "+TABLE_CDKEYS+" ("+CDKEY+") VALUES ('"+sKey+"');"
    );
}

int sqlGetCDKeyAccountLinkId(int iKeyId, int iAccountId) {
    string sKeyId = IntToString(iKeyId);
    string sAccountId = IntToString(iAccountId);
    return sqlEAFDSingleIntOrInsert(
        "SELECT "+ID+" FROM "+TABLE_CDKEY_ACCOUNT_LINKS+" WHERE "+ID_CDKEY+" = "+sKeyId+" AND "+ID_ACCOUNT+" = "+sAccountId+";",
        "INSERT INTO "+TABLE_CDKEY_ACCOUNT_LINKS+" ("+ID_ACCOUNT+", "+ID_CDKEY+") VALUES ("+sAccountId+", "+sKeyId+")"
    );
}

int sqlGetAccountIdFromPCId(int iPCId) {
    return sqlEAFDSingleInt("SELECT "+ID_ACCOUNT+" FROM "+TABLE_CHARACTERS+" WHERE "+ID+" = "+IntToString(iPCId)+";");
}

void sqlUpdateLastConnexion(int iPCId, int iAccountId) {
    sqlExecDirect("UPDATE "+TABLE_CHARACTERS+" SET "+LAST_CONNEXION+" = NOW() WHERE "+ID+" = "+IntToString(iPCId)+";");
    sqlExecDirect("UPDATE "+TABLE_ACCOUNTS+" SET "+LAST_CONNEXION+" = NOW() WHERE "+ID+" = "+IntToString(iAccountId)+";");
}

/* Private function */
int pv_sqlIsBan(string sTable, int iId) {
    return sqlEAFDSingleInt("SELECT "+BAN+" FROM "+sTable+" WHERE "+ID+" = "+IntToString(iId)+";");
}

int sqlIsAccountBan(int iAccountId) {
    return pv_sqlIsBan(TABLE_ACCOUNTS, iAccountId);
}

int sqlIsPCBan(int iPCId) {
    return pv_sqlIsBan(TABLE_CHARACTERS, iPCId);
}

int sqlIsKeyBan(int iKeyId) {
    return pv_sqlIsBan(TABLE_CDKEYS, iKeyId);
}

location sqlGetPCStartingLocation(int iPCId) {
    return sqlEAFDSingleLocation("SELECT "+STARTING_LOCATION+" FROM "+TABLE_CHARACTERS+" WHERE "+ID+" = "+IntToString(iPCId)+";");
}

int sqlPCStartingLocationValid(int iPCId) {
    sqlExecDirect("SELECT "+STARTING_LOCATION+" FROM "+TABLE_CHARACTERS+" WHERE "+ID+" = "+IntToString(iPCId)+";");
    sqlFetch();
    string sRes = sqlGetData(1);
    return (sRes != ""); 
}