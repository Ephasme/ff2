/**************************************************************************************************/
/** Nom :              cosa_constants
/** Date de création : 29/08/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/******************************************* ChangeLog ********************************************/
/** V1.0.0 (par Peluso Loup) :
/**      Fichier contenant toutes les constantes du système central.
/**************************************************************************************************/

/****************************************** ACTIVATEURS *******************************************/

// Défini si on doit logger les dialogues dans la base de donnée.
const int COS_LOG_PLAYER_CHAT = TRUE;

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

// Variables stockant les données du personnage.
const string COS_PC_ID                  = "COS_PCId";
const string COS_PC_ACCOUNT_ID          = "COS_PCAccountId";
const string COS_PC_KEY_ID              = "COS_PCKeyId";
const string COS_PC_STARTLOC            = "COS_PCStartLoc";
const string COS_PC_LASTAREA_TAG        = "COS_PCLastAreaTag";

// Variables globales stockant les dernières données des évènements.
const string COS_GV_ON_ENTER = "COS_GV_OnEnter";

/****************************** NOMS DES SCRIPTS SYSTEME A EXECUTER *******************************/

const string COS_AFK_ON_ENTER_AREA = "afke_entr_area"; /* AFK */ 

/************************************** CONSTANTES DES LOGS ***************************************/

const string COS_LOG_CL_ENTER = "ClientEnter";
const string COS_LOG_CL_LEAVE = "ClientLeave";
const string COS_LOG_MOD_LOAD = "ModuleLoad";
const string COS_LOG_CHAT = "PlayerChat";
const string COS_LOG_TRANSITION = "Transition";
const string COS_LOG_PLAYER_DEATH = "PlayerDeath";
const string COS_LOG_PLAYER_RESPAWN = "PlayerRespawn";
const string COS_LOG_ATH_FLUSH = "ATH_Flush"; /* ATH */

const string COS_LOG_PC_VICTIM_ID = "VictimID";
const string COS_LOG_PC_KILLER_ID = "KillerID";
const string COS_LOG_PC_KILLER_TAG = "KillerTag";
const string COS_LOG_KILL_TYPE = "KillType";
const string COS_LOG_PVP_KILL = "PvP";
const string COS_LOG_PVM_KILL = "PvM";
const string COS_LOG_PC_ORIGIN = "PCOrig";
const string COS_LOG_PC_DESTINATION = "PCDest";
const string COS_LOG_PC_IS_FIGHTING = "PCFight";
const string COS_LOG_PC_ID = "PCId";
const string COS_LOG_PC_ACCOUNT_ID = "PCAccount";
const string COS_LOG_PC_KEY_ID = "PCKey";
const string COS_LOG_TEXT = "Texte";

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
