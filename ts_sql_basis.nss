/*********************************************************************/
/** Nom :              ts_sql_basis
/** Date de création : 19/07/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script spécial à lancer dans le OnModuleLoad afin de tester
/**    toutes les fonctionnalités SQL.
/*********************************************************************/

/***************************** INCLUDES ******************************/

    // #include "usu_in_location"
#include "sql_in_basis"

#include "usu_in_tests"

/***************************** CONSTANTES ****************************/

// Nom du script de test.
const string TEST_SCRIPT_NAME = "ts_sql_basis";

// Constante à désactiver pour supprimer cette série de test des logs.
const int TS_SQL_BASIS_ENABLED = TRUE;

/***************************** VARIABLES *****************************/

/* Donnée aléatoire. */
string sRand = IntToString(GetTimeMillisecond());

/************************** IMPLEMENTATIONS **************************/

// (Fonction privée)
void pvCreateInsert(string sSalt) {
    sqlExecDirect(
        "INSERT INTO "+TABLE_ACCOUNTS+" ("+NAME+", "+CREATION+", "+LAST_CONNEXION+")" +
        " VALUES ('DELETE_ME_"+sSalt+"', NOW(), NOW());"
    );
}

// (Fonction privée)
void pvDeleteInserts() {
    sqlExecDirect(
        "DELETE FROM "+TABLE_ACCOUNTS+" WHERE "+NAME+" LIKE '%DELETE_ME%';"
    );
}

void ts_sqlEAFDSingleInt() {
    string sQuery = "SELECT 1;";
    int iRes = sqlEAFDSingleInt(sQuery);
    addTest("sqlEAFDSingleInt", "Récupération d'un entier stocké dans la base de donnée.", iRes == 1);
    addTestInfo("Entier récupéré", IntToString(iRes));
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
        "SELECT "+ID+" FROM "+TABLE_ACCOUNTS+" WHERE "+NAME+" = "+sqlQuote("DELETE_ME_"+sSalt)+";",
        "INSERT INTO "+TABLE_ACCOUNTS+" ("+NAME+") VALUES ("+sqlQuote("DELETE_ME_"+sSalt)+");"
    );

    addTest(
        "sqlEAFDSingleIntOrInsert",
        "Récupération ou insertion d'un compte joueur.",
        iRes > 0
    );
    pvDeleteInserts();
}

void ts_sqlGetWaypoint() {
    // Est-ce que la fonction sqlGetWaypoint() fonctionne correctement ?
    object oWP = sqlGetWaypoint();
    string sCase = "Récupération du Waypoint.";
    addTest("sqlGetWaypoint", sCase, oWP != OBJECT_INVALID);
}

void ts_sqlFetch() {
    string sSalt = IntToString(GetTimeMillisecond());
    pvCreateInsert(sSalt);
    sqlExecDirect(
        "SELECT "+ID+" FROM "+TABLE_ACCOUNTS+" WHERE "+NAME+" LIKE '%DELETE_ME_"+sSalt+"%'"
    );
    addTest("sqlFetch", "Récupération des résultats d'une exécution.", sqlFetch());
    pvDeleteInserts();
}

void main()
{
    // On exécute les tests.
    if (TEST_MODE && TS_SQL_BASIS_ENABLED) {
        ts_sqlGetWaypoint();
        ts_sqlFetch();

        ts_sqlEAFDSingleInt();
        ts_sqlEAFDSingleLocation();

        ts_sqlEAFDSingleIntOrInsert();

        // On envoie les resultats.
        printResult(TEST_SCRIPT_NAME);
    }
}
