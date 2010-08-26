/*********************************************************************/
/** Nom :              scm_in_cm_invent
/** Date de cr�ation : 12/08/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant la liste des commandes relatives � la
/**   gestion des inventaires des personnages.
/*********************************************************************/

/***************************** INCLUDES ******************************/

    // Donnees de config.
    // #include "cos_in_config"

    // Fonctions de manipulation des cha�nes de caract�res.
    // #include "usu_in_strings"
// Fonctions de manipulation et de tra�tement.
#include "scm_in_util"

/***************************** CONSTANTES ****************************/

// Constantes de langue.
const string L_YOU_SAVED_THIS_POSITION_IN_THE_VARIABLE = "Vous avez sauv� cette position dans la variable";
const string L_YOU_CAN_REUSE_IT_TO_RETURN_THERE_AUTOMATICALLY = "Vous pourrez la r�utiliser pour y revenir automatiquement.";

// Nom des commandes.
const string SCM_COM_SAVE_INVENTORY_STATE = "save_inventory_state";

// Param�tres des commandes.

/***************************** PROTOTYPES ****************************/


/************************** IMPLEMENTATIONS **************************/
