/*********************************************************************/
/** Nom :              ts_sql_basis
/** Date de cr�ation : 19/07/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script sp�cial � lancer dans le OnModuleLoad afin de tester
/**    toutes les fonctionnalit�s SQL.
/*********************************************************************/

/***************************** INCLUDES ******************************/

    // #include "usu_in_location"
#include "sql_in_basis"

#include "usu_in_tests"

/***************************** CONSTANTES ****************************/

// Nom du script de test.
const string TEST_SCRIPT_NAME = "ts_sql_basis";

// Constante � d�sactiver pour supprimer cette s�rie de test des logs.
const int TS_SQL_BASIS_ENABLED = TRUE;

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

void main()
{
    // On ex�cute les tests.
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
