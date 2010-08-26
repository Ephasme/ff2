/*********************************************************************/
/** Nom :              cos_ev_onplchat
/** Date de création : 12/07/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lancé au chargement du module.
/*********************************************************************/

/***************************** INCLUDES ******************************/

            // Donnees de config.
            // #include "cos_in_config"

            // Fonctions de manipulation des chaînes de caractères.
            // #include "usu_in_strings"
        // Fonctions de manipulation et de traîtement.
        // #include "scm_in_util"
    // Fonctions d'exécution des commandes.
    // #include "scm_in_commands"
// Système de détection et d'analyse de commandes.
#include "scm_in_basis"

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
