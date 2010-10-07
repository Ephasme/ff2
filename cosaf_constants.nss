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