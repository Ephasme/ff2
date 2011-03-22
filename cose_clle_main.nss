/*********************************************************************/
/** Nom :              cose_clle_main
/** Date de création : 18/01/2011
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lancé à chaque fois qu'un client NWN se déconnecte.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "cosa_log"

/************************** IMPLEMENTATIONS **************************/

void main() {
    // On récupère le personnage qui part.
    object oPC = GetExitingObject();

    // On log son départ en BDD.
    cosLogClientLeave(oPC);
}
