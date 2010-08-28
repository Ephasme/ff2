/*********************************************************************/
/** Nom :              cos_clic_main
/** Date de cr�ation : 12/08/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script se lan�ant � chaque fois qu'un PJ clique sur un
/**    pla�able.
/*********************************************************************/

/***************************** INCLUDES ******************************/

// Fichier de configuration.
#include "cos_config"

/************************** IMPLEMENTATIONS **************************/

void main() {
    // On r�cup�re les donn�es.
    object oPC = GetClickingObject();
    object oPlaceable = GetPlaceableLastClickedBy();
}
