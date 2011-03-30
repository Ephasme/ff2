/*********************************************************************/
/** Nom :              cose_exit_area
/** Date de création : 22/03/2011
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lancé à chaque fois qu'un personnage sort d'une zone. 
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "cosa_log"
#include "atha_main"

/************************** IMPLEMENTATIONS **************************/

void main() {

	// On récupère le PC.
	object oPC = GetExitingObject();

	// ==== Système ATH ====
	// Est-ce que le PJ peut quitter une zone ?
	// TODO : Stocker quelque part la position du PJ juste avant qu'il ne change de map, difficile... impossible ?
	if (athIsAllowed(ATH_EXITAREA, oPC)) {
		return;
	}
  
}
