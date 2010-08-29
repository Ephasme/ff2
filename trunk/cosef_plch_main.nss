/*********************************************************************/
/** Nom :              cosef_plch_main
/** Date de cr ation : 12/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lanc‚ au chargement du module.
/*********************************************************************/

/***************************** INCLUDES ******************************/

                    // #include "usuaf_constants"
                // #include "usuaf_strtokman"
                // #include "scmaf_constants"
            // #include "scmaf_utils"

                // #include "usuaf_constants"
            // #include "usuaf_movings"
        // #include "scmaf_cmmoving"
    // #include "scmaf_commands"
#include "scmaf_main"

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
