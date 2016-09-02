#include "stda_strtokman"
#include "cmda_constants"

struct cmd_data_str cmdGetFirstCommand(string sSpeech, string sOriginalSpeech = "", int iRecursionDepth = 0, int iRecursionScale = 0);
struct cmd_data_str cmdSetDataStructure(string sSpeech = CMD_EMPTY_SPEECH, string sCommand = CMD_EMPTY_COMMAND_DATAS, int iOpeningTokenPosition = STD_TOKEN_POSITION_ERROR, int iClosingTokenPosition = STD_TOKEN_POSITION_ERROR);
string cmdGetCommandName(string sCommand);
string cmdGetParameterValue(string sCommand, string sName);
int cmdIsParameterDefined(string sCommand, string sName);
void cmdSendErrorMessage(object oPC, string sErrorMessage);
int cmdIsCommandValid(struct cmd_data_str strCommandDatas);

struct cmd_data_str {
    string sSpeech;
    string sCommand;
    int iOpeningTokPos;
    int iClosingTokPos;
};

struct cmd_data_str EMPTY_COMMAND_DATAS = cmdSetDataStructure();

struct cmd_data_str cmdSetDataStructure(string sSpeech = CMD_EMPTY_SPEECH, string sCommand = CMD_EMPTY_COMMAND_DATAS, int iOpeningTokenPosition = STD_TOKEN_POSITION_ERROR, int iClosingTokenPosition = STD_TOKEN_POSITION_ERROR) {
    struct cmd_data_str srt;
    srt.sSpeech = sSpeech;
    srt.sCommand = sCommand;
    srt.iOpeningTokPos = iOpeningTokenPosition;
    srt.iClosingTokPos = iClosingTokenPosition;
    return srt;
}

struct cmd_data_str cmdGetFirstCommand(string sSpeech, string sOriginalSpeech = "", int iRecursionDepth = 0, int iRecursionScale = 0) {
    if (iRecursionDepth == 0) {
        sOriginalSpeech = sSpeech;
    }
    if (CMD_ENABLED == FALSE || iRecursionDepth++ > CMD_MAX_DEPTH) {
        return EMPTY_COMMAND_DATAS;
    }
    int iOpenTokPos = stdGetFirstTokenPosition(sSpeech, CMD_OPENING_TOKEN);
    int iClosTokPos = stdGetNextTokenPosition(sSpeech, CMD_CLOSING_TOKEN, CMD_OPENING_TOKEN, iOpenTokPos);
    if (iOpenTokPos == STD_TOKEN_POSITION_ERROR || iClosTokPos == STD_TOKEN_POSITION_ERROR) {
        return EMPTY_COMMAND_DATAS;
    }
    int iNextOpenTokPos = stdGetNextTokenPosition(sSpeech, CMD_OPENING_TOKEN, CMD_OPENING_TOKEN, iOpenTokPos);
    if (iNextOpenTokPos != STD_TOKEN_POSITION_ERROR) {
        if (iClosTokPos > iNextOpenTokPos) {
            string sStringAfterToken = stdGetStringAfterToken(sSpeech, CMD_OPENING_TOKEN_LENGTH, iOpenTokPos);
            iRecursionScale += (iOpenTokPos + CMD_OPENING_TOKEN_LENGTH);
            return cmdGetFirstCommand(sStringAfterToken, sOriginalSpeech, iRecursionDepth, iRecursionScale);
        }
    }
    string sCommand = stdGetStringBetweenTokens(sSpeech, iOpenTokPos, CMD_OPENING_TOKEN_LENGTH, iClosTokPos);
    sCommand = stdTrimAllSpaces(sCommand);
    return cmdSetDataStructure(sOriginalSpeech, sCommand, iRecursionScale+iOpenTokPos, iRecursionScale+iClosTokPos);
}

string cmdGetCommandName(string sCommand) {
    return stdTrimAllSpaces(stdGetStringBeforeToken(sCommand, stdGetFirstTokenPosition(sCommand, CMD_PARAMETER_TOKEN)));
}

string cmdGetParameterValue(string sCommand, string sName) {
    int iOpenParTokPos = FindSubString(sCommand, CMD_PARAMETER_TOKEN+sName);
    if (iOpenParTokPos == STD_TOKEN_POSITION_ERROR) {
        return CMD_EMPTY_PARAMETER;
    }
    int iDefParTokPos = stdGetNextTokenPosition(sCommand, CMD_DEFINITION_TOKEN, CMD_PARAMETER_TOKEN, iOpenParTokPos);
    if (iDefParTokPos == STD_TOKEN_POSITION_ERROR) {
        return CMD_EMPTY_PARAMETER;
    }
    int iEndParTokPos = stdGetNextTokenPosition(sCommand, CMD_PARAMETER_TOKEN, CMD_DEFINITION_TOKEN, iDefParTokPos);
    if (iEndParTokPos == STD_TOKEN_POSITION_ERROR) {
        return stdGetStringAfterToken(sCommand, GetStringLength(CMD_DEFINITION_TOKEN), iDefParTokPos);
    }
    return stdGetStringBetweenTokens(sCommand, iDefParTokPos, GetStringLength(CMD_DEFINITION_TOKEN), iEndParTokPos);
}

int cmdIsParameterDefined(string sCommand, string sName) {
    return (FindSubString(sCommand, CMD_PARAMETER_TOKEN+sName) != STD_TOKEN_POSITION_ERROR);
}

void cmdSendErrorMessage(object oPC, string sErrorMessage) {
    SendMessageToPC(oPC, sErrorMessage);
}

int cmdIsCommandValid(struct cmd_data_str strCommandDatas) {
    if (strCommandDatas.iOpeningTokPos == STD_TOKEN_POSITION_ERROR || strCommandDatas.iClosingTokPos == STD_TOKEN_POSITION_ERROR) {
        return FALSE;
    }
    return TRUE;
}
