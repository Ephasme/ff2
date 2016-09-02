#include "sqla_main"
#include "cosa_pcmanips"
#include "nw_i0_generic"

int cosCreateLog(string sName);
void cosAddLogInfo(int iLogId, string sName, string sValue);

void cosLogClientEnter(object oPC);
void cosLogClientLeave(object oPC);
void cosLogModuleLoad();
void cosLogPlayerDeath(object oPC, object oKiller);

void cosLogPlayerChat(object oPC, string sMessage);
void cosLogTransition(object oPC, string sOriginTag, string sDestTag);

int cosCreateLog(string sName) {
    string sSQL = "INSERT INTO "+COS_SQLT_LOG+" ("+COS_SQLF_NAME+","+COS_SQLF_CREATION+") "+
                  "VALUES ("+sqlQuote(sName)+",NOW());";
    sqlExecDirect(sSQL);
    return sqlEAFDSingleInt("SELECT MAX("+COS_SQLF_ID+") FROM "+COS_SQLT_LOG+";");
}

void cosAddLogInfo(int iLogId, string sName, string sValue) {
    string sSQL = "REPLACE INTO "+COS_SQLT_LOG_DATA+" ("+COS_SQLF_ID_LOG+","+COS_SQLF_NAME+","+COS_SQLF_VALUE+") "+
                  "VALUES ("+IntToString(iLogId)+","+sqlQuote(sName)+","+sqlQuote(sValue)+");";
    sqlExecDirect(sSQL);
}

void pv_cosLogClientEvent(object oPC, string sEvent) {
    int iLogId = cosCreateLog(sEvent);
    cosAddLogInfo(iLogId, COS_LOG_PC_ID, IntToString(cosGetPCId(oPC)));
    cosAddLogInfo(iLogId, COS_LOG_PC_ACCOUNT_ID, IntToString(cosGetAccountId(oPC)));
    cosAddLogInfo(iLogId, COS_LOG_PC_KEY_ID, IntToString(cosGetPublicCDKeyId(oPC)));
}

void cosLogClientEnter(object oPC) {
    pv_cosLogClientEvent(oPC, COS_LOG_CL_ENTER);
}

void cosLogClientLeave(object oPC) {
    pv_cosLogClientEvent(oPC, COS_LOG_CL_LEAVE);
}

void cosLogPlayerDeath(object oPC, object oKiller) {
    int iLogId = cosCreateLog(COS_LOG_PLAYER_DEATH);
    if (GetIsPC(oPC)) {
        cosAddLogInfo(iLogId, COS_LOG_PC_VICTIM_ID, IntToString(cosGetPCId(oPC)));
        if (GetIsPC(oKiller)) {
            cosAddLogInfo(iLogId, COS_LOG_KILL_TYPE, COS_LOG_PVP_KILL);
            cosAddLogInfo(iLogId, COS_LOG_PC_KILLER_ID, IntToString(cosGetPCId(oPC)));
        } else {
            cosAddLogInfo(iLogId, COS_LOG_KILL_TYPE, COS_LOG_PVM_KILL);
            cosAddLogInfo(iLogId, COS_LOG_PC_KILLER_TAG, GetTag(oKiller));
        }
    }
}

void cosLogPlayerRespawn(object oPC) {
    int iLogId = cosCreateLog(COS_LOG_PLAYER_RESPAWN);
    cosAddLogInfo(iLogId, COS_LOG_PC_ID, IntToString(cosGetPCId(oPC)));
}

void cosLogModuleLoad() {
    int iLogId = cosCreateLog(COS_LOG_MOD_LOAD);
}

void pv_cosLogSpeech(object oSpeaker, string sTypeEvent, string sText) {
    int iLogId = cosCreateLog(sTypeEvent);
    cosAddLogInfo(iLogId, COS_LOG_PC_ID, IntToString(cosGetPCId(oSpeaker)));
    cosAddLogInfo(iLogId, COS_LOG_TEXT, sText);
}

void cosLogPlayerChat(object oPC, string sMessage) {
    pv_cosLogSpeech(oPC, COS_LOG_CHAT, sMessage);
}

void cosLogTransition(object oPC, string sOriginTag, string sDestTag) {
    int iLogId = cosCreateLog(COS_LOG_TRANSITION);
    cosAddLogInfo(iLogId, COS_LOG_PC_ID, IntToString(cosGetPCId(oPC)));
    cosAddLogInfo(iLogId, COS_LOG_PC_ORIGIN, sOriginTag);
    cosAddLogInfo(iLogId, COS_LOG_PC_DESTINATION, sDestTag);
    cosAddLogInfo(iLogId, COS_LOG_PC_IS_FIGHTING, IntToString(GetIsFighting(oPC)));
}

