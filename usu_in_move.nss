/*********************************************************************/
/** Nom :              usu_in_move
/** Date de cr�ation : 21/07/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script regroupant les fonctions de d�placement.
/*********************************************************************/

// TODO: Rendre plus fiable le d�placement d'un point � l'autre et �viter que les personnages.
// ne cessent de courir quand ils franchissent une transition.

/***************************** CONSTANTES ****************************/

// Contantes de langue.
const string L_AUTOMATIC_MOVEMENT_UP_TO_THE_MAP = "D�placement automatique jusqu'� la map";
const string L_INSTANT_MOVING                   = "Mouvement instantan�";
const string L_TO_THE_POSITION                  = "A la position";

/***************************** PROTOTYPES ****************************/

// DEF IN "usu_in_move"
// Fonction qui ram�ne le personnage � un endroit d�fini.
//   > object oPC - PJ que l'on projette de d�placer.
//   > location lLoc - Localisation o� le PJ doit �tre d�plac�.
//   > int iRun - Le personnage court si la valeur est fix�e sur TRUE.
//   > int iJump - Le d�placement est instantan� si la valeur est fix�e sur TRUE.
void usuMoveToLocation(object oPC, location lLoc, int iRun = FALSE, int iJump = FALSE);

/************************** IMPLEMENTATIONS **************************/

void usuMoveToLocation(object oPC, location lLoc, int iRun = FALSE, int iJump = FALSE) {
    string sAreaName = GetName(GetAreaFromLocation(lLoc));
    vector vVect = GetPositionFromLocation(lLoc);
    string sPos = "("+FloatToString(vVect.x, 0, 2)+", "+
                      FloatToString(vVect.y, 0, 2)+", "+
                      FloatToString(vVect.z, 0, 2)+")";
    string sMess = L_AUTOMATIC_MOVEMENT_UP_TO_THE_MAP+" "+sAreaName+".\n"+L_TO_THE_POSITION+" :\n"+sPos+".";
    if (iJump) {
        sMess += L_INSTANT_MOVING+".";
        AssignCommand(oPC, ActionJumpToLocation(lLoc));
    } else {
        // On cr�e une variable locale qui permet de d�terminer si le personnage � atteint sa destination.
        AssignCommand(oPC, ActionMoveToLocation(lLoc, iRun));
    }
    SendMessageToPC(oPC, sMess);
}

