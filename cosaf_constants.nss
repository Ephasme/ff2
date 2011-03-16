/**************************************************************************************************/
/** Nom :              cosaf_constants
/** Date de création : 29/08/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/******************************************* ChangeLog ********************************************/
/** V1.0.0 (par Peluso Loup) :
/**      Fichier contenant toutes les constantes du système central.
/**************************************************************************************************/

/******************************************* WAYPOINTS ********************************************/

// Tag de l'objet contenant les variables globales du module.
const string COS_WP_GVSTOCK_TAG      = "cos_wpGlobalVarStock";
const string COS_WP_GVSTOCK_RESREF   = "nw_waypoint001";
// Waypoint contenant les données des personnages joueurs.
const string COS_WP_CHARDATA_VARNAME = "cos_wpCharDatas";
const string COS_WP_CHARDATA_TAG     = "cos_wpCharDatas";
const string COS_WP_CHARDATA_RESREF  = "nw_waypoint001";

/******************************************** MESSAGES ********************************************/

const string COS_M_WELCOME_ONTO_SERVER = "Bienvenue sur le serveur";

/************************************** CONSTANTES DIVERSES ***************************************/

// Delay avant d'emmener le personnage quelque part.
const float  COS_SAVEPOS_DELAY          = 5.0f;

// Variable stockant le nom de la variable d'initialisation du module.
const string COS_MOD_IS_INIT_VARNAME    = "COS_ModuleIsInit";

// Variable stockant la location de départ par défaut.
const string COS_DEFAULT_STARTLOC       = "##sys_ar_000##0.000##0.000##0.000##0.000";

// Variables stockant les données du personnage.
const string COS_PC_ID                  = "COS_PCId";
const string COS_PC_ACCOUNT_ID          = "COS_PCAccountId";
const string COS_PC_KEY_ID              = "COS_PCKeyId";
const string COS_PC_STARTLOC            = "COS_PCStartLoc";

/****************************** NOMS DES SCRIPTS SYSTEME A EXECUTER *******************************/

const string COS_TCT_ON_CLIENT_ENTER = "tctef_clen_main";

/****************************** NOMS DES SCRIPTS SYSTEME A EXECUTER *******************************/
const string COS_LOG_PCIN = "PC_IN";
const string COS_LOG_PCOUT = "PC_OUT";
const string COS_LOG_INFO_PCID = "PCId";
const string COS_LOG_INFO_PCNAME = "PCName";
const string COS_LOG_INFO_PCACCOUNT = "PCAccount";
const string COS_LOG_INFO_PCKEY = "PCKey";

/*************************************** SQL CONFIGURATION ****************************************/
// Tables.
const string COS_SQLT_ACCOUNT = "`cos_account`";
const string COS_SQLT_CHAR = "`cos_char`";
const string COS_SQLT_CHAR_DATA = "`cos_char_data`";
const string COS_SQLT_CDKEY = "`cos_cdkey`";
const string COS_SQLT_CDKEY_TO_ACCOUNT = "`cos_cdkey_to_account`";
const string COS_SQLT_LOG = "`cos_log`";
const string COS_SQLT_LOG_DATA = "`cos_log_data`";
// Champs.
const string COS_SQLF_ID = "`id`";
const string COS_SQLF_ID_CHAR = "`id_char`";
const string COS_SQLF_ID_ACCOUNT = "`id_account`";
const string COS_SQLF_ID_CDKEY = "`id_cdkey`";
const string COS_SQLF_ID_LOG = "`id_log`";
const string COS_SQLF_VALUE = "`value`";
const string COS_SQLF_NAME = "`name`";
const string COS_SQLF_START_LOC = "`starting_location`";
const string COS_SQLF_LAST_CNX = "`last_connexion`";
const string COS_SQLF_LAST_UPDATE = "`last_update`";
const string COS_SQLF_CREATION = "`creation`";
const string COS_SQLF_BAN = "`ban`";
