/*********************************************************************/
/** Nom :              cos_config
/** Date de création : 12/07/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les constantes de configuration du module.
/*********************************************************************/

/***************************** CONSTANTES ****************************/

// Activation des systèmes.
const int SMC_ENABLED = TRUE; // Commandes.

// Tag de l'objet contenant les variables globales du module.
const string COS_WP_GVSTOCK_TAG = "xx_cos_wp001_global_var_stock";
const string COS_WP_GVSTOCK_RESREF = "cos_wp001_gvstck";

// Tag de l'objet contenant les HashSet du module.
const string COS_WP_GVHASH_TAG = "xx_cos_wp002_hash_set";
const string COS_WP_GVHASH_RESREF = "cos_wp002_hashst";

const string COS_MODULE_IS_INIT = "ModuleIsInit";

// Nom des variables locales contenants les résultats des fonctions des évènements.
const string F_GET_LAST_USED_BY = "GetLastUsedBy";
