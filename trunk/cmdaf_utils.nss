/*********************************************************************/
/** Nom :              cmdaf_utils
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
#include "cmdaf_constants"

/***************************** PROTOTYPES ****************************/

// DEF IN "cmdaf_utils"
// Fonction qui renvoie la premi‡re commande trouv‚e dans un chaîne.
//   > string sSpeech - Chaîne à scanner.
//   > int iRecursionDepth - TODO:Decrire
//   > int iRecursionScale - TODO:Decrire
//   o struct cmd_data_str_loc - Structure contenant le speech et la position des tokens de la commande à traîter.
struct cmd_data_str cmdGetFirstCommand(string sSpeech, int iRecursionDepth = 0, int iRecursionScale = 0);

// DEF IN "cmdaf_utils"
// Fonction qui d fini une structure pour stocker les informations d'une commande.
//   > string sSpeech - Speech d'origine.
//   > string sCommand - Commande r‚cup‡re.
//   > int iOpeningTokenPosition - Position du token d'ouverture.
//   > int iClosingTokenPosition - Position du token de fermeture.
//   o struct cmd_data_str - Commande à traîter.
struct cmd_data_str cmdSetDataStructure(string sSpeech = CMD_EMPTY_SPEECH, string sCommand = CMD_EMPTY_COMMAND_DATAS, int iOpeningTokenPosition = USU_TOKEN_POSITION_ERROR, int iClosingTokenPosition = USU_TOKEN_POSITION_ERROR);

// DEF IN "cmdaf_utils"
// Fonction qui r‚cup‡re le nom de la commande à ex cuter.
//   > string sCommand - Commande à traîter.
//   o string - Nom de la commande.
string cmdGetCommandName(string sCommand);

// DEF IN "cmdaf_utils"
// Fonction qui r‚cup‡re la valeur d'un param tre d fini dans la commande.
//   > string sCommand - Commande à tra ter.
//   > string sName - Nom du param tre.
//   o string - Valeur du param tre.
string cmdGetParameterValue(string sCommand, string sName);

// DEF IN "cmdaf_utils"
// Fonction qui d termine si un param tre est pr sent dans la commande ou non.
//   > string sCommand - Commande à tra ter.
//   > string sName - Nom du param tre.
//   o int - FALSE si le param tre n'est pas pr sent,
//           TRUE si le param tre est pr sent.
int cmdIsParameterDefined(string sCommand, string sName);

// DEF IN "cmdaf_utils"
// Fonction qui informe d'une erreur dans la commande.
//   > object oPC - Personnage   informer.
//   > string sErrorMessage - Message d'erreur.
void cmdSendErrorMessage(object oPC, string sErrorMessage);

// DEF IN "cmdaf_utils"
// D termine la validit  d'une commande en fonction de sa structure de donnée.
//   > struct cmd_data_str strCommandDatas - Structure de donnée de la commande.
//   o int - TRUE si la commande est valide, FALSE sinon.
int cmdIsCommandValid(struct cmd_data_str strCommandDatas);

// Structure contenant les données relatives   une commande.
struct cmd_data_str {
    string sSpeech;
    string sCommand;
    int iOpeningTokPos;
    int iClosingTokPos;
};

// D finition d'une structure invalide.
struct cmd_data_str EMPTY_COMMAND_DATAS = cmdSetDataStructure();

/************************** IMPLEMENTATIONS **************************/

struct cmd_data_str cmdSetDataStructure(string sSpeech = CMD_EMPTY_SPEECH, string sCommand = CMD_EMPTY_COMMAND_DATAS, int iOpeningTokenPosition = USU_TOKEN_POSITION_ERROR, int iClosingTokenPosition = USU_TOKEN_POSITION_ERROR) {
    struct cmd_data_str srt;
    srt.sSpeech = sSpeech;
    srt.sCommand = sCommand;
    srt.iOpeningTokPos = iOpeningTokenPosition;
    srt.iClosingTokPos = iClosingTokenPosition;
    return srt;
}

struct cmd_data_str cmdGetFirstCommand(string sSpeech, int iRecursionDepth = 0, int iRecursionScale = 0) {
    if (CMD_ENABLED == FALSE || iRecursionDepth++ > CMD_MAX_DEPTH) {
        return EMPTY_COMMAND_DATAS;
    }
    int iOpenTokPos = usuGetFirstTokenPosition(sSpeech, CMD_OPENING_TOKEN);
    int iClosTokPos = usuGetNextTokenPosition(sSpeech, CMD_CLOSING_TOKEN, CMD_OPENING_TOKEN, iOpenTokPos);
    if (iOpenTokPos == USU_TOKEN_POSITION_ERROR || iClosTokPos == USU_TOKEN_POSITION_ERROR) {
        return EMPTY_COMMAND_DATAS;
    }
    int iNextOpenTokPos = usuGetNextTokenPosition(sSpeech, CMD_OPENING_TOKEN, CMD_OPENING_TOKEN, iOpenTokPos);
    if (iNextOpenTokPos != USU_TOKEN_POSITION_ERROR) {
        if (iClosTokPos > iNextOpenTokPos) {
            string sStringAfterToken = usuGetStringAfterToken(sSpeech, CMD_OPENING_TOKEN_LENGTH, iOpenTokPos);
            iRecursionScale += (iOpenTokPos + CMD_OPENING_TOKEN_LENGTH);
            return cmdGetFirstCommand(sStringAfterToken, iRecursionDepth, iRecursionScale);
        }
    }
    string sCommand = usuGetStringBetweenTokens(sSpeech, iOpenTokPos, CMD_OPENING_TOKEN_LENGTH, iClosTokPos);
    sCommand = usuTrimAllSpaces(sCommand);
    return cmdSetDataStructure(sSpeech, sCommand, iRecursionScale+iOpenTokPos, iRecursionScale+iClosTokPos);
}

string cmdGetCommandName(string sCommand) {
    return usuTrimAllSpaces(usuGetStringBeforeToken(sCommand, usuGetFirstTokenPosition(sCommand, CMD_PARAMETER_TOKEN)));
}

string cmdGetParameterValue(string sCommand, string sName) {
    int iOpenParTokPos = FindSubString(sCommand, CMD_PARAMETER_TOKEN+sName);
    if (iOpenParTokPos == USU_TOKEN_POSITION_ERROR) {
        return CMD_EMPTY_PARAMETER;
    }
    int iDefParTokPos = usuGetNextTokenPosition(sCommand, CMD_DEFINITION_TOKEN, CMD_PARAMETER_TOKEN, iOpenParTokPos);
    if (iDefParTokPos == USU_TOKEN_POSITION_ERROR) {
        return CMD_EMPTY_PARAMETER;
    }
    int iEndParTokPos = usuGetNextTokenPosition(sCommand, CMD_PARAMETER_TOKEN, CMD_DEFINITION_TOKEN, iDefParTokPos);
    if (iEndParTokPos == USU_TOKEN_POSITION_ERROR) {
        return usuGetStringAfterToken(sCommand, GetStringLength(CMD_DEFINITION_TOKEN), iDefParTokPos);
    }
    return usuGetStringBetweenTokens(sCommand, iDefParTokPos, GetStringLength(CMD_DEFINITION_TOKEN), iEndParTokPos);
}

int cmdIsParameterDefined(string sCommand, string sName) {
    return (FindSubString(sCommand, CMD_PARAMETER_TOKEN+sName) != USU_TOKEN_POSITION_ERROR);
}

void cmdSendErrorMessage(object oPC, string sErrorMessage) {
    SendMessageToPC(oPC, sErrorMessage);
}

int cmdIsCommandValid(struct cmd_data_str strCommandDatas) {
    if (strCommandDatas.iOpeningTokPos == USU_TOKEN_POSITION_ERROR || strCommandDatas.iClosingTokPos == USU_TOKEN_POSITION_ERROR) {
        return FALSE;
    }
    return TRUE;
}
