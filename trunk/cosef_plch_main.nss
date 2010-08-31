/*********************************************************************/
/** Nom :              cosef_plch_main
/** Date de création : 12/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lanc‚ au chargement du module.
/*********************************************************************/

/***************************** INCLUDES ******************************/

                    // #include "usuaf_constants"
                // #include "usuaf_strtokman"
                // #include "cmdaf_constants"
            // #include "cmdaf_utils"

                // #include "usuaf_constants"
            // #include "usuaf_movings"
        // #include "cmdaf_cmmoving"
    // #include "cmdaf_commands"
#include "cmdaf_main"

/************************** IMPLEMENTATIONS **************************/

void main() {
    object oPC = GetPCChatSpeaker();
    string sMessage = GetPCChatMessage();

    struct cmd_data_str strCmdData = cmdGetFirstCommand(sMessage);

    while (cmdIsCommandValid(strCmdData)) {
        sMessage = cmdExecAndFetch(strCmdData, oPC);
        strCmdData = cmdGetFirstCommand(sMessage);
    }
    SetPCChatMessage(sMessage);
}
