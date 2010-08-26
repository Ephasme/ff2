/*********************************************************************/
/** Nom :              scm_in_util
/** Date de création : 08/08/2010 13:23:08
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Fonctions utilitaires pour le système de commande.
/*********************************************************************/

/***************************** INCLUDES ******************************/

// Donnees de config.
#include "cos_in_config"

// Fonctions de manipulation des chaînes de caractères.
#include "usu_in_strings"

/***************************** CONSTANTES ****************************/

// Token utilisé pour démarrer une séquence de commandes.
const string SCM_OPENING_TOKEN = "<!";
const string SCM_CLOSING_TOKEN = "!>";
const string SCM_PARAMETER_TOKEN = " ";
const string SCM_DEFINITION_TOKEN = ":";

// Messages d'erreur.
const string SCM_ERROR = "";

// Speech vide.
const string SCM_EMPTY_SPEECH = "";
const string SCM_EMPTY_COMMAND_DATAS = "";
const string SCM_EMPTY_PARAMETER = "";
const string SCM_EMPTY_RESULT = "";

// Limite du nombre d'imbrication de commande.
const int MAXIMUM_COMMAND_INTERWEAVING_NUMBER = 5;

/****************************** VARIABLE *****************************/

int SCM_OPENING_TOKEN_LENGTH = GetStringLength(SCM_OPENING_TOKEN);
int SCM_CLOSING_TOKEN_LENGTH = GetStringLength(SCM_CLOSING_TOKEN);

/***************************** PROTOTYPES ****************************/

// DEF IN "scm_in_util"
// Fonction qui renvoie la première commande trouvée dans un chaîne.
//   > string sSpeech - Chaîne à scanner.
//   > int iRecursionDepth - TODO:Decrire
//   > int iRecursionScale - TODO:Decrire
//   o struct scm_command_datas_loc - Structure contenant le speech et la position des tokens de la commande à traîter.
struct scm_command_datas scmGetFirstCommand(string sSpeech, int iRecursionDepth = 0, int iRecursionScale = 0);

// DEF IN "scm_in_util"
// Fonction qui défini une structure pour stocker les informations d'une commande.
//   > string sSpeech - Speech d'origine.
//   > string sCommand - Commande récupérée.
//   > int iOpeningTokenPosition - Position du token d'ouverture.
//   > int iClosingTokenPosition - Position du token de fermeture.
//   o struct scm_command_datas - Commande à traîter.
struct scm_command_datas scmSetStructCommand(string sSpeech = SCM_EMPTY_SPEECH, string sCommand = SCM_EMPTY_COMMAND_DATAS, int iOpeningTokenPosition = TOKEN_POSITION_ERROR, int iClosingTokenPosition = TOKEN_POSITION_ERROR);

// DEF IN "scm_in_util"
// Fonction qui récupère le nom de la commande à exécuter.
//   > string sCommand - Commande à traîter.
//   o string - Nom de la commande.
string scmGetCommandName(string sCommand);

// DEF IN "scm_in_util"
// Fonction qui récupère la valeur d'un paramètre défini dans la commande.
//   > string sCommand - Commande à traîter.
//   > string sName - Nom du paramètre.
//   o string - Valeur du paramètre.
string scmGetParameterValue(string sCommand, string sName);

// DEF IN "scm_in_util"
// Fonction qui détermine si un paramètre est présent dans la commande ou non.
//   > string sCommand - Commande à traîter.
//   > string sName - Nom du paramètre.
//   o int - FALSE si le paramètre n'est pas présent,
//           TRUE si le paramètre est présent.
int scmIsParameterDefined(string sCommand, string sName);

// DEF IN "scm_in_util"
// Fonction qui informe d'une erreur dans la commande.
//   > object oPC - Personnage à informer.
//   > string sErrorMessage - Message d'erreur.
void scmSendCommandErrorMessage(object oPC, string sErrorMessage);

// DEF IN "scm_in_util"
// Détermine la validité d'une commande en fonction de sa structure de donnée.
//   > struct scm_command_datas strCommandDatas - Structure de donnée de la commande.
//   o int - TRUE si la commande est valide, FALSE sinon.
int scmIsValidCommand(struct scm_command_datas strCommandDatas);

// Structure contenant les données relatives à une commande.
struct scm_command_datas {
    string sSpeech;
    string sCommand;
    int iOpeningTokPos;
    int iClosingTokPos;
};

// Définition d'une structure invalide.
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
    if (SMC_ENABLED == FALSE || iRecursionDepth++ > MAXIMUM_COMMAND_INTERWEAVING_NUMBER) {
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
