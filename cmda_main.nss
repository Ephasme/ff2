#include "cmda_c_afk"
#include "cmda_c_mov"

string cmdExecute(string sCommand, object oPC);
string cmdFetch(struct cmd_data_str strCmdData, string sResult);
string cmdExecAndFetch(struct cmd_data_str strCmdData, object oPC);

string cmdExecute(string sCommand, object oPC) {
    string sCommandName;

    if (CMD_ENABLED == FALSE) {
        return CMD_EMPTY_RESULT;
    }
    sCommandName = cmdGetCommandName(sCommand);

    if (sCommandName == CMD_C_TOGGLE_AFK) {
        return cmd_afkToggleAFKState(sCommand, oPC);
    } else if (sCommandName == CMD_C_MOVE_TO) {
        return cmd_movMoveToCommand(sCommandName, oPC);
    } else if (sCommandName == CMD_C_SAVE_LOC) {
        return cmd_movSaveLocCommand(sCommandName, oPC);
    }

    return CMD_EMPTY_RESULT;
}

string cmdFetch(struct cmd_data_str strCmdData, string sResult) {
    if (cmdIsCommandValid(strCmdData)) {
        string sLeftPart = stdGetStringBeforeToken(strCmdData.sSpeech, strCmdData.iOpeningTokPos);
        string sRightPart = stdGetStringAfterToken(strCmdData.sSpeech, CMD_CLOSING_TOKEN_LENGTH, strCmdData.iClosingTokPos);
        return sLeftPart+sResult+sRightPart;
    } else {
        return strCmdData.sSpeech;
    }
}

string cmdExecAndFetch(struct cmd_data_str strCmdData, object oPC) {
    if (cmdIsCommandValid(strCmdData)) {
        return cmdFetch(strCmdData, cmdExecute(strCmdData.sCommand, oPC));
    }
    return CMD_EMPTY_RESULT;
}
