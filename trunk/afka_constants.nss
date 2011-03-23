/**************************************************************************************************/
/** Nom :              afka_constants
/** Date de cr�ation : 22/03/2011
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/******************************************* ChangeLog ********************************************/
/** V1.0.0 (par Peluso Loup) :
/**      Fichier contenant toutes les constantes du syst�me d'afk.
/**************************************************************************************************/

// Activateur du syst�me de mise en AFK.
const int AFK_SYSTEM_ENABLED = TRUE;

// Waypoint d'arriv�e sur la map.
const string AFK_DEST_WP_TAG = "spe02_wp_0_dest";

// Nom de la map qui sert de zone AFK.
const string AFK_AREA_TAG = "spe_ar_02";

// Variable stockant l'�tat AFK du personnage.
const string AFK_LAST_LOCATION = "AFK_LastLoc";
const string AFK_IS_ACTIVATED = "AFK_IsActivated";