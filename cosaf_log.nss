/*********************************************************************/
/** Nom :              cosaf_log
/** Date de cr�ation : 16/03/2011
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les fonctions de stockage des informations
/**   g�n�rales du serveur.
/*********************************************************************/

/******************************************** INCLUDES ********************************************/

#include "sqlaf_main"
#include "cosaf_pcmanips"

/******************************************* PROTOTYPES *******************************************/

// DEF IN "cosaf_log"
// Cr�e une nouvelle entr�e dans le log. On peut ensuite y ajouter des informations compl�mentaires
// avec la fonction cosAddLogInfo.
//   > string sName - Type g�n�ral du log.
//   o int - Valeur de l'identifiant du log (� utiliser avec cosAddLogInfo).
int cosCreateLog(string sName);

// DEF IN "cosaf_log"
// Ajoute une information compl�mentaire au log dont l'id est pass� en param�tre.
// avec la fonction cosAddLogInfo.
//   > int iLogId - Identifiant du log auquel on veut rajouter l'information.
//   > string sName - Nom de l'information � rajouter.
//   > string sValue - Valeur de l'information � rajouter.
void cosAddLogInfo(int iLogId, string sName, string sValue);

// TODO : Documenter cette fonction.
void cosLogClientEnter(object oPC);

// TODO : Documenter cette fonction.
void cosLogClientLeave(object oPC);

// TODO : Documenter cette fonction.
void cosLogModuleLoad();

// TODO : Documenter cette fonction.
void cosLogPlayerChat(object oPC, string sMessage);

// TODO : Documenter cette fonction.
void cosLogPlayerChat(object oPC, string sMessage);

// TODO : Documenter cette fonction.
void cosLogCommand(object oPC, string sCommand);

/**************************************** IMPLEMENTATIONS *****************************************/

// TODO : Faire un test pour le log.
int cosCreateLog(string sName) {
    string sSQL = "INSERT INTO "+COS_SQLT_LOG+" ("+COS_SQLF_NAME+","+COS_SQLF_CREATION+") "+
                  "VALUES ("+sqlQuote(sName)+",NOW());";
    sqlExecDirect(sSQL);
    return sqlEAFDSingleInt("SELECT MAX("+COS_SQLF_ID+") FROM "+COS_SQLT_LOG+";");
}

// TODO : Faire un test pour le log.
void cosAddLogInfo(int iLogId, string sName, string sValue) {
    string sSQL = "REPLACE INTO "+COS_SQLT_LOG_DATA+" ("+COS_SQLF_ID_LOG+","+COS_SQLF_NAME+","+COS_SQLF_VALUE+") "+
                  "VALUES ("+IntToString(iLogId)+","+sqlQuote(sName)+","+sqlQuote(sValue)+");";
    sqlExecDirect(sSQL);
}


/* Fonction priv�e */
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

void cosLogModuleLoad() {
    int iLogId = cosCreateLog(COS_LOG_MOD_LOAD);
}

/* Fonction priv�e */
void pv_cosLogSpeech(object oSpeaker, string sTypeEvent, string sText) {
    int iLogId = cosCreateLog(sTypeEvent);
    cosAddLogInfo(iLogId, COS_LOG_PC_ID, IntToString(cosGetPCId(oSpeaker)));
    cosAddLogInfo(iLogId, COS_LOG_TEXT, sText);
}

void cosLogPlayerChat(object oPC, string sMessage) {
    pv_cosLogSpeech(oPC, COS_LOG_CHAT, sMessage);
}

void cosLogCommand(object oPC, string sCommand) {
    pv_cosLogSpeech(oPC, COS_LOG_COMMAND, sCommand);
}

