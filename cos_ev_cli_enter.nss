/*********************************************************************/
/** Nom :              cos_ev_cli_enter
/** Date de création : 12/07/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lancé à chaque fois qu'un client NWN se connecte.
/*********************************************************************/

/***************************** INCLUDES ******************************/

    // #include "cos_in_config"
#include "cos_in_globalvar"

        // #include "usu_in_location"
    // #include "sql_in_basis"
#include "cos_in_character"

/***************************** CONSTANTES ****************************/

/* Messages. */
const string MESS_WELCOME_ONTO_SERVER = "Bienvenue sur le serveur";

/* Scripts des systèmes auxiliaires. */
const string TEST_COMMAND_SYSTEM = "ts_scm_basis";
const string TEST_CHARACTER_GESTION = "ts_cos_character";
const string TEST_CHARACTER_SQL = "ts_sql_character";

// Delay avant d'emmener le personnage quelque part.
const float DELAY_BEFORE_JUMP = 5.0f;

/************************** IMPLEMENTATIONS **************************/

void main() {
    // Déclarations de variables.
    object oPC;

    // On récupère le personnage qui vient d'arriver.
    oPC = GetEnteringObject();

    // On vérifie que le module est bien initialisé et que le personnage est valide.
    if (!(cosGetGlobalInt(GV_MODULE_INIT_IS_OK) &&
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
    } else {
        // Destination invalide, on envoie le personnage au centre de formation.
        DelayCommand(DELAY_BEFORE_JUMP, cosJumpPCToTrainingCenter(oPC));
    }

    // On exécute les tests, le cas échéant.
    ExecuteScript(TEST_COMMAND_SYSTEM, oPC);
    ExecuteScript(TEST_CHARACTER_GESTION, oPC);
    ExecuteScript(TEST_CHARACTER_SQL, oPC);

    // On affiche un message de bienvenue.
    FloatingTextStringOnCreature(MESS_WELCOME_ONTO_SERVER+" "+GetName(oPC)+" !", oPC);
}
