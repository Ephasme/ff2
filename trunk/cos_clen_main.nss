/*********************************************************************/
/** Nom :              cos_clen_main
/** Date de cr�ation : 12/07/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lanc� � chaque fois qu'un client NWN se connecte.
/*********************************************************************/

/***************************** INCLUDES ******************************/


    // #include "cos_constants"
#include "cos_globalvar"

                // #include "usu_stringtokman"
            // #include "usu_locmanip"
            // #include "sql_constants"
        // #include "sql_main"
    // #include "sql_charmanips"
    // #include "cos_constants"
#include "cos_charmanips"

/************************** IMPLEMENTATIONS **************************/

void main() {
    // D�clarations de variables.
    object oPC;

    // On r�cup�re le personnage qui vient d'arriver.
    oPC = GetEnteringObject();

    // On v�rifie que le module est bien initialis� et que le personnage est valide.
    if (!(cosGetGlobalInt(COS_MODULE_IS_INIT) &&
          GetIsObjectValid(oPC) &&
          GetIsPC(oPC) &&
          (GetPCPublicCDKey(oPC) != ""))) {
        BootPC(oPC);
        return;
    }

    // On charge les identifiants du personnage.
    cosLoadPCIdentifiers(oPC);
    if (!cosIsPCIdentifiersValid(oPC)) {
        // Identifiants invalides.
        BootPC(oPC);
        return;
    }

    // On met � jour la date de derni�re connexion du personnage et du compte du joueur.
    cosUpdateLastConnexion(oPC);

    // On v�rifie si le joueur est banni.
    if (cosIsBan(oPC)) {
        BootPC(oPC);
        return;
    }

    // On charge sa position de d�part.
    cosLoadPCStartingLocation(oPC);
    if (cosPCStartingLocationValid(oPC)) {
        // On y exp�die le personnage.
        DelayCommand(DELAY_BEFORE_JUMP, cosJumpToPCStartingLocation(oPC));
    }

    // On affiche un message de bienvenue.
    FloatingTextStringOnCreature(MESS_WELCOME_ONTO_SERVER+" "+GetName(oPC)+" !", oPC);
}
