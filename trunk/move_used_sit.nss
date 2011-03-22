/*********************************************************************/
/** Nom :              move_used_sit
/** Date de création : 12/08/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script qui permet au personne de s'asseoir sur le plaçable qui le lance.
/*********************************************************************/

void main() {
    object oLastUsedBy = GetLastUsedBy();
    object oUsed = OBJECT_SELF;
    if (!GetIsObjectValid(GetSittingCreature(oUsed))) {
        AssignCommand(oLastUsedBy, ActionSit(oUsed));
    }
}
