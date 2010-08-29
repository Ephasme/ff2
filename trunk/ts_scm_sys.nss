/**************************************************************************************************/
/** Nom :              ts_scm_sys
/** Date de création : 02/08/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/******************************************* ChangeLog ********************************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script spécial pour tester les fonctions de récupération des
/**   commandes.
/**************************************************************************************************/

                    // #include "usu_constants"
                // #include "usu_stringtokman"
                // #include "scm_constants"
            // #include "scm_utils"

                // #include "usu_constants"
            // #include "usu_movings"
        // #include "scm_cmmoving"
    // #include "scm_commands"
#include "scm_main"
    // #include "usu_constants"
#include "usu_testfuncs"
#include "x0_i0_position"

/**************************************** IMPLEMENTATIONS *****************************************/

void ts_scmGetFirstCommand_TestCommand(string sSpeech, string sExpRes, int iRecursive) {
    string sType;
    if (iRecursive) {
        sType = "(récursive)";
    } else {
        sType = "(non récursive)";
    }
    struct scm_command_datas srtRes = scmGetFirstCommand(sSpeech);
    addTest(
              "scmGetFirstCommand",
              "Test de la commande récupérée "+sType+".",
              srtRes.sCommand == sExpRes
           );
    addTestInfo("Chaîne testée", sSpeech);
    addTestInfo("Commande récupérée", srtRes.sCommand);
}

void ts_scmGetFirstCommand_TestTokenPositions(string sSpeech, int iOExpPos, int iCExpPos, int iRecursive) {
    string sType;
    if (iRecursive) {
        sType = "(récursive)";
    } else {
        sType = "(non récursive)";
    }
    struct scm_command_datas srtRes = scmGetFirstCommand(sSpeech);
    addTest(
              "scmGetFirstCommand",
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

void ts_scmGetFirstCommand_ImbricatedCommands_BeginWithToken() {
    string sTest = "<!omJ <!F_ç<!àdsf!>IE!>fj!>fds";
    struct scm_command_datas srtRes = scmGetFirstCommand(sTest);
    addTest(
              "scmGetFirstCommand",
              "Commande récursive et speech commençant par un token d'ouverture.",
              srtRes.sCommand == "àdsf"
           );
    addTestInfo("Chaîne testée", sTest);
    addTestInfo("Commande récupérée", srtRes.sCommand);
    addTestInfo("Position du token d'ouverture", IntToString(srtRes.iOpeningTokPos));
    addTestInfo("Position du token de fermeture", IntToString(srtRes.iClosingTokPos));
}

void ts_scmGetFirstCommand_ImbricatedCommands_EndingWithToken() {
    string sTest = "fi<!omJ <!F_ç<!àdsf!>IE!>fj!>";
    struct scm_command_datas srtRes = scmGetFirstCommand(sTest);
    addTest(
              "scmGetFirstCommand",
              "Commande récursive et speech terminant par un token de fermeture.",
              srtRes.sCommand == "àdsf"
           );
    addTestInfo("Chaîne testée", sTest);
    addTestInfo("Commande récupérée", srtRes.sCommand);
    addTestInfo("Position du token d'ouverture", IntToString(srtRes.iOpeningTokPos));
    addTestInfo("Position du token de fermeture", IntToString(srtRes.iClosingTokPos));
}

void ts_scmGetFirstCommand_ImbricatedCommands_TwoSidesTokens() {
    string sTest = "<!omJ <!F_ç<!àdsf!>IE!>fj!>";
    struct scm_command_datas srtRes = scmGetFirstCommand(sTest);
    addTest(
              "scmGetFirstCommand",
              "Commande récursive et speech commençant et terminant par des tokens.",
              srtRes.sCommand == "àdsf"
           );
    addTestInfo("Chaîne testée", sTest);
    addTestInfo("Commande récupérée", srtRes.sCommand);
    addTestInfo("Position du token d'ouverture", IntToString(srtRes.iOpeningTokPos));
    addTestInfo("Position du token de fermeture", IntToString(srtRes.iClosingTokPos));
}

void ts_scmGetFirstCommand_MaximalRecursionRateExceeded(int iDeep) {
    string sTest;
    int i;
    for (i=0;i<iDeep;i++) {
        sTest += "00<!";
    }
    sTest += "0000";
    for (i=0;i<iDeep;i++) {
        sTest += "!>00";
    }
    struct scm_command_datas srtRes = scmGetFirstCommand(sTest);
    addTest("scmGetFirstCommand", "Profondeur de récursivité dépassée.", srtRes.sCommand == SCM_ERROR);
    addTestInfo("Chaîne testée", sTest);
    addTestInfo("Chaîne attendue", SCM_ERROR);
    addTestInfo("Commande récupérée", srtRes.sCommand);
    addTestInfo("Position du token d'ouverture", IntToString(srtRes.iOpeningTokPos));
    addTestInfo("Position du token de fermeture", IntToString(srtRes.iClosingTokPos));
}

void ts_scmGetFirstCommand_NoOpeningToken() {
    string sTest = "000000!>000000!>000000";
    struct scm_command_datas srtRes = scmGetFirstCommand(sTest);
    addTest("scmGetFirstCommand", "Aucun jeton d'ouverture trouvé dans la chaîne.", srtRes.sCommand == SCM_ERROR);
    addTestInfo("Chaîne testée", sTest);
    addTestInfo("Chaîne attendue", SCM_ERROR);
    addTestInfo("Commande récupérée", srtRes.sCommand);
    addTestInfo("Position du token d'ouverture", IntToString(srtRes.iOpeningTokPos));
    addTestInfo("Position du token de fermeture", IntToString(srtRes.iClosingTokPos));
}

void ts_scmGetFirstCommand_NoClosingToken() {
    string sTest = "000000<!000000<!000000";
    struct scm_command_datas srtRes = scmGetFirstCommand(sTest);
    addTest("scmGetFirstCommand", "Aucun jeton de fermeture trouvé dans la chaîne.", srtRes.sCommand == SCM_ERROR);
    addTestInfo("Chaîne testée", sTest);
    addTestInfo("Commande attendue", SCM_ERROR);
    addTestInfo("Commande récupérée", srtRes.sCommand);
    addTestInfo("Position du token d'ouverture", IntToString(srtRes.iOpeningTokPos));
    addTestInfo("Position du token de fermeture", IntToString(srtRes.iClosingTokPos));
}

void ts_scmGetParameterValue_Standard() {
    string sName = "name";
    string sValue = "value";
    string sCommandName = "commandname";
    string sCommand = sCommandName+" "+sName+":"+sValue;
    string sResult = scmGetParameterValue(sCommand, sName);
    addTest("scmGetParameterValue", "Fonctionnement standard.", sResult == sValue);
    addTestInfo("Commande testée", sCommand);
    addTestInfo("Nom du paramètre", sName);
    addTestInfo("Valeur du paramètre", sValue);
    addTestInfo("Valeur récupérée", sResult);
}

void ts_scmGetParameterValue_WrongName() {
    string sName = "name";
    string sCommandName = "commandname";
    string sWrongName = "wrongname";
    string sValue = "value";
    string sCommand = sCommandName+" "+sName+":"+sValue;
    string sResult = scmGetParameterValue(sCommand, sWrongName);
    addTest("scmGetParameterValue", "Nom de paramètre incorrect.", sResult == SCM_ERROR);
    addTestInfo("Commande testée", sCommand);
    addTestInfo("Nom du paramètre", sName);
    addTestInfo("Nom testé", sWrongName);
    addTestInfo("Valeur du paramètre", sValue);
    addTestInfo("Valeur récupérée", sResult);
}

void ts_scmGetCommandName() {
    string sCommandName = "commandname";
    string sCommand = sCommandName+" name:home";
    string sResult = scmGetCommandName(sCommand);
    addTest("scmGetCommandName", "Récupération du nom de la commande.", sResult == sCommandName);
    addTestInfo("Commande testée", sCommand);
    addTestInfo("Nom de la commande", sCommandName);
    addTestInfo("Nom trouvé", sResult);
}

void ts_scmIsParameterDefined_ParameterDefined() {
    string sParameter = "test";
    string sCommand = "moveto loc "+sParameter+" go and:go toutou:";
    addTest("scmIsParameterDefined", "Paramètre présent et valide.", scmIsParameterDefined(sCommand, sParameter) == TRUE);
    addTestInfo("Commande testée", sCommand);
    addTestInfo("Paramètre recherché", sParameter);
}

void ts_scmIsParameterDefined_ParameterNotDefined() {
    string sParameter = "test";
    string sCommand = "moveto loc go and:go toutou:";
    addTest("scmIsParameterDefined", "Paramètre non présent.", scmIsParameterDefined(sCommand, sParameter) == FALSE);
    addTestInfo("Commande testée", sCommand);
    addTestInfo("Paramètre recherché", sParameter);
}

void ts_scmExecuteCommand(object oPC) {
    location lSaved = GetLocation(oPC);
    string sComName = "savepos";
    string sValueVar = "home";
    string sVarPara = "var";
    string sTypePara = "loc";
    string sCommand = sComName+" "+sTypePara+" "+sVarPara+":"+sValueVar;
    scmExecuteCommand(sCommand, oPC);
    location lResult = GetLocalLocation(oPC, sValueVar);
    addTest("scmExecuteCommand", "Sauvegarde d'une position de personnage.", lResult == lSaved);
    addTestInfo("Commande testée", sCommand);
    addTestInfo("Nom de la variable", sValueVar);
    addTestInfo("Position sauvée au préalable", LocationToString(lSaved));
    addTestInfo("Position récupérée", LocationToString(lResult));
    SendMessageToPC(oPC, "Test 'ts_scmExecuteCommand' effectué.");
}

void ts_scmFetchCommand() {
    string sSpeech = "La position de chez moi c'est <!saveloc name:chezmoi!> !!";
    struct scm_command_datas strScmCommandDatas = scmSetStructCommand(sSpeech, "saveloc name:chezmoi", 30, 52);
    string sResult = scmFetchCommand(strScmCommandDatas, "[COMMAND_RESULT]");
    addTest("scmFetchCommand", "Insertion du résultat d'une commande dans un speech.", sResult == "La position de chez moi c'est [COMMAND_RESULT] !!");
    addTestInfo("Speech testé", sSpeech);
    addTestInfo("Speech modifié", sResult);
}

/* Private Function */
void pv_do_OnModuleLoad_Tests() {
    ts_scmGetFirstCommand_TestCommand("fds<!ji__yf!>fjdiy", "ji__yf", FALSE);
    ts_scmGetFirstCommand_TestCommand("ezr-__<!WHFuu!>", "WHFuu", FALSE);
    ts_scmGetFirstCommand_TestCommand("<!dfezzz!>fjdiy", "dfezzz", FALSE);
    ts_scmGetFirstCommand_TestCommand("<!df_yèèzz!>", "df_yèèzz", FALSE);
    ts_scmGetFirstCommand_TestTokenPositions("<!fjdklji!>", 0, 9, FALSE);
    ts_scmGetFirstCommand_TestTokenPositions("fezf<!fjdklji!>", 4, 13, FALSE);
    ts_scmGetFirstCommand_TestTokenPositions("<!fjdklji!>fezfff", 0, 9, FALSE);
    ts_scmGetFirstCommand_TestTokenPositions("012345<!8901234!>fezfff", 6, 15, FALSE);
    ts_scmGetFirstCommand_TestCommand("fds<!ji<!__y!>f!>fjdiy", "__y", TRUE);
    ts_scmGetFirstCommand_TestCommand("ezr-__<!WH<!fdsii!>Fuu!>", "fdsii", TRUE);
    ts_scmGetFirstCommand_TestCommand("<!df<!jfiehh!>ezzz!>fjdiy", "jfiehh", TRUE);
    ts_scmGetFirstCommand_TestCommand("<!df<!_yèuieii!>èzz!>", "_yèuieii", TRUE);
    ts_scmGetFirstCommand_TestTokenPositions("<!fdkijfiejj<!fjdklji!>fezfff!>", 12, 21, TRUE);
    ts_scmGetFirstCommand_TestTokenPositions("jkf_d<!fjdk<!fduezhf!>hjfdjkfd!>", 11, 20, TRUE);
    ts_scmGetFirstCommand_TestTokenPositions("<!fjdk<!fjdkslii!>lji!>dkslfjkds", 6, 16, TRUE);
    ts_scmGetFirstCommand_TestTokenPositions("fjdkslj<!fjkdiie<!8901234!>fez!>fff", 16, 25, TRUE);
    
    ts_scmGetFirstCommand_MaximalRecursionRateExceeded(15);
    
    ts_scmGetFirstCommand_NoOpeningToken();
    ts_scmGetFirstCommand_NoClosingToken();
    
    ts_scmGetParameterValue_Standard();
    ts_scmGetParameterValue_WrongName();
    
    ts_scmGetCommandName();
    
    ts_scmIsParameterDefined_ParameterDefined();
    ts_scmIsParameterDefined_ParameterNotDefined();
    
    ts_scmFetchCommand();

    printResult(TS_SCM_TITLE);
}

/* Private Function */
void pv_do_OnClientEnter_Tests(object oPC, int iDepth = 0) {
    if (iDepth < TS_LOOP_MAX) {
        if (GetIsObjectValid(GetArea(oPC))) {
            
            ts_scmExecuteCommand(oPC);
            
            printResult(TS_SCM_TITLE);
        } else {
            DelayCommand(TS_LOOP_DELAY, pv_do_OnClientEnter_Tests(oPC, iDepth++));
        }
    }
}

void main() {
    if (TEST_MODE && TS_SCM_SYS) {
        object oMe = OBJECT_SELF;
        if (oMe == GetModule()) {
            pv_do_OnModuleLoad_Tests();

        } else if (GetIsPC(oMe)) {
            pv_do_OnClientEnter_Tests(oMe);
        }
    }
}