/*********************************************************************/
/** Nom :              cosaf_log
/** Date de création : 16/03/2011
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les fonctions de stockage des informations
/**   générales du serveur.
/*********************************************************************/

/******************************************** INCLUDES ********************************************/

#include "sqlaf_main"
#include "cosaf_constants"

/******************************************* PROTOTYPES *******************************************/

// DEF IN "cosaf_log"
// Crée une nouvelle entrée dans le log. On peut ensuite y ajouter des informations complémentaires
// avec la fonction cosAddLogInfo.
//   > string sName - Type général du log.
//   o int - Valeur de l'identifiant du log (à utiliser avec cosAddLogInfo).
int cosCreateLog(string sName);

// DEF IN "cosaf_log"
// Ajoute une information complémentaire au log dont l'id est passé en paramètre.
// avec la fonction cosAddLogInfo.
//   > int iLogId - Identifiant du log auquel on veut rajouter l'information.
//   > string sName - Nom de l'information à rajouter.
//   > string sValue - Valeur de l'information à rajouter.
void cosAddLogInfo(int iLogId, string sName, string sValue);

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
