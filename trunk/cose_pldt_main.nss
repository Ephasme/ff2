/*********************************************************************/
/** Nom :              cose_pldt_main
/** Date de création : 12/04/2011
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lancé à chaque fois qu'un joueur meurt.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "cosa_log"
#include "rspa_main"

/************************** IMPLEMENTATIONS **************************/

void main() {
    object oPC = GetLastPlayerDied();
    object oKiller = GetLastHostileActor();
    cosLogPlayerDeath(oPC, oKiller);
}
