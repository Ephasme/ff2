#include "cmda_utils"
#include "stda_moving"

string cmd_movMoveToCommand(string sCommand, object oPC);
string cmd_movSaveLocCommand(string sCommand, object oPC);

string cmd_movSaveLocCommand(string sCommand, object oPC) {
    string sVarName = cmdGetParameterValue(sCommand, CMD_PAR_LOCAL_LOCATION_VARIABLE_NAME);
    if (GetIsPC(oPC)) {
        location lLoc = GetLocation(oPC);
        SetLocalLocation(oPC, sVarName, lLoc);
        SendMessageToPC(oPC, CMD_M_YOU_SAVED_THIS_POSITION_IN_THE_VARIABLE+" "+sVarName+".\n"+
                             CMD_M_YOU_CAN_REUSE_IT_TO_RETURN_THERE_AUTOMATICALLY);
    }
    return CMD_EMPTY_RESULT;
}

string cmd_movMoveToCommand(string sCommand, object oPC) {
    if (!GetIsPC(oPC)) {
        return CMD_EMPTY_RESULT;
    }

    int iToLocation = cmdIsParameterDefined(sCommand, CMD_PAR_TO_LOCATION);
    int iToWaypoint = cmdIsParameterDefined(sCommand, CMD_PAR_TO_WAYPOINT);

    if (iToLocation && iToWaypoint) {
        cmdSendErrorMessage(oPC, ERR_IMPOSSIBLE_TO_MOVE_TO_WAYPOINT_AND_TO_RENT);
        return CMD_EMPTY_RESULT;
    }

    if (!(iToLocation || iToWaypoint)) {
        cmdSendErrorMessage(oPC, ERR_MOVING_TYPE_NOT_DEFINED);
        return CMD_EMPTY_RESULT;
    }

    location lDest;
    string sWaypointTag;
    string sLocalLocationVarName;

    if (iToLocation) {
        sLocalLocationVarName = cmdGetParameterValue(sCommand, CMD_PAR_LOCAL_LOCATION_VARIABLE_NAME);
        if (sLocalLocationVarName == CMD_EMPTY_PARAMETER) {
            cmdSendErrorMessage(oPC, ERR_VARIABLE_NAME_PARAMETER_NOT_PASSED_ON);
            return CMD_EMPTY_RESULT;
        }
        lDest = GetLocalLocation(oPC, sLocalLocationVarName);
    } else if (iToWaypoint) {
        sWaypointTag = cmdGetParameterValue(sCommand, CMD_PAR_WAYPOINT_TAG);
        object oWP = GetWaypointByTag(sWaypointTag);
        if (!GetIsObjectValid(oWP)) {
            cmdSendErrorMessage(oPC, ERR_WAYPOINT_DESTINATION_INVALID);
            return CMD_EMPTY_RESULT;
        }
        lDest = GetLocation(oWP);
    }

    int iRun = cmdIsParameterDefined(sCommand, CMD_PAR_RUN);

    int iJump = cmdIsParameterDefined(sCommand, CMD_PAR_JUMP);

    stdGoToLoc(oPC, lDest, iRun, iJump);

    return CMD_EMPTY_RESULT;
}
