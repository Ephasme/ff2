/*********************************************************************/
/** Nom :              cosef_clen_main
/** Date de création : 12/07/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lancé à chaque fois qu'un client NWN se connecte.
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
    // Déclarations de variables.
    object oPC;

    // On récupère le personnage qui vient d'arriver.
    oPC = GetEnteringObject();

    // On vérifie que le module est bien initialisé et que le personnage est valide.
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

    // On met à jour la date de dernière connexion du personnage et du compte du joueur.
    cosUpdateLastConnexion(oPC);

    // On vérifie si le joueur est banni.
    if (cosIsBan(oPC)) {
        BootPC(oPC);
        return;
    }

    // On exécute les scripts de systèmes éventuels.
    ExecuteScript(COS_TCT_ON_CLIENT_ENTER, oPC);

    // On charge sa position de départ.
    cosLoadPCStartingLocation(oPC);
    if (cosPCStartingLocationValid(oPC)) {
        // On y expédie le personnage.
        DelayCommand(COS_JUMP_DELAY, cosJumpToPCStartingLocation(oPC));
    }

    // Exécution des scripts de test.
    ExecuteScript("ts_cos_sys", oPC);
    ExecuteScript("ts_usu_sys", oPC);
    ExecuteScript("ts_cmd_sys", oPC);
    ExecuteScript("ts_sql_sys", oPC);

    // On affiche un message de bienvenue.
    FloatingTextStringOnCreature(MESS_WELCOME_ONTO_SERVER+" "+GetName(oPC)+" !", oPC);
}
