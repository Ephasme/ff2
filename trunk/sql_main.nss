/*********************************************************************/
/** Nom :              sql_main
/** Date de création : 12/07/2010
/** Version :          1.0.0
/** Createur :         Loup Peluso
/***************************** ChangeLog *****************************/
/** V1.0.0 :
/**      Mise en place des fonctions de base nécessaires au bon
/**   fonctionnement des accès à la base de donnée MySQL. Ce script
/**   contient le strict minimum pour une connection à la BDD.
/*********************************************************************/

/***************************** INCLUDES ******************************/

    // #include "usu_stringtokman"
#include "usu_locmanip"

/***************************** CONSTANTES ****************************/

/* Nom du Waypoint contenant le buffer. */
const string SQLWP_TAG = "wpsql";
const string SQLWP_RESREF = "wpsql";

/* Message de Debug. */
const string MESS_DEBUG_QUERY = "Requête SQL";

/* Erreurs. */
const int SQL_ERROR = 0;
const int SQL_SUCCESS = 1;

/* SQL Quotation. */
//const string SQL_QUOTE = "&#34";
const string SQL_QUOTE = "'";

// SQL Config.
// Tables.
const string TABLE_ACCOUNTS = "`accounts`";
const string TABLE_CHARACTERS = "`characters`";
const string TABLE_CDKEYS = "`cdkeys`";
const string TABLE_CDKEY_ACCOUNT_LINKS = "`cdkey_account_links`";

// Champs.
const string ID = "`id`";
const string ID_ACCOUNT = "`id_account`";
const string ID_CDKEY = "`id_cdkey`";

const string NAME = "`name`";
const string STARTING_LOCATION = "`starting_location`";
const string LAST_CONNEXION = "`last_connexion`";
const string LEVEL = "`level`";
const string CREATION = "`creation`";
const string BAN = "`ban`";
const string CDKEY = "`cdkey`";

/***************************** VARIABLES *****************************/

/* Waypoint qui servira de réceptacle aux requêtes SQL. */
object oSQLWP = OBJECT_INVALID;
/* Variable qui servira de buffer. */
string S_LOCAL_BUFFER;

/***************************** PROTOTYPES ****************************/

// DEF IN "sql_main"
// Fonction d'initialisation de MySQL.
void sqlInit();

// DEF IN "sql_main"
// Renvoie l'objet correspondant au Waypoint SQL.
//   o object - Waypoint SQL.
object sqlGetWaypoint();

// DEF IN "sql_main"
// Fonction qui exécute une requête SQL.
//   > string sQuery - Requête à exécuter.
void sqlExecDirect(string sQuery);

// DEF IN "sql_main"
// Fonction qui place le curseur sur la ligne suivante (en commençant par la première).
//   o int - SQL_SUCCESS si le curseur à été déplacé, SQL_ERROR sinon (fin des lignes).
int sqlFetch();

// DEF IN "sql_main"
// Fonction qui permet de récupérer les données préalablement fetchées.
//   > int iCol - Numéro de la colonne de la ligne actuelle qui contient la valeur à récupérer.
//   o string - Donnée récupérée.
string sqlGetData(int iCol);

// DEF IN "sql_main"
// Fonction qui permet d'exécuter et de récupérer directement la valeur de la requête sous
// la forme d'un entier unique (à utiliser pour récupérer l'ID d'un personnage par exemple).
// EAFD signifie ExecAndFetchDirect.
//   > string sQuery - Requête à exécuter.
//   o int - Entier récupéré, résultat de la requête.
int sqlEAFDSingleInt(string sQuery);

// DEF IN "sql_main"
// Fonction qui permet d'exécuter et de récupérer directement la valeur de la requête
// sous la forme d'une location (à utiliser pour récupérer le point de départ d'un personnage par exemple).
// EAFD signifie ExecAndFetchDirect.
//   > string sQuery - Requête à exécuter.
//   o location - Location récupérée, résultat de la requête (renvoie le point de départ du module en cas d'erreur).
location sqlEAFDSingleLocation(string sQuery);

// DEF IN "sql_main"
// Fonction qui permet de récupérer un entier ou, si c'est impossible, d'exécuter une insertion.
// EAFD signifie ExecAndFetchDirect.
//   > string sSelectQuery - Requête de sélection à exécuter.
//   > string sInsertQuery - Insertion dans le cas d'une sélection vide.
//   > int iDepth - Profondeur de récursivité (à ne pas définir).
//   o int - Entier récupéré, résultat de la requête.
int sqlEAFDSingleIntOrInsert(string sSelectQuery, string sInsertQuery, int iDepth = 0);

// DEF IN "sql_main"
// Cette fonction crée une structure sub_query.
//   > string sQuery - Select correspondant à la sous-requête désirée.
//   > string sAlias - Alias de la sous-requête.
//   o struct sub_query - Structure de sous-requête.
struct sub_query sqlSetSubQuery(string sQuery, string sAlias);

// DEF IN "sql_main"
// Cette fonction rajoute les caractères de quotation en début et en fin de chaîne.
//   > string sString - Chaîne à quoter.
//   o string - Chaîne modifiée.
string sqlQuote(string sString);

/***************************** STRUCTURES ****************************/

// Structure permettant de gérer les sous-requêtes SQL.
struct sub_query {
    string sQuery;
    string sAlias;
};

/************************** IMPLEMENTATIONS **************************/

void sqlInit() {
    int i;
    string sStringBuffer;

    // Réservation de 128 bits de mémoire.
    for (i = 0; i < 8; i++) {
        sStringBuffer += "................................................................................................................................";
    }
    // Laisse de l'espace entre chaque résultat de requêtes.
    SetLocalString(sqlGetWaypoint(), "NWNX!ODBC!SPACER", sStringBuffer);
}

object sqlGetWaypoint() {
    object oSQLWP = GetWaypointByTag(SQLWP_TAG);
    if (oSQLWP == OBJECT_INVALID) {
        oSQLWP = CreateObject(OBJECT_TYPE_WAYPOINT, SQLWP_RESREF, GetStartingLocation(), FALSE, SQLWP_TAG);
    }
    return oSQLWP;
}

void sqlExecDirect(string sQuery) {
    // Envoie la requête au module NWNX pour l'éxécuter.
    SetLocalString(sqlGetWaypoint(), "NWNX!ODBC!EXEC", sQuery);
}

int sqlFetch()
{
    string sRow;
    object oWP = sqlGetWaypoint();

    SetLocalString(oWP, "NWNX!ODBC!FETCH", GetLocalString(oWP, "NWNX!ODBC!SPACER"));
    sRow = GetLocalString(oWP, "NWNX!ODBC!FETCH");
    if (GetStringLength(sRow) > 0)
    {
        SetLocalString(oWP, "NWNX_ODBC_CurrentRow", sRow);
        return SQL_SUCCESS;
    }
    else
    {
        SetLocalString(oWP, "NWNX_ODBC_CurrentRow", "");
        return SQL_ERROR;
    }
}

string sqlGetData(int iCol)
{
    int iPos;
    string sResultSet = GetLocalString(sqlGetWaypoint(), "NWNX_ODBC_CurrentRow");

    // find column in current row
    int iCount = 0;
    string sColValue = "";

    iPos = FindSubString(sResultSet, "¬");
    if ((iPos == -1) && (iCol == 1))
    {
        // only one column, return value immediately
        sColValue = sResultSet;
    }
    else if (iPos == -1)
    {
        // only one column but requested column > 1
        sColValue = "";
    }
    else
    {
        // loop through columns until found
        while (iCount != iCol)
        {
            iCount++;
            if (iCount == iCol)
                sColValue = GetStringLeft(sResultSet, iPos);
            else
            {
                sResultSet = GetStringRight(sResultSet, GetStringLength(sResultSet) - iPos - 1);
                iPos = FindSubString(sResultSet, "¬");
            }

            // special case: last column in row
            if (iPos == -1)
                iPos = GetStringLength(sResultSet);
        }
    }

    return sColValue;
}

int sqlEAFDSingleInt(string sQuery) {
    sqlExecDirect(sQuery);
    sqlFetch();
    string sRes = sqlGetData(1);
    if (sRes == "") {
        return SQL_ERROR;
    } else {
        return StringToInt(sRes);
    }
}

location sqlEAFDSingleLocation(string sQuery) {
    sqlExecDirect(sQuery);
    sqlFetch();
    string sRes = sqlGetData(1);
    if (sRes == "") {
        return GetStartingLocation();
    } else {
        return usuStringToLocation(sRes);
    }
}

int sqlEAFDSingleIntOrInsert(string sSelectQuery, string sInsertQuery, int iDepth = 0) {
    if (iDepth < 2) {
        // On exécute la requête de récupération de la valeur.
        sqlExecDirect(sSelectQuery);

        sqlFetch();

        if (TRUE) {
            // On extrait la valeur après avoir récupéré les données.
            string sRes = sqlGetData(1);
            if (sRes == "") {
                // Aucune valeur récupérée, on exécute l'insertion et on augmente d'un la profondeur de récursivité.
                sqlExecDirect(sInsertQuery);
                return sqlEAFDSingleIntOrInsert(sSelectQuery, sInsertQuery, ++iDepth);
            } else {
                // La valeur existe, on la renvoie.
                return StringToInt(sRes);
            }
        }
    }
    // Impossible d'exécuter les requêtes : base de donnée déconnectée ?
    return SQL_ERROR;
}

struct sub_query sqlSetSubQuery(string sQuery, string sAlias) {
    struct sub_query sqRes;
    sqRes.sQuery = sQuery;
    sqRes.sAlias = sAlias;
    return sqRes;
}

string sqlQuote(string sString) {
    return SQL_QUOTE+sString+SQL_QUOTE;
}
