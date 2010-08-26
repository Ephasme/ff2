/*********************************************************************/
/** Nom :              scm_in_cm_invent
/** Date de création : 12/08/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant la liste des commandes relatives à la
/**   gestion des inventaires des personnages.
/*********************************************************************/

/***************************** INCLUDES ******************************/

    // Donnees de config.
    // #include "cos_in_config"

    // Fonctions de manipulation des chaînes de caractères.
    // #include "usu_in_strings"
// Fonctions de manipulation et de traîtement.
#include "scm_in_util"

/***************************** CONSTANTES ****************************/

// Constantes de langue.
const string L_YOU_SAVED_THIS_POSITION_IN_THE_VARIABLE = "Vous avez sauvé cette position dans la variable";
const string L_YOU_CAN_REUSE_IT_TO_RETURN_THERE_AUTOMATICALLY = "Vous pourrez la réutiliser pour y revenir automatiquement.";

// Nom des commandes.
const string SCM_COM_SAVE_INVENTORY_STATE = "save_inventory_state";

// Paramètres des commandes.

/***************************** PROTOTYPES ****************************/


/************************** IMPLEMENTATIONS **************************/
