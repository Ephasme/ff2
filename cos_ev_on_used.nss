/*********************************************************************/
/** Nom :              cos_ev_on_used
/** Date de création : 12/08/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script se lançant à chaque fois qu'un item déclenche
/**   l'évènement OnUsed.
/*********************************************************************/

/***************************** INCLUDES ******************************/

// Fichier de configuration.
#include "cos_in_config"

/************************** IMPLEMENTATIONS **************************/

void main() {
    object oThis = OBJECT_SELF;
    object oLastUsedBy = GetLastUsedBy();
    SetLocalObject(oThis, F_GET_LAST_USED_BY, oLastUsedBy);

    if (oLastUsedBy != OBJECT_INVALID && oThis != OBJECT_INVALID) {
        // On exécute les scripts des émotes de base.
        ExecuteScript("mov_ev_on_used", oThis);
    }
}
