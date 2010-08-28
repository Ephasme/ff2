/*********************************************************************/
/** Nom :              cos_plch_main
/** Date de création : 12/07/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lancé au chargement du module.
/*********************************************************************/

/***************************** INCLUDES ******************************/

            // Donnees de config.
            // #include "cos_config"

            // Fonctions de manipulation des chaînes de caractères.
            // #include "usu_stringtokman"
        // Fonctions de manipulation et de traîtement.
        // #include "scm_utils"
    // Fonctions d'exécution des commandes.
    // #include "scm_commands"
// Système de détection et d'analyse de commandes.
#include "scm_main"

/************************** IMPLEMENTATIONS **************************/

void main() {
    object oPC = GetPCChatSpeaker();
    string sMessage = GetPCChatMessage();

    struct scm_command_datas strScmCommandDatas = scmGetFirstCommand(sMessage);

    while (scmIsValidCommand(strScmCommandDatas)) {
        sMessage = scmExecAndFetchCommand(strScmCommandDatas, oPC);
        strScmCommandDatas = scmGetFirstCommand(sMessage);
    }
    SetPCChatMessage(sMessage);
}
