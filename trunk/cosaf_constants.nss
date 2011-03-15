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
const float  COS_JUMP_DELAY          = 5.0f;
const string COS_MOD_IS_INIT_VARNAME = "COS_ModuleIsInit";

// Variables stockant les données du personnage.
const string COS_PC_ID                  = "COS_PCId";
const string COS_PC_ACCOUNT_ID          = "COS_PCAccountId";
const string COS_PC_KEY_ID              = "COS_PCKeyId";
const string COS_PC_KEY_ACCOUNT_LINK_ID = "COS_PCKeyAccountLinkId";
const string COS_PC_STARTLOC            = "COS_PCStartLoc";

/****************************** NOMS DES SCRIPTS SYSTEME A EXECUTER *******************************/

const string COS_TCT_ON_CLIENT_ENTER = "tctef_clen_main";

/*************************************** SQL CONFIGURATION ****************************************/
// Tables.
const string COS_SQLT_ACCOUNT = "`cos_account`";
const string COS_SQLT_CHAR = "`cos_char`";
const string COS_SQLT_CDKEY = "`cos_cdkey`";
const string COS_SQLT_CDKEY_TO_ACCOUNT = "`cos_cdkey_to_account`";
// Champs.
const string COS_SQLF_ID = "`id`";
const string COS_SQLF_ID_ACCOUNT = "`id_account`";
const string COS_SQLF_ID_CDKEY = "`id_cdkey`";
const string COS_SQLF_NAME = "`name`";
const string COS_SQLF_START_LOC = "`starting_location`";
const string COS_SQLF_LAST_CNX = "`last_connexion`";
const string COS_SQLF_CREATION = "`creation`";
const string COS_SQLF_BAN = "`ban`";
const string COS_SQLF_CDKEY = "`cdkey`";