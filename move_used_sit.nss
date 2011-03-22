/*********************************************************************/
/** Nom :              move_used_sit
/** Date de cr�ation : 12/08/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script qui permet au personne de s'asseoir sur le pla�able qui le lance.
/*********************************************************************/

void main() {
    object oLastUsedBy = GetLastUsedBy();
    object oUsed = OBJECT_SELF;
    if (!GetIsObjectValid(GetSittingCreature(oUsed))) {
        AssignCommand(oLastUsedBy, ActionSit(oUsed));
    }
}
