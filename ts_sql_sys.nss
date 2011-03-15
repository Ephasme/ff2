/*********************************************************************/
/** Nom :              ts_sql_sys
/** Date de création : 19/07/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script spécial à lancer dans le OnModuleLoad afin de tester
/**    toutes les fonctionnalités SQL.
/*********************************************************************/

// TODO : Refaire les tests pour SQL, créer une table temporaire, exécuter des
// manipulations dessus et la détruire.

/***************************** INCLUDES ******************************/

            // #include "usuaf_constants"
        // #include "usuaf_strtokman"
    // #include "usuaf_locmanip"
    // #include "sqlaf_constants"
#include "sqlaf_main"

    // #include "usuaf_constants"
#include "usuaf_testfuncs"

/***************************** VARIABLES *****************************/

/* Donnée aléatoire. */
string sRand = IntToString(GetTimeMillisecond());

/************************** IMPLEMENTATIONS **************************/

/*
// (Fonction privée)
void pvCreateInsert(string sSalt) {
    sqlExecDirect(
        "INSERT INTO "+COS_SQLT_ACCOUNT+" ("+COS_SQLF_NAME+", "+COS_SQLF_CREATION+", "+COS_SQLF_LAST_CNX+")" +
        " VALUES ('DELETE_ME_"+sSalt+"', NOW(), NOW());"
    );
}

// (Fonction privée)
void pvDeleteInserts() {
    sqlExecDirect(
        "DELETE FROM "+COS_SQLT_ACCOUNT+" WHERE "+COS_SQLF_NAME+" LIKE '%DELETE_ME%';"
    );
}

void ts_sqlEAFDSingleInt() {
    string sQuery = "SELECT 1;";
    int iRes = sqlEAFDSingleInt(sQuery);
    addTest("sqlEAFDSingleInt", "Récupération d'un entier stocké dans la base de donnée.", iRes == 1);
    addTestInfo("Entier récupéré", IntToString(iRes));
}

void ts_sqlEAFDSingleLocation() {
    string sQuery = "SELECT '##sys_ar_00##5.4##3.2##1.0##90.0##';";
    sqlExecDirect(sQuery);
    sqlFetch();
    string sResQue = sqlGetData(1);
    location lLoc = sqlEAFDSingleLocation(sQuery);
    int iResA = (GetTag(GetAreaFromLocation(lLoc)) == "sys_ar_00");
    vector v = GetPositionFromLocation(lLoc);
    int iResB = ((v.x == 5.4) && (v.y == 3.2) && (v.z == 1.0));
    int iResC = (GetFacingFromLocation(lLoc) == 90.0);
    addTest(
        "sqlEAFDSingleLocation",
        "Récupération d'une location stocké dans la base de donnée.",
        iResA && iResB && iResC
    );
    addTestInfo("Résultat requête", sResQue);
    addTestInfo("Location reconstruite", usuLocationToString(lLoc));
}

void ts_sqlEAFDSingleIntOrInsert() {
    string sSalt = "sqlEAFDSingleIntOrInsert";
    pvCreateInsert(sSalt);
    int iRes = sqlEAFDSingleIntOrInsert(
        "SELECT "+COS_SQLF_ID+" FROM "+COS_SQLT_ACCOUNT+" WHERE "+COS_SQLF_NAME+" = "+sqlQuote("DELETE_ME_"+sSalt)+";",
        "INSERT INTO "+COS_SQLT_ACCOUNT+" ("+COS_SQLF_NAME+") VALUES ("+sqlQuote("DELETE_ME_"+sSalt)+");"
    );

    addTest(
        "sqlEAFDSingleIntOrInsert",
        "Récupération ou insertion d'un compte joueur.",
        iRes > 0
    );
    pvDeleteInserts();
}
*/

void ts_sqlGetWaypoint() {
    // Est-ce que la fonction sqlGetWaypoint() fonctionne correctement ?
    object oWP = sqlGetWaypoint();
    string sCase = "Récupération du Waypoint.";
    addTest("sqlGetWaypoint", sCase, oWP != OBJECT_INVALID);
}

/*
void ts_sqlFetch() {
    string sSalt = IntToString(GetTimeMillisecond());
    pvCreateInsert(sSalt);
    sqlExecDirect(
        "SELECT "+COS_SQLF_ID+" FROM "+COS_SQLT_ACCOUNT+" WHERE "+COS_SQLF_NAME+" LIKE '%DELETE_ME_"+sSalt+"%'"
    );
    addTest("sqlFetch", "Récupération des résultats d'une exécution.", sqlFetch());
    pvDeleteInserts();
}
*/

/* Private Function */
void pv_do_OnModuleLoad_Tests() {

    /*
    ts_sqlGetWaypoint();
    ts_sqlFetch();

    ts_sqlEAFDSingleInt();
    ts_sqlEAFDSingleLocation();

    ts_sqlEAFDSingleIntOrInsert();
    */

    printResult(TS_SQL_TITLE);
}

/* Private Function */
void pv_do_OnClientEnter_Tests(object oPC, int iDepth = 0) {
    if (iDepth < TS_LOOP_MAX) {
        if (GetIsObjectValid(GetArea(oPC))) {

            printResult(TS_SQL_TITLE);

        } else {
            DelayCommand(TS_LOOP_DELAY, pv_do_OnClientEnter_Tests(oPC, iDepth++));
        }
    }
}

void main() {
    if (TS_TEST_MODE && TS_SQL_SYS) {
        object oMe = OBJECT_SELF;
        if (oMe == GetModule()) {
            pv_do_OnModuleLoad_Tests();

        } else if (GetIsPC(oMe)) {
            pv_do_OnClientEnter_Tests(oMe);
        }
    }
}
