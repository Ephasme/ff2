/*********************************************************************/
/** Nom :              cos_clen_main
/** Date de création : 12/07/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lancé à chaque fois qu'un client NWN se connecte.
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
    // Déclarations de variables.
    object oPC;

    // On récupère le personnage qui vient d'arriver.
    oPC = GetEnteringObject();

    // On vérifie que le module est bien initialisé et que le personnage est valide.
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

    // On met à jour la date de dernière connexion du personnage et du compte du joueur.
    cosUpdateLastConnexion(oPC);

    // On vérifie si le joueur est banni.
    if (cosIsBan(oPC)) {
        BootPC(oPC);
        return;
    }

    // On charge sa position de départ.
    cosLoadPCStartingLocation(oPC);
    if (cosPCStartingLocationValid(oPC)) {
        // On y expédie le personnage.
        DelayCommand(DELAY_BEFORE_JUMP, cosJumpToPCStartingLocation(oPC));
    }

    // On affiche un message de bienvenue.
    FloatingTextStringOnCreature(MESS_WELCOME_ONTO_SERVER+" "+GetName(oPC)+" !", oPC);
}
