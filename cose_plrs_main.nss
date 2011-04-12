/*********************************************************************/
/** Nom :              cose_plrs_main
/** Date de création : 12/04/2011
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lancé à chaque fois qu'un joueur respawn.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "cosa_log"
#include "rspa_main"

/************************** IMPLEMENTATIONS **************************/

void main() {
	// On récupère les données.
	object oPC = GetLastRespawnButtonPresser();
	
	// On log le respawn en base de donnée.
	cosLogPlayerRespawn(oPC);
	
	// On téléporte le personnage dans la zone de respawn.
	rspMoveToRespawnDestination(oPC);
}
