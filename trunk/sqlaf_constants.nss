/**************************************************************************************************/
/** Nom :              sqlaf_constants
/** Date de création : 29/08/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/******************************************* ChangeLog ********************************************/
/** V1.0.0 (par Peluso Loup) :
/**      Fichier contenant toutes les constantes du système de connexion à MySQL.
/**************************************************************************************************/

/* Nom du Waypoint contenant le buffer. */
const string SQL_WP_BUFFER_TAG = "sql_wpRequestBuffer";
const string SQL_WP_BUFFER_RESREF = "nw_waypoint001";

/* Erreurs. */
const int SQL_ERROR = 0;
const int SQL_SUCCESS = 1;

/* SQL Quotation. */
//const string SQL_QUOTE = "&#34";
const string SQL_QUOTE = "'";

// SQL Config.
// Tables.
const string SQL_T_ACCOUNTS = "`accounts`";
const string SQL_T_CHARS = "`characters`";
const string SQL_T_CDKEYS = "`cdkeys`";
const string SQL_T_CDKEY_ACCOUNT_LINKS = "`cdkey_account_links`";

// Champs.
const string SQL_F_ID = "`id`";
const string SQL_F_ID_ACCOUNT = "`id_account`";
const string SQL_F_ID_CDKEY = "`id_cdkey`";

const string SQL_F_NAME = "`name`";
const string SQL_F_START_LOC = "`starting_location`";
const string SQL_F_LAST_CNX = "`last_connexion`";
const string SQL_F_CREATION = "`creation`";
const string SQL_F_BAN = "`ban`";
const string SQL_F_CDKEY = "`cdkey`";

