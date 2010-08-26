/*********************************************************************/
/** Nom :              mov_ev_on_used
/** Date de création : 12/08/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script à faire exécuter par cos_ev_on_used.
/*********************************************************************/

/***************************** INCLUDES ******************************/

// Fichier de configuration.
#include "cos_in_config"

/***************************** CONSTANTES ****************************/

const string ON_USED_ACTION_SIT = "ON_USED_ACTION_SIT";
const string ON_USED_ACTION_ATTACK = "ON_USED_ACTION_ATTACK";

/************************** IMPLEMENTATIONS **************************/

void main() {
    object oLastUsedBy = GetLocalObject(OBJECT_SELF, F_GET_LAST_USED_BY);
    object oUsed = OBJECT_SELF;

    if (GetLocalInt(oUsed, ON_USED_ACTION_SIT)) {
        AssignCommand(oLastUsedBy, ActionSit(oUsed));
    } else if (GetLocalInt(oUsed, ON_USED_ACTION_ATTACK)) {
        AssignCommand(oLastUsedBy, ActionAttack(oUsed));
    }
}
