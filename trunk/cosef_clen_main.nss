/*********************************************************************/
/** Nom :              cosef_clen_main
/** Date de cr�ation : 12/07/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lanc� � chaque fois qu'un client NWN se connecte.
/*********************************************************************/

/***************************** INCLUDES ******************************/

    // #include "cosaf_constants"
#include "cosaf_globalvar"

                // #include "usuaf_strtokman"
            // #include "usuaf_locmanip"
            // #include "sqlaf_constants"
        // #include "sqlaf_main"
    // #include "sqlaf_charmanips"
    // #include "cosaf_constants"
#include "cosaf_pcmanips"

/************************** IMPLEMENTATIONS **************************/

void main() {
    // D�clarations de variables.
    object oPC;

    // On r�cup�re le personnage qui vient d'arriver.
    oPC = GetEnteringObject();

    // On v�rifie que le module est bien initialis� et que le personnage est valide.
    if (!(cosGetGlobalInt(COS_MOD_IS_INIT_VARNAME) &&
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

    // On ex�cute les scripts de syst�mes �ventuels.
    ExecuteScript(COS_TCT_ON_CLIENT_ENTER, oPC);

    // On charge sa position de d�part.
    cosLoadPCStartingLocation(oPC);
    if (cosPCStartingLocationValid(oPC)) {
        // On y exp�die le personnage.
        DelayCommand(COS_JUMP_DELAY, cosJumpToPCStartingLocation(oPC));
    }

    // Ex�cution des scripts de test.
    ExecuteScript("ts_cos_sys", oPC);
    ExecuteScript("ts_usu_sys", oPC);
    ExecuteScript("ts_cmd_sys", oPC);
    ExecuteScript("ts_sql_sys", oPC);

    // On affiche un message de bienvenue.
    FloatingTextStringOnCreature(MESS_WELCOME_ONTO_SERVER+" "+GetName(oPC)+" !", oPC);
}
