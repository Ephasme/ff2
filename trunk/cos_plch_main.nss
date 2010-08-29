/*********************************************************************/
/** Nom :              cos_plch_main
/** Date de cr ation : 12/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lanc‚ au chargement du module.
/*********************************************************************/

/***************************** INCLUDES ******************************/

                    // #include "usu_constants"
                // #include "usu_stringtokman"
                // #include "scm_constants"
            // #include "scm_utils"

                // #include "usu_constants"
            // #include "usu_movings"
        // #include "scm_cmmoving"
    // #include "scm_commands"
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
