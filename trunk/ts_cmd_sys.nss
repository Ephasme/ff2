/**************************************************************************************************/
/** Nom :              ts_CMD_sys
/** Date de création : 02/08/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/******************************************* ChangeLog ********************************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script spécial pour tester les fonctions de récupération des
/**   commandes.
/**************************************************************************************************/

#include "cmda_main"
#include "usua_testfuncs"
#include "x0_i0_position"

/**************************************** IMPLEMENTATIONS *****************************************/

void ts_cmdGetFirstCommand_TestCommand(string sSpeech, string sExpRes, int iRecursive) {
    string sType;
    if (iRecursive) {
        sType = "(récursive)";
    } else {
        sType = "(non récursive)";
    }
    struct cmd_data_str srtRes = cmdGetFirstCommand(sSpeech);
    addTest(
              "cmdGetFirstCommand",
              "Test de la commande récupérée "+sType+".",
              srtRes.sCommand == sExpRes
           );
    addTestInfo("Chaîne testée", sSpeech);
    addTestInfo("Commande récupérée", srtRes.sCommand);
}

void ts_cmdGetFirstCommand_TestTokenPositions(string sSpeech, int iOExpPos, int iCExpPos, int iRecursive) {
    string sType;
    if (iRecursive) {
        sType = "(récursive)";
    } else {
        sType = "(non récursive)";
    }
    struct cmd_data_str srtRes = cmdGetFirstCommand(sSpeech);
    addTest(
              "cmdGetFirstCommand",
              "Test des positions des tokens "+sType+".",
              (
                  srtRes.iOpeningTokPos == iOExpPos &&
                  srtRes.iClosingTokPos == iCExpPos
              )
           );
    addTestInfo("Chaîne testée", sSpeech);
    addTestInfo("Position du token d'ouverture", IntToString(srtRes.iOpeningTokPos));
    addTestInfo("Position du token de fermeture", IntToString(srtRes.iClosingTokPos));
}

void ts_cmdGetFirstCommand_ImbricatedCommands_BeginWithToken() {
    string sTest = "<!omJ <!F_ç<!àdsf!>IE!>fj!>fds";
    struct cmd_data_str srtRes = cmdGetFirstCommand(sTest);
    addTest(
              "cmdGetFirstCommand",
              "Commande récursive et speech commençant par un token d'ouverture.",
              srtRes.sCommand == "àdsf"
           );
    addTestInfo("Chaîne testée", sTest);
    addTestInfo("Commande récupérée", srtRes.sCommand);
    addTestInfo("Position du token d'ouverture", IntToString(srtRes.iOpeningTokPos));
    addTestInfo("Position du token de fermeture", IntToString(srtRes.iClosingTokPos));
}

void ts_cmdGetFirstCommand_ImbricatedCommands_EndingWithToken() {
    string sTest = "fi<!omJ <!F_ç<!àdsf!>IE!>fj!>";
    struct cmd_data_str srtRes = cmdGetFirstCommand(sTest);
    addTest(
              "cmdGetFirstCommand",
              "Commande récursive et speech terminant par un token de fermeture.",
              srtRes.sCommand == "àdsf"
           );
    addTestInfo("Chaîne testée", sTest);
    addTestInfo("Commande récupérée", srtRes.sCommand);
    addTestInfo("Position du token d'ouverture", IntToString(srtRes.iOpeningTokPos));
    addTestInfo("Position du token de fermeture", IntToString(srtRes.iClosingTokPos));
}

void ts_cmdGetFirstCommand_ImbricatedCommands_TwoSidesTokens() {
    string sTest = "<!omJ <!F_ç<!àdsf!>IE!>fj!>";
    struct cmd_data_str srtRes = cmdGetFirstCommand(sTest);
    addTest(
              "cmdGetFirstCommand",
              "Commande récursive et speech commençant et terminant par des tokens.",
              srtRes.sCommand == "àdsf"
           );
    addTestInfo("Chaîne testée", sTest);
    addTestInfo("Commande récupérée", srtRes.sCommand);
    addTestInfo("Position du token d'ouverture", IntToString(srtRes.iOpeningTokPos));
    addTestInfo("Position du token de fermeture", IntToString(srtRes.iClosingTokPos));
}

void ts_cmdGetFirstCommand_MaximalRecursionRateExceeded(int iDeep) {
    string sTest;
    int i;
    for (i=0;i<iDeep;i++) {
        sTest += "00<!";
    }
    sTest += "0000";
    for (i=0;i<iDeep;i++) {
        sTest += "!>00";
    }
    struct cmd_data_str srtRes = cmdGetFirstCommand(sTest);
    addTest("cmdGetFirstCommand", "Profondeur de récursivité dépassée.", srtRes.sCommand == CMD_ERROR);
    addTestInfo("Chaîne testée", sTest);
    addTestInfo("Chaîne attendue", CMD_ERROR);
    addTestInfo("Commande récupérée", srtRes.sCommand);
    addTestInfo("Position du token d'ouverture", IntToString(srtRes.iOpeningTokPos));
    addTestInfo("Position du token de fermeture", IntToString(srtRes.iClosingTokPos));
}

void ts_cmdGetFirstCommand_NoOpeningToken() {
    string sTest = "000000!>000000!>000000";
    struct cmd_data_str srtRes = cmdGetFirstCommand(sTest);
    addTest("cmdGetFirstCommand", "Aucun jeton d'ouverture trouvé dans la chaîne.", srtRes.sCommand == CMD_ERROR);
    addTestInfo("Chaîne testée", sTest);
    addTestInfo("Chaîne attendue", CMD_ERROR);
    addTestInfo("Commande récupérée", srtRes.sCommand);
    addTestInfo("Position du token d'ouverture", IntToString(srtRes.iOpeningTokPos));
    addTestInfo("Position du token de fermeture", IntToString(srtRes.iClosingTokPos));
}

void ts_cmdGetFirstCommand_NoClosingToken() {
    string sTest = "000000<!000000<!000000";
    struct cmd_data_str srtRes = cmdGetFirstCommand(sTest);
    addTest("cmdGetFirstCommand", "Aucun jeton de fermeture trouvé dans la chaîne.", srtRes.sCommand == CMD_ERROR);
    addTestInfo("Chaîne testée", sTest);
    addTestInfo("Commande attendue", CMD_ERROR);
    addTestInfo("Commande récupérée", srtRes.sCommand);
    addTestInfo("Position du token d'ouverture", IntToString(srtRes.iOpeningTokPos));
    addTestInfo("Position du token de fermeture", IntToString(srtRes.iClosingTokPos));
}

void ts_cmdGetParameterValue_Standard() {
    string sName = "name";
    string sValue = "value";
    string sCommandName = "commandname";
    string sCommand = sCommandName+" "+sName+":"+sValue;
    string sResult = cmdGetParameterValue(sCommand, sName);
    addTest("cmdGetParameterValue", "Fonctionnement standard.", sResult == sValue);
    addTestInfo("Commande testée", sCommand);
    addTestInfo("Nom du paramètre", sName);
    addTestInfo("Valeur du paramètre", sValue);
    addTestInfo("Valeur récupérée", sResult);
}

void ts_cmdGetParameterValue_WrongName() {
    string sName = "name";
    string sCommandName = "commandname";
    string sWrongName = "wrongname";
    string sValue = "value";
    string sCommand = sCommandName+" "+sName+":"+sValue;
    string sResult = cmdGetParameterValue(sCommand, sWrongName);
    addTest("cmdGetParameterValue", "Nom de paramètre incorrect.", sResult == CMD_ERROR);
    addTestInfo("Commande testée", sCommand);
    addTestInfo("Nom du paramètre", sName);
    addTestInfo("Nom testé", sWrongName);
    addTestInfo("Valeur du paramètre", sValue);
    addTestInfo("Valeur récupérée", sResult);
}

void ts_cmdGetCommandName() {
    string sCommandName = "commandname";
    string sCommand = sCommandName+" name:home";
    string sResult = cmdGetCommandName(sCommand);
    addTest("cmdGetCommandName", "Récupération du nom de la commande.", sResult == sCommandName);
    addTestInfo("Commande testée", sCommand);
    addTestInfo("Nom de la commande", sCommandName);
    addTestInfo("Nom trouvé", sResult);
}

void ts_cmdIsParameterDefined_ParameterDefined() {
    string sParameter = "test";
    string sCommand = "moveto loc "+sParameter+" go and:go toutou:";
    addTest("cmdIsParameterDefined", "Paramètre présent et valide.", cmdIsParameterDefined(sCommand, sParameter) == TRUE);
    addTestInfo("Commande testée", sCommand);
    addTestInfo("Paramètre recherché", sParameter);
}

void ts_cmdIsParameterDefined_ParameterNotDefined() {
    string sParameter = "test";
    string sCommand = "moveto loc go and:go toutou:";
    addTest("cmdIsParameterDefined", "Paramètre non présent.", cmdIsParameterDefined(sCommand, sParameter) == FALSE);
    addTestInfo("Commande testée", sCommand);
    addTestInfo("Paramètre recherché", sParameter);
}

void ts_cmdExecute(object oPC) {
    location lSaved = GetLocation(oPC);
    string sComName = "savepos";
    string sValueVar = "home";
    string sVarPara = "var";
    string sTypePara = "loc";
    string sCommand = sComName+" "+sTypePara+" "+sVarPara+":"+sValueVar;
    cmdExecute(sCommand, oPC);
    location lResult = GetLocalLocation(oPC, sValueVar);
    addTest("cmdExecute", "Sauvegarde d'une position de personnage.", lResult == lSaved);
    addTestInfo("Commande testée", sCommand);
    addTestInfo("Nom de la variable", sValueVar);
    addTestInfo("Position sauvée au préalable", LocationToString(lSaved));
    addTestInfo("Position récupérée", LocationToString(lResult));
}

void ts_cmdFetch() {
    string sSpeech = "La position de chez moi c'est <!saveloc name:chezmoi!> !!";
    struct cmd_data_str strCmdData = cmdSetDataStructure(sSpeech, "saveloc name:chezmoi", 30, 52);
    string sResult = cmdFetch(strCmdData, "[COMMAND_RESULT]");
    addTest("cmdFetch", "Insertion du résultat d'une commande dans un speech.", sResult == "La position de chez moi c'est [COMMAND_RESULT] !!");
    addTestInfo("Speech testé", sSpeech);
    addTestInfo("Speech modifié", sResult);
}

/* Private Function */
void pv_do_OnModuleLoad_Tests() {
    ts_cmdGetFirstCommand_TestCommand("fds<!ji__yf!>fjdiy", "ji__yf", FALSE);
    ts_cmdGetFirstCommand_TestCommand("ezr-__<!WHFuu!>", "WHFuu", FALSE);
    ts_cmdGetFirstCommand_TestCommand("<!dfezzz!>fjdiy", "dfezzz", FALSE);
    ts_cmdGetFirstCommand_TestCommand("<!df_yèèzz!>", "df_yèèzz", FALSE);
    ts_cmdGetFirstCommand_TestTokenPositions("<!fjdklji!>", 0, 9, FALSE);
    ts_cmdGetFirstCommand_TestTokenPositions("fezf<!fjdklji!>", 4, 13, FALSE);
    ts_cmdGetFirstCommand_TestTokenPositions("<!fjdklji!>fezfff", 0, 9, FALSE);
    ts_cmdGetFirstCommand_TestTokenPositions("012345<!8901234!>fezfff", 6, 15, FALSE);
    ts_cmdGetFirstCommand_TestCommand("fds<!ji<!__y!>f!>fjdiy", "__y", TRUE);
    ts_cmdGetFirstCommand_TestCommand("ezr-__<!WH<!fdsii!>Fuu!>", "fdsii", TRUE);
    ts_cmdGetFirstCommand_TestCommand("<!df<!jfiehh!>ezzz!>fjdiy", "jfiehh", TRUE);
    ts_cmdGetFirstCommand_TestCommand("<!df<!_yèuieii!>èzz!>", "_yèuieii", TRUE);
    ts_cmdGetFirstCommand_TestTokenPositions("<!fdkijfiejj<!fjdklji!>fezfff!>", 12, 21, TRUE);
    ts_cmdGetFirstCommand_TestTokenPositions("jkf_d<!fjdk<!fduezhf!>hjfdjkfd!>", 11, 20, TRUE);
    ts_cmdGetFirstCommand_TestTokenPositions("<!fjdk<!fjdkslii!>lji!>dkslfjkds", 6, 16, TRUE);
    ts_cmdGetFirstCommand_TestTokenPositions("fjdkslj<!fjkdiie<!8901234!>fez!>fff", 16, 25, TRUE);

    ts_cmdGetFirstCommand_MaximalRecursionRateExceeded(15);

    ts_cmdGetFirstCommand_NoOpeningToken();
    ts_cmdGetFirstCommand_NoClosingToken();

    ts_cmdGetParameterValue_Standard();
    ts_cmdGetParameterValue_WrongName();

    ts_cmdGetCommandName();

    ts_cmdIsParameterDefined_ParameterDefined();
    ts_cmdIsParameterDefined_ParameterNotDefined();

    ts_cmdFetch();

    printResult(TS_CMD_TITLE);
}

/* Private Function */
void pv_do_OnClientEnter_Tests(object oPC, int iDepth = 0) {
    if (iDepth < TS_LOOP_MAX) {
        if (GetIsObjectValid(GetArea(oPC))) {

            ts_cmdExecute(oPC);

            printResult(TS_CMD_TITLE);
        } else {
            DelayCommand(TS_LOOP_DELAY, pv_do_OnClientEnter_Tests(oPC, iDepth++));
        }
    }
}

void main() {
    if (TS_TEST_MODE && TS_CMD_SYS) {
        object oMe = OBJECT_SELF;
        if (oMe == GetModule()) {
            pv_do_OnModuleLoad_Tests();

        } else if (GetIsPC(oMe)) {
            pv_do_OnClientEnter_Tests(oMe);
        }
    }
}
