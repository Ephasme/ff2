/*********************************************************************/
/** Nom :              cos_ev_on_click
/** Date de création : 12/08/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script se lançant à chaque fois qu'un PJ clique sur un
/**    plaçable.
/*********************************************************************/

/***************************** INCLUDES ******************************/

// Fichier de configuration.
#include "cos_in_config"

/************************** IMPLEMENTATIONS **************************/

void main() {
    // On récupère les données.
    object oPC = GetClickingObject();
    object oPlaceable = GetPlaceableLastClickedBy();
}
