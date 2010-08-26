/*********************************************************************/
/** Nom :              cos_in_config
/** Date de cr�ation : 12/07/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les constantes de configuration du module.
/*********************************************************************/

/***************************** CONSTANTES ****************************/

// Activation des syst�mes.
const int SMC_ENABLED = TRUE; // Commandes.

// Tag de l'objet contenant les variables globales du module.
const string GV_STOCK_OBJECT_TAG = "varstockwp";
const string GV_STOCK_OBJECT_RESREF = "varstockwp";
const string GV_MODULE_INIT_IS_OK = "InitComplete";

// Tag de l'objet contenant les HashSet du module.
const string GV_HASH_WAYPOINT_TAG = "hashwp";
const string GV_HASH_WAYPOINT_RESREF = "hashwp";

// Nom des variables locales contenants les r�sultats des fonctions des �v�nements.
const string F_GET_LAST_USED_BY = "GetLastUsedBy";
