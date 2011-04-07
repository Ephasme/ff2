/*********************************************************************/
/** Nom :              stda_exceptions
/** Date de création : 07/04/2011
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script regroupant les fonctions de gestion des erreurs.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "stda_constants"

/***************************** PROTOTYPES ****************************/

// TODO : Faire les prototypes
void stdRaiseException(string sMess, string sName, string sAcro);

/************************** IMPLEMENTATIONS **************************/

/* Private function */
void pv_printAll(string sMess) {
    SendMessageToAllDMs(sMess);
    PrintString(sMess);
}

void stdRaiseException(string sMess, string sName, string sAcro) {
    string sResult = STD_EMPTY_STRING;
    sResult = "Exception raised in "+sName+" ["+sAcro+"] : "+sMess;
    pv_printAll(sResult);
}
