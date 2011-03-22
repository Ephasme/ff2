/*********************************************************************/
/** Nom :              cose_plch_main
/** Date de création : 12/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lanc‚ au chargement du module.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "cmda_main"
#include "cosa_log"

/************************** IMPLEMENTATIONS **************************/

void main() {
    // On récupère le personnage et ce qu'il dit.
    object oPC = GetPCChatSpeaker();
    string sMessage = GetPCChatMessage();

    // On log dans la BDD si nécessaire.
    if (COS_LOG_PLAYER_CHAT) {
        cosLogPlayerChat(oPC, sMessage);
    }

    // On crée une structure de commande avec le message du joueur.
    struct cmd_data_str strCmdData = cmdGetFirstCommand(sMessage);

    // On analyse toutes les commandes du message et on les exécute.
    while (cmdIsCommandValid(strCmdData)) {
        sMessage = cmdExecAndFetch(strCmdData, oPC);
        strCmdData = cmdGetFirstCommand(sMessage);
    }

    // On envoie le reste comme dialogue normal.
    SetPCChatMessage(sMessage);
}
