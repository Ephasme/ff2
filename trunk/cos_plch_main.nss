/*********************************************************************/
/** Nom :              cos_plch_main
/** Date de cr�ation : 12/07/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lanc� au chargement du module.
/*********************************************************************/

/***************************** INCLUDES ******************************/

            // Donnees de config.
            // #include "cos_config"

            // Fonctions de manipulation des cha�nes de caract�res.
            // #include "usu_stringtokman"
        // Fonctions de manipulation et de tra�tement.
        // #include "scm_utils"
    // Fonctions d'ex�cution des commandes.
    // #include "scm_commands"
// Syst�me de d�tection et d'analyse de commandes.
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
