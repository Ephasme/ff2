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
const string COS_WP_GVSTOCK_TAG = "xx_cos_wp001_global_var_stock";
const string COS_WP_GVSTOCK_RESREF = "cos_wp001_gvstck";

const string COS_MODULE_IS_INIT = "ModuleIsInit";

// Nom des variables locales contenants les r sultats des fonctions des  v nements.
const string F_GET_LAST_USED_BY = "GetLastUsedBy";

/** CONSTANTES DU SYSTEME DE VARIABLES GLOBALES **/
// SGVN = Stocked Global Variable Name.
const string ENTERING_OBJECT = "EnteringObject";

// Nom du waypoint associ    chaque personnage. Ce waypoint contient toutes les donn es
// du personnage, ce qui permet d' viter leur modification en mode DM.
const string COS_PC_WP_VARNAME = "xx_cos_wp000_char_data";
const string COS_PC_WP_TAG = "xx_cos_wp000_char_data";
const string COS_PC_WP_RESREF = "cos_wp000_chdt";

// Variables stockant les donn es du personnage.
const string PC_ID = "PC_ID";
const string PC_ACCOUNT_ID = "PC_ACCOUNT_ID";
const string PC_KEY_ID = "PC_KEY_ID";
const string PC_KEY_ACCOUNT_LINK_ID = "PC_KEY_ACCOUNT_LINK_ID";
const string PC_STARTING_LOCATION = "PC_STARTING_LOCATION";


