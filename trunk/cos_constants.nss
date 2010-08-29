/**************************************************************************************************/
/** Nom :              cos_constants
/** Date de cr‚ation : 29/08/2010
/** Version :          1.0.0
/** Cr‚ateur :         Peluso Loup
/******************************************* ChangeLog ********************************************/
/** V1.0.0 (par Peluso Loup) :
/**      Fichier contenant toutes les constantes du syst‡me central.
/**************************************************************************************************/

/******************************************* WAYPOINTS ********************************************/

/* Messages. */
const string MESS_WELCOME_ONTO_SERVER = "Bienvenue sur le serveur";

// Delay avant d'emmener le personnage quelque part.
const float DELAY_BEFORE_JUMP = 5.0f;

// Tag de l'objet contenant les variables globales du module.
const string COS_WP_GVSTOCK_TAG = "cos_wpGlobalVarStock";
const string COS_WP_GVSTOCK_RESREF = "nw_waypoint001";

const string COS_MODULE_IS_INIT = "ModuleIsInit";

// Nom des variables locales contenants les r sultats des fonctions des  v nements.
const string F_GET_LAST_USED_BY = "GetLastUsedBy";

/** CONSTANTES DU SYSTEME DE VARIABLES GLOBALES **/
// SGVN = Stocked Global Variable Name.
const string ENTERING_OBJECT = "EnteringObject";

// Nom du waypoint associ    chaque personnage. Ce waypoint contient toutes les donn es
// du personnage, ce qui permet d' viter leur modification en mode DM.
const string COS_WP_CHARDATA_VARNAME = "cos_wpCharDatas";
const string COS_WP_CHARDATA_TAG = "cos_wpCharDatas";
const string COS_WP_CHARDATA_RESREF = "nw_waypoint001";

// Variables stockant les donn es du personnage.
const string PC_ID = "PC_ID";
const string PC_ACCOUNT_ID = "PC_ACCOUNT_ID";
const string PC_KEY_ID = "PC_KEY_ID";
const string PC_KEY_ACCOUNT_LINK_ID = "PC_KEY_ACCOUNT_LINK_ID";
const string PC_STARTING_LOCATION = "PC_STARTING_LOCATION";