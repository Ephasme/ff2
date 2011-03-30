/**************************************************************************************************/
/** Nom :              atha_constants
/** Date de création : 26/03/2011
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/******************************************* ChangeLog ********************************************/
/** V1.0.0 (par Peluso Loup) :
/**      Fichier contenant toutes les constantes du système de permissions.
/**************************************************************************************************/

const int ATH_SYSTEM_ENABLED = TRUE;

// Niveaux de permission.
const int ATH_FORBIDDEN = 1; // La permission est refusée.
const int ATH_ALLOWED = 2; // La permission est accordée (prévaut sur FORBIDDEN).
const int ATH_RESTRICTED = 3; // Ce niveau correspond au fait que la permission ne sera jamais accordée. Prévaut sur les deux précédentes.

const int ATH_GRANT = 1;
const int ATH_BANKEY = 2;
const int ATH_BANACCOUNT = 3;
const int ATH_BANCHAR = 4;
const int ATH_JUMP = 5;
const int ATH_TRANSITION = 6;

// SQL Tables
const string ATH_SQLT_AUTH_TO_CHAR = "`ath_auth_to_char`";
const string ATH_SQLT_AUTH = "`ath_auth`";
const string ATH_SQLT_CHAR_TO_GROUP = "`ath_char_to_group`";
const string ATH_SQLT_GROUP = "`ath_group`";
const string ATH_SQLT_AUTH_TO_GROUP_AUTH = "`ath_auth_to_group`";
const string ATH_SQLT_GLOBAL = "`ath_global`";
// SQL Fields
const string ATH_SQLF_ID = "`id`";
const string ATH_SQLF_ID_CHAR = "`id_char`";
const string ATH_SQLF_ID_GROUP = "`id_group`";
const string ATH_SQLF_ID_AUTH = "`id_auth`";
const string ATH_SQLF_CREATION = "`creation`";
const string ATH_SQLF_NAME = "`name`";
const string ATH_SQLF_AUTH_TYPE = "`auth_type`";