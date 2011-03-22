/*********************************************************************/
/** Nom :              cose_clle_main
/** Date de cr�ation : 18/01/2011
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lanc� � chaque fois qu'un client NWN se d�connecte.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "cosa_log"

/************************** IMPLEMENTATIONS **************************/

void main() {
    // On r�cup�re le personnage qui part.
    object oPC = GetExitingObject();

    // On log son d�part en BDD.
    cosLogClientLeave(oPC);
}
