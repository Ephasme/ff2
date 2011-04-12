/*********************************************************************/
/** Nom :              cose_plrs_main
/** Date de cr�ation : 12/04/2011
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lanc� � chaque fois qu'un joueur respawn.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "cosa_log"
#include "rspa_main"

/************************** IMPLEMENTATIONS **************************/

void main() {
	// On r�cup�re les donn�es.
	object oPC = GetLastRespawnButtonPresser();
	
	// On log le respawn en base de donn�e.
	cosLogPlayerRespawn(oPC);
	
	// On t�l�porte le personnage dans la zone de respawn.
	rspMoveToRespawnDestination(oPC);
}
