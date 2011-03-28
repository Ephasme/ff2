/*********************************************************************/
/** Nom :              cmda_c_ath
/** Date de création : 28/03/2011
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant la liste des commandes relatives au
/**    système d'autorisation ATH.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "cmda_utils"
#include "cosa_log"
#include "atha_main"

/***************************** PROTOTYPES ****************************/

// TODO : A documenter.
string cmd_athFlushAuth(string sCommandName, object oPC);

/************************** IMPLEMENTATIONS **************************/

string cmd_athFlushAuth(string sCommandName, object oPC) {
    athFlush();
    int iId = cosCreateLog(COS_LOG_ATH_FLUSH);
    cosAddLogInfo(iId, COS_LOG_PC_ID, IntToString(cosGetPCId(oPC)));
    SendMessageToPC(oPC,CMD_M_YOU_FLUSHED_AUTHORIZATIONS);
    return CMD_EMPTY_RESULT;
}
