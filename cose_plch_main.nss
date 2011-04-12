/*********************************************************************/
/** Nom :              cose_plch_main
/** Date de cr�ation : 12/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lanc� � chaque fois qu'un joueur parle.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "cmda_main"
#include "cosa_log"
#include "atha_main"

/************************** IMPLEMENTATIONS **************************/

void main() {
    // On r�cup�re le personnage et ce qu'il dit.
    object oPC = GetPCChatSpeaker();
    string sMessage = GetPCChatMessage();
    string sSpeech = sMessage;

    // On cr�e une structure de commande avec le message du joueur.
    struct cmd_data_str strCmdData = cmdGetFirstCommand(sSpeech);

    // On analyse toutes les commandes du message et on les ex�cute.
    while (cmdIsCommandValid(strCmdData)) {
        sSpeech = cmdExecAndFetch(strCmdData, oPC);
        strCmdData = cmdGetFirstCommand(sSpeech);
    }

    // ==== Syst�me ATH ====
    // Est-ce que le personnage peut parler ?
    if (athIsAllowed(ATH_SPEAK, oPC)) {
        // On envoie le reste comme dialogue normal.
        SetPCChatMessage(sSpeech);
        // On log dans la BDD si n�cessaire.
        if (COS_LOG_PLAYER_CHAT) {
            cosLogPlayerChat(oPC, sMessage);
        }
    } else {
        // Sinon on informe le PJ qu'il ne peut pas parler.
        athSendNotAllowedMessage(ATH_SPEAK, oPC);
        // Et on envoit un texte vide.
        SetPCChatMessage(CMD_EMPTY_SPEECH);
    }
}
