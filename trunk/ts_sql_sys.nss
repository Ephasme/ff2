/*********************************************************************/
/** Nom :              ts_sql_sys
/** Date de cr�ation : 19/07/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script sp�cial � lancer dans le OnModuleLoad afin de tester
/**    toutes les fonctionnalit�s SQL.
/*********************************************************************/

/***************************** INCLUDES ******************************/

            // #include "usu_constants"
        // #include "usu_stringtokman"
    // #include "usu_locmanip"
    // #include "sql_constants"
#include "sql_main"

            // #include "usu_stringtokman"
        // #include "usu_locmanip"
        // #include "sql_constants"
    // #include "sql_main"
#include "sql_charmanips"

    // #include "usu_constants"
#include "usu_testfuncs"

/***************************** VARIABLES *****************************/

/* Donn�e al�atoire. */
string sRand = IntToString(GetTimeMillisecond());

/************************** IMPLEMENTATIONS **************************/

// (Fonction priv�e)
void pvCreateInsert(string sSalt) {
    sqlExecDirect(
        "INSERT INTO "+TABLE_ACCOUNTS+" ("+NAME+", "+CREATION+", "+LAST_CONNEXION+")" +
        " VALUES ('DELETE_ME_"+sSalt+"', NOW(), NOW());"
    );
}

// (Fonction priv�e)
void pvDeleteInserts() {
    sqlExecDirect(
        "DELETE FROM "+TABLE_ACCOUNTS+" WHERE "+NAME+" LIKE '%DELETE_ME%';"
    );
}

void ts_sqlEAFDSingleInt() {
    string sQuery = "SELECT 1;";
    int iRes = sqlEAFDSingleInt(sQuery);
    addTest("sqlEAFDSingleInt", "R�cup�ration d'un entier stock� dans la base de donn�e.", iRes == 1);
    addTestInfo("Entier r�cup�r�", IntToString(iRes));
}

void ts_sqlEAFDSingleLocation() {
    string sQuery = "SELECT '##area002##5.4##3.2##1.0##90.0##';";
    sqlExecDirect(sQuery);
    sqlFetch();
    string sResQue = sqlGetData(1);
    location lLoc = sqlEAFDSingleLocation(sQuery);
    int iResA = (GetTag(GetAreaFromLocation(lLoc)) == "area002");
    vector v = GetPositionFromLocation(lLoc);
    int iResB = ((v.x == 5.4) && (v.y == 3.2) && (v.z == 1.0));
    int iResC = (GetFacingFromLocation(lLoc) == 90.0);
    addTest(
        "sqlEAFDSingleLocation",
        "R�cup�ration d'une location stock� dans la base de donn�e.",
        iResA && iResB && iResC
    );
    addTestInfo("R�sultat requ�te", sResQue);
    addTestInfo("Location reconstruite", usuLocationToString(lLoc));
}

void ts_sqlEAFDSingleIntOrInsert() {
    string sSalt = "sqlEAFDSingleIntOrInsert";
    pvCreateInsert(sSalt);
    int iRes = sqlEAFDSingleIntOrInsert(
        "SELECT "+ID+" FROM "+TABLE_ACCOUNTS+" WHERE "+NAME+" = "+sqlQuote("DELETE_ME_"+sSalt)+";",
        "INSERT INTO "+TABLE_ACCOUNTS+" ("+NAME+") VALUES ("+sqlQuote("DELETE_ME_"+sSalt)+");"
    );

    addTest(
        "sqlEAFDSingleIntOrInsert",
        "R�cup�ration ou insertion d'un compte joueur.",
        iRes > 0
    );
    pvDeleteInserts();
}

void ts_sqlGetWaypoint() {
    // Est-ce que la fonction sqlGetWaypoint() fonctionne correctement ?
    object oWP = sqlGetWaypoint();
    string sCase = "R�cup�ration du Waypoint.";
    addTest("sqlGetWaypoint", sCase, oWP != OBJECT_INVALID);
}

void ts_sqlFetch() {
    string sSalt = IntToString(GetTimeMillisecond());
    pvCreateInsert(sSalt);
    sqlExecDirect(
        "SELECT "+ID+" FROM "+TABLE_ACCOUNTS+" WHERE "+NAME+" LIKE '%DELETE_ME_"+sSalt+"%'"
    );
    addTest("sqlFetch", "R�cup�ration des r�sultats d'une ex�cution.", sqlFetch());
    pvDeleteInserts();
}

void ts_sqlGetAccountId(object oPC) {
    int iRes = sqlGetAccountId(GetPCPlayerName(oPC));
    addTest("sqlGetAccountId", "R�cup�ration de l'identifiant du compte joueur.", iRes != SQL_ERROR);
    addTestInfo("Identifiant du compte", IntToString(iRes));
    addTestInfo("Nom du compte", GetPCPlayerName(oPC));
}

void ts_sqlGetPCId(object oPC) {
    string sAccount = GetPCPlayerName(oPC);
    string sName = GetName(oPC);
    int iAccountId = sqlGetAccountId(sAccount);
    int iPCId = sqlGetPCId(sName, iAccountId);
    addTest("sqlGetPCId", "R�cup�ration de l'identifiant du personnage.", iPCId != SQL_ERROR);
    addTestInfo("Identifiant du personnage", IntToString(iPCId));
    addTestInfo("Identifiant du compte", IntToString(iAccountId));
    addTestInfo("Nom du personnage", sName);
    addTestInfo("Compte du joueur", sAccount);
}

void ts_sqlGetKeyId(object oPC) {
    string sAccount = GetPCPlayerName(oPC);
    string sKey = GetPCPublicCDKey(oPC);
    int iAccountId = sqlGetAccountId(sAccount);
    int iKeyId = sqlGetKeyId(sKey, iAccountId);
    addTest("sqlGetKeyId", "R�cup�ration de l'identifiant de la clef CD.", iKeyId != SQL_ERROR);
    addTestInfo("Identifiant de la clef", IntToString(iKeyId));
    addTestInfo("Identifiant du compte", IntToString(iAccountId));
    addTestInfo("Clef du joueur", sKey);
    addTestInfo("Compte du joueur", sAccount);
}

void ts_sqlGetCDKeyAccountLinkId(object oPC) {
    string sAccount = GetPCPlayerName(oPC);
    string sKey = GetPCPublicCDKey(oPC);
    int iAccountId = sqlGetAccountId(sAccount);
    int iKeyId = sqlGetKeyId(sKey, iAccountId);
    int iLinkId = sqlGetCDKeyAccountLinkId(iKeyId, iAccountId);
    addTest("sqlGetCDKeyAccountLinkId", "R�cup�ration d'un identifiant de couple (clef CD/Compte joueur).", iLinkId != SQL_ERROR);
    addTestInfo("Identifiant du couple (clef CD/Compte joueur)", IntToString(iLinkId));
    addTestInfo("Identifiant du compte", IntToString(iAccountId));
    addTestInfo("Identifiant de la clef", IntToString(iKeyId));
    addTestInfo("Clef du joueur", sKey);
    addTestInfo("Compte du joueur", sAccount);
}


/* Private Function */
void pv_do_OnModuleLoad_Tests() {

    ts_sqlGetWaypoint();
    ts_sqlFetch();

    ts_sqlEAFDSingleInt();
    ts_sqlEAFDSingleLocation();

    ts_sqlEAFDSingleIntOrInsert();

    printResult(TS_SQL_TITLE);
}

/* Private Function */
void pv_do_OnClientEnter_Tests(object oPC, int iDepth = 0) {
    if (iDepth < TS_LOOP_MAX) {
        if (GetIsObjectValid(GetArea(oPC))) {

            ts_sqlGetAccountId(oPC);
            ts_sqlGetPCId(oPC);
            ts_sqlGetKeyId(oPC);
            ts_sqlGetCDKeyAccountLinkId(oPC);

            printResult(TS_SQL_TITLE);

        } else {
            DelayCommand(TS_LOOP_DELAY, pv_do_OnClientEnter_Tests(oPC, iDepth++));
        }
    }
}

void main() {
    if (TEST_MODE && TS_SQL_SYS) {
        object oMe = OBJECT_SELF;
        if (oMe == GetModule()) {
            pv_do_OnModuleLoad_Tests();

        } else if (GetIsPC(oMe)) {
            pv_do_OnClientEnter_Tests(oMe);
        }
    }
}
