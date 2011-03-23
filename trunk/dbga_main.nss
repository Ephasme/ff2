/**************************************************************************************************/
/** Nom :              dbga_main
/** Date de création : 23/03/2011
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/******************************************** ChangeLog *******************************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les fonctions de débug.
/**************************************************************************************************/

// TODO : à déplacer dans un fichier dbga_constants.
/** CONSTANTES **/
const string DBG_INDENT_CHAR = "  ";
const int DBG_RESET_INDENT_LEVEL_ON_SOURCE_CHANGING = FALSE;

/******************************************** INCLUDES ********************************************/

/*************************************** VARIABLES LOCALES ****************************************/
string dbg_sPrefix = "";
string dbg_sSource = "";

/******************************************* PROTOTYPES *******************************************/

void dbgSetIndentLevel(int iIdentLevel);
void dbgResetIndentLevel();
int dbgGetIndentLevel();
void dbgIncreaseIdentLevel();
void dbgDecreaseIdentLevel();
void dbgChangeSource(string sNewSource);
void dbgWrite(string sMessage);

/**************************************** IMPLEMENTATIONS *****************************************/

void dbgSetIndentLevel(int iIdentLevel) {
    int i = 0;
    for (i; i<iIdentLevel; i++) {
        dbg_sPrefix + DBG_INDENT_CHAR;
    }
}
void dbgResetIndentLevel() {
    dbgSetIndentLevel(0);
}
int dbgGetIndentLevel() {
    return GetStringLength(dbg_sPrefix)/GetStringLength(DBG_INDENT_CHAR);
}
void dbgIncreaseIdentLevel() {
    dbgSetIndentLevel(dbgGetIndentLevel()+1);
}
void dbgDecreaseIdentLevel() {
    dbgSetIndentLevel(dbgGetIndentLevel()-1);
}

void dbgChangeSource(string sSource) {
    if (DBG_RESET_INDENT_LEVEL_ON_SOURCE_CHANGING) {
        dbgResetIndentLevel();
    }
    string sArrow = "=>";
    if (dbg_sSource != "") {
        dbgWrite(dbg_sSource + " " + sArrow + " " + sSource);
    } else {
        dbgWrite(sArrow + " " + sSource);
    }
    dbg_sSource = sSource;
}

void dbgWrite(string sMessage) {
    PrintString(dbg_sPrefix + sMessage);
}
