/*********************************************************************/
/** Nom :              rpsbpl_clic_jump
/** Date de cr�ation : 12/04/2011
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script qui va t�l�porter le joueur � son point de respawn.
/*********************************************************************/

/************************** INCLUDES *********************************/

#include "rspa_main"

/************************** IMPLEMENTATIONS **************************/

void main() {
	// On d�place le PJ au point de respawn.
	if (GetIsPC(OBJECT_SELF)) {
		rspMoveToRespawnOrigin(OBJECT_SELF);
	}
}
