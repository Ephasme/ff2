/*********************************************************************/
/** Nom :              scmaf_utils
/** Date de création : 08/08/2010 13:23:08
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Fonctions utilitaires pour le syst‡me de commande.
/*********************************************************************/

/***************************** INCLUDES ******************************/

    // #include "usuaf_constants"
#include "usuaf_strtokman"
#include "scmaf_constants"

/***************************** PROTOTYPES ****************************/

// DEF IN "scmaf_utils"
// Fonction qui renvoie la premi‡re commande trouv‚e dans un chaîne.
//   > string sSpeech - Chaîne à scanner.
//   > int iRecursionDepth - TODO:Decrire
//   > int iRecursionScale - TODO:Decrire
//   o struct scm_command_datas_loc - Structure contenant le speech et la position des tokens de la commande à traîter.
struct scm_command_datas scmGetFirstCommand(string sSpeech, int iRecursionDepth = 0, int iRecursionScale = 0);

// DEF IN "scmaf_utils"
// Fonction qui d fini une structure pour stocker les informations d'une commande.
//   > string sSpeech - Speech d'origine.
//   > string sCommand - Commande r‚cup‡re.
//   > int iOpeningTokenPosition - Position du token d'ouverture.
//   > int iClosingTokenPosition - Position du token de fermeture.
//   o struct scm_command_datas - Commande à traîter.
struct scm_command_datas scmSetStructCommand(string sSpeech = SCM_EMPTY_SPEECH, string sCommand = SCM_EMPTY_COMMAND_DATAS, int iOpeningTokenPosition = TOKEN_POSITION_ERROR, int iClosingTokenPosition = TOKEN_POSITION_ERROR);

// DEF IN "scmaf_utils"
// Fonction qui r‚cup‡re le nom de la commande à ex cuter.
//   > string sCommand - Commande à traîter.
//   o string - Nom de la commande.
string scmGetCommandName(string sCommand);

// DEF IN "scmaf_utils"
// Fonction qui r‚cup‡re la valeur d'un param tre d fini dans la commande.
//   > string sCommand - Commande à tra ter.
//   > string sName - Nom du param tre.
//   o string - Valeur du param tre.
string scmGetParameterValue(string sCommand, string sName);

// DEF IN "scmaf_utils"
// Fonction qui d termine si un param tre est pr sent dans la commande ou non.
//   > string sCommand - Commande à tra ter.
//   > string sName - Nom du param tre.
//   o int - FALSE si le param tre n'est pas pr sent,
//           TRUE si le param tre est pr sent.
int scmIsParameterDefined(string sCommand, string sName);

// DEF IN "scmaf_utils"
// Fonction qui informe d'une erreur dans la commande.
//   > object oPC - Personnage   informer.
//   > string sErrorMessage - Message d'erreur.
void scmSendCommandErrorMessage(object oPC, string sErrorMessage);

// DEF IN "scmaf_utils"
// D termine la validit  d'une commande en fonction de sa structure de donnée.
//   > struct scm_command_datas strCommandDatas - Structure de donnée de la commande.
//   o int - TRUE si la commande est valide, FALSE sinon.
int scmIsValidCommand(struct scm_command_datas strCommandDatas);

// Structure contenant les données relatives   une commande.
struct scm_command_datas {
    string sSpeech;
    string sCommand;
    int iOpeningTokPos;
    int iClosingTokPos;
};

// D finition d'une structure invalide.
struct scm_command_datas EMPTY_COMMAND_DATAS = scmSetStructCommand();

/************************** IMPLEMENTATIONS **************************/

struct scm_command_datas scmSetStructCommand(string sSpeech = SCM_EMPTY_SPEECH, string sCommand = SCM_EMPTY_COMMAND_DATAS, int iOpeningTokenPosition = TOKEN_POSITION_ERROR, int iClosingTokenPosition = TOKEN_POSITION_ERROR) {
    struct scm_command_datas srt;
    srt.sSpeech = sSpeech;
    srt.sCommand = sCommand;
    srt.iOpeningTokPos = iOpeningTokenPosition;
    srt.iClosingTokPos = iClosingTokenPosition;
    return srt;
}

struct scm_command_datas scmGetFirstCommand(string sSpeech, int iRecursionDepth = 0, int iRecursionScale = 0) {
    if (SCM_ENABLED == FALSE || iRecursionDepth++ > MAXIMUM_COMMAND_INTERWEAVING_NUMBER) {
        return EMPTY_COMMAND_DATAS;
    }
    int iOpenTokPos = usuGetFirstTokenPosition(sSpeech, SCM_OPENING_TOKEN);
    int iClosTokPos = usuGetNextTokenPosition(sSpeech, SCM_CLOSING_TOKEN, SCM_OPENING_TOKEN, iOpenTokPos);
    if (iOpenTokPos == TOKEN_POSITION_ERROR || iClosTokPos == TOKEN_POSITION_ERROR) {
        return EMPTY_COMMAND_DATAS;
    }
    int iNextOpenTokPos = usuGetNextTokenPosition(sSpeech, SCM_OPENING_TOKEN, SCM_OPENING_TOKEN, iOpenTokPos);
    if (iNextOpenTokPos != TOKEN_POSITION_ERROR) {
        if (iClosTokPos > iNextOpenTokPos) {
            string sStringAfterToken = usuGetStringAfterToken(sSpeech, SCM_OPENING_TOKEN_LENGTH, iOpenTokPos);
            iRecursionScale += (iOpenTokPos + SCM_OPENING_TOKEN_LENGTH);
            return scmGetFirstCommand(sStringAfterToken, iRecursionDepth, iRecursionScale);
        }
    }
    string sCommand = usuGetStringBetweenTokens(sSpeech, iOpenTokPos, SCM_OPENING_TOKEN_LENGTH, iClosTokPos);
    sCommand = usuTrimAllSpaces(sCommand);
    return scmSetStructCommand(sSpeech, sCommand, iRecursionScale+iOpenTokPos, iRecursionScale+iClosTokPos);
}

string scmGetCommandName(string sCommand) {
    return usuTrimAllSpaces(usuGetStringBeforeToken(sCommand, usuGetFirstTokenPosition(sCommand, SCM_PARAMETER_TOKEN)));
}

string scmGetParameterValue(string sCommand, string sName) {
    int iOpenParTokPos = FindSubString(sCommand, SCM_PARAMETER_TOKEN+sName);
    if (iOpenParTokPos == TOKEN_POSITION_ERROR) {
        return SCM_EMPTY_PARAMETER;
    }
    int iDefParTokPos = usuGetNextTokenPosition(sCommand, SCM_DEFINITION_TOKEN, SCM_PARAMETER_TOKEN, iOpenParTokPos);
    if (iDefParTokPos == TOKEN_POSITION_ERROR) {
        return SCM_EMPTY_PARAMETER;
    }
    int iEndParTokPos = usuGetNextTokenPosition(sCommand, SCM_PARAMETER_TOKEN, SCM_DEFINITION_TOKEN, iDefParTokPos);
    if (iEndParTokPos == TOKEN_POSITION_ERROR) {
        return usuGetStringAfterToken(sCommand, GetStringLength(SCM_DEFINITION_TOKEN), iDefParTokPos);
    }
    return usuGetStringBetweenTokens(sCommand, iDefParTokPos, GetStringLength(SCM_DEFINITION_TOKEN), iEndParTokPos);
}

int scmIsParameterDefined(string sCommand, string sName) {
    return (FindSubString(sCommand, SCM_PARAMETER_TOKEN+sName) != TOKEN_POSITION_ERROR);
}

void scmSendCommandErrorMessage(object oPC, string sErrorMessage) {
    SendMessageToPC(oPC, sErrorMessage);
}

int scmIsValidCommand(struct scm_command_datas strCommandDatas) {
    if (strCommandDatas.iOpeningTokPos == TOKEN_POSITION_ERROR || strCommandDatas.iClosingTokPos == TOKEN_POSITION_ERROR) {
        return FALSE;
    }
    return TRUE;
}
