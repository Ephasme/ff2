/*********************************************************************/
/** Nom :              ts_scm_basis
/** Date de cr�ation : 02/08/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script sp�cial pour tester les fonctions de r�cup�ration des
/**   commandes.
/*********************************************************************/

/***************************** INCLUDES ******************************/

// Fonctions de gestion des tests.
#include "usu_in_tests"

            // Donnees de config.
            // #include "cos_in_config"

            // Fonctions de manipulation des cha�nes de caract�res.
            // #include "usu_in_strings"
        // Fonctions de manipulation et de tra�tement.
        // #include "scm_in_util"

        // Pour LocationToString (l86).
        // #include "x0_i0_position"
    // Fonctions d'ex�cution des commandes.
    // #include "scm_in_commands"
// Inclusion du fichier � tester.
#include "scm_in_basis"

// D�bug pour location.
#include "x0_i0_position"

/***************************** CONSTANTES ****************************/

// Constante � d�sactiver pour supprimer cette s�rie de test des logs.
const int TS_SCM_BASIS_ENABLED = FALSE;

/************************** IMPLEMENTATIONS **************************/

void ts_scmGetFirstCommand_TestCommand(string sSpeech, string sExpRes, int iRecursive) {
    string sType;
    if (iRecursive) {
        sType = "(r�cursive)";
    } else {
        sType = "(non r�cursive)";
    }
    struct scm_command_datas srtRes = scmGetFirstCommand(sSpeech);
    addTest(
              "scmGetFirstCommand",
              "Test de la commande r�cup�r�e "+sType+".",
              srtRes.sCommand == sExpRes
           );
    addTestInfo("Cha�ne test�e", sSpeech);
    addTestInfo("Commande r�cup�r�e", srtRes.sCommand);
}

void ts_scmGetFirstCommand_TestTokenPositions(string sSpeech, int iOExpPos, int iCExpPos, int iRecursive) {
    string sType;
    if (iRecursive) {
        sType = "(r�cursive)";
    } else {
        sType = "(non r�cursive)";
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
    addTestInfo("Cha�ne test�e", sSpeech);
    addTestInfo("Position du token d'ouverture", IntToString(srtRes.iOpeningTokPos));
    addTestInfo("Position du token de fermeture", IntToString(srtRes.iClosingTokPos));
}

void ts_scmGetFirstCommand_ImbricatedCommands_BeginWithToken() {
    string sTest = "<!omJ <!F_�<!�dsf!>IE!>fj!>fds";
    struct scm_command_datas srtRes = scmGetFirstCommand(sTest);
    addTest(
              "scmGetFirstCommand",
              "Commande r�cursive et speech commen�ant par un token d'ouverture.",
              srtRes.sCommand == "�dsf"
           );
    addTestInfo("Cha�ne test�e", sTest);
    addTestInfo("Commande r�cup�r�e", srtRes.sCommand);
    addTestInfo("Position du token d'ouverture", IntToString(srtRes.iOpeningTokPos));
    addTestInfo("Position du token de fermeture", IntToString(srtRes.iClosingTokPos));
}

void ts_scmGetFirstCommand_ImbricatedCommands_EndingWithToken() {
    string sTest = "fi<!omJ <!F_�<!�dsf!>IE!>fj!>";
    struct scm_command_datas srtRes = scmGetFirstCommand(sTest);
    addTest(
              "scmGetFirstCommand",
              "Commande r�cursive et speech terminant par un token de fermeture.",
              srtRes.sCommand == "�dsf"
           );
    addTestInfo("Cha�ne test�e", sTest);
    addTestInfo("Commande r�cup�r�e", srtRes.sCommand);
    addTestInfo("Position du token d'ouverture", IntToString(srtRes.iOpeningTokPos));
    addTestInfo("Position du token de fermeture", IntToString(srtRes.iClosingTokPos));
}

void ts_scmGetFirstCommand_ImbricatedCommands_TwoSidesTokens() {
    string sTest = "<!omJ <!F_�<!�dsf!>IE!>fj!>";
    struct scm_command_datas srtRes = scmGetFirstCommand(sTest);
    addTest(
              "scmGetFirstCommand",
              "Commande r�cursive et speech commen�ant et terminant par des tokens.",
              srtRes.sCommand == "�dsf"
           );
    addTestInfo("Cha�ne test�e", sTest);
    addTestInfo("Commande r�cup�r�e", srtRes.sCommand);
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
    addTest("scmGetFirstCommand", "Profondeur de r�cursivit� d�pass�e.", srtRes.sCommand == SCM_ERROR);
    addTestInfo("Cha�ne test�e", sTest);
    addTestInfo("Cha�ne attendue", SCM_ERROR);
    addTestInfo("Commande r�cup�r�e", srtRes.sCommand);
    addTestInfo("Position du token d'ouverture", IntToString(srtRes.iOpeningTokPos));
    addTestInfo("Position du token de fermeture", IntToString(srtRes.iClosingTokPos));
}

void ts_scmGetFirstCommand_NoOpeningToken() {
    string sTest = "000000!>000000!>000000";
    struct scm_command_datas srtRes = scmGetFirstCommand(sTest);
    addTest("scmGetFirstCommand", "Aucun jeton d'ouverture trouv� dans la cha�ne.", srtRes.sCommand == SCM_ERROR);
    addTestInfo("Cha�ne test�e", sTest);
    addTestInfo("Cha�ne attendue", SCM_ERROR);
    addTestInfo("Commande r�cup�r�e", srtRes.sCommand);
    addTestInfo("Position du token d'ouverture", IntToString(srtRes.iOpeningTokPos));
    addTestInfo("Position du token de fermeture", IntToString(srtRes.iClosingTokPos));
}

void ts_scmGetFirstCommand_NoClosingToken() {
    string sTest = "000000<!000000<!000000";
    struct scm_command_datas srtRes = scmGetFirstCommand(sTest);
    addTest("scmGetFirstCommand", "Aucun jeton de fermeture trouv� dans la cha�ne.", srtRes.sCommand == SCM_ERROR);
    addTestInfo("Cha�ne test�e", sTest);
    addTestInfo("Commande attendue", SCM_ERROR);
    addTestInfo("Commande r�cup�r�e", srtRes.sCommand);
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
    addTestInfo("Commande test�e", sCommand);
    addTestInfo("Nom du param�tre", sName);
    addTestInfo("Valeur du param�tre", sValue);
    addTestInfo("Valeur r�cup�r�e", sResult);
}

void ts_scmGetParameterValue_WrongName() {
    string sName = "name";
    string sCommandName = "commandname";
    string sWrongName = "wrongname";
    string sValue = "value";
    string sCommand = sCommandName+" "+sName+":"+sValue;
    string sResult = scmGetParameterValue(sCommand, sWrongName);
    addTest("scmGetParameterValue", "Nom de param�tre incorrect.", sResult == SCM_ERROR);
    addTestInfo("Commande test�e", sCommand);
    addTestInfo("Nom du param�tre", sName);
    addTestInfo("Nom test�", sWrongName);
    addTestInfo("Valeur du param�tre", sValue);
    addTestInfo("Valeur r�cup�r�e", sResult);
}

void ts_scmGetCommandName() {
    string sCommandName = "commandname";
    string sCommand = sCommandName+" name:home";
    string sResult = scmGetCommandName(sCommand);
    addTest("scmGetCommandName", "R�cup�ration du nom de la commande.", sResult == sCommandName);
    addTestInfo("Commande test�e", sCommand);
    addTestInfo("Nom de la commande", sCommandName);
    addTestInfo("Nom trouv�", sResult);
}

void ts_scmIsParameterDefined_ParameterDefined() {
    string sParameter = "test";
    string sCommand = "moveto loc "+sParameter+" go and:go toutou:";
    addTest("scmIsParameterDefined", "Param�tre pr�sent et valide.", scmIsParameterDefined(sCommand, sParameter) == TRUE);
    addTestInfo("Commande test�e", sCommand);
    addTestInfo("Param�tre recherch�", sParameter);
}

void ts_scmIsParameterDefined_ParameterNotDefined() {
    string sParameter = "test";
    string sCommand = "moveto loc go and:go toutou:";
    addTest("scmIsParameterDefined", "Param�tre non pr�sent.", scmIsParameterDefined(sCommand, sParameter) == FALSE);
    addTestInfo("Commande test�e", sCommand);
    addTestInfo("Param�tre recherch�", sParameter);
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
    addTestInfo("Commande test�e", sCommand);
    addTestInfo("Nom de la variable", sValueVar);
    addTestInfo("Position sauv�e au pr�alable", LocationToString(lSaved));
    addTestInfo("Position r�cup�r�e", LocationToString(lResult));
    SendMessageToPC(oPC, "Test 'ts_scmExecuteCommand' effectu�.");
}

void ts_scmFetchCommand() {
    string sSpeech = "La position de chez moi c'est <!saveloc name:chezmoi!> !!";
    //                          1111111111222222222233333333334444444444555555555
    //                01234567890123456789012345678901234567890123456789012345678
    struct scm_command_datas strScmCommandDatas = scmSetStructCommand(sSpeech, "saveloc name:chezmoi", 30, 52);
    string sResult = scmFetchCommand(strScmCommandDatas, "[COMMAND_RESULT]");
    addTest("scmFetchCommand", "Insertion du r�sultat d'une commande dans un speech.", sResult == "La position de chez moi c'est [COMMAND_RESULT] !!");
    addTestInfo("Speech test�", sSpeech);
    addTestInfo("Speech modifi�", sResult);
}

void main() {
    // On ex�cute les tests.
    if (TEST_MODE && TS_SCM_BASIS_ENABLED) {
        if (OBJECT_SELF == GetModule()) {
            // Test ex�cut�s sur le module.
            ts_scmGetFirstCommand_TestCommand("fds<!ji__yf!>fjdiy", "ji__yf", FALSE);
            ts_scmGetFirstCommand_TestCommand("ezr-__<!WHFuu!>", "WHFuu", FALSE);
            ts_scmGetFirstCommand_TestCommand("<!dfezzz!>fjdiy", "dfezzz", FALSE);
            ts_scmGetFirstCommand_TestCommand("<!df_y��zz!>", "df_y��zz", FALSE);
            ts_scmGetFirstCommand_TestTokenPositions("<!fjdklji!>", 0, 9, FALSE);
                                                    //          1111111111222222222233333333334444444444555555555566666666667777777777
                                                    //01234567890123456789012345678901234567890123456789012345678901234567890123456789
            ts_scmGetFirstCommand_TestTokenPositions("fezf<!fjdklji!>", 4, 13, FALSE);
                                                    //          1111111111222222222233333333334444444444555555555566666666667777777777
                                                    //01234567890123456789012345678901234567890123456789012345678901234567890123456789
            ts_scmGetFirstCommand_TestTokenPositions("<!fjdklji!>fezfff", 0, 9, FALSE);
                                                    //          1111111111222222222233333333334444444444555555555566666666667777777777
                                                    //01234567890123456789012345678901234567890123456789012345678901234567890123456789
            ts_scmGetFirstCommand_TestTokenPositions("012345<!8901234!>fezfff", 6, 15, FALSE);
                                                    //          1111111111222222222233333333334444444444555555555566666666667777777777
                                                    //01234567890123456789012345678901234567890123456789012345678901234567890123456789

            ts_scmGetFirstCommand_TestCommand("fds<!ji<!__y!>f!>fjdiy", "__y", TRUE);
            ts_scmGetFirstCommand_TestCommand("ezr-__<!WH<!fdsii!>Fuu!>", "fdsii", TRUE);
            ts_scmGetFirstCommand_TestCommand("<!df<!jfiehh!>ezzz!>fjdiy", "jfiehh", TRUE);
            ts_scmGetFirstCommand_TestCommand("<!df<!_y�uieii!>�zz!>", "_y�uieii", TRUE);
            ts_scmGetFirstCommand_TestTokenPositions("<!fdkijfiejj<!fjdklji!>fezfff!>", 12, 21, TRUE);
                                                    //          1111111111222222222233333333334444444444555555555566666666667777777777
                                                    //01234567890123456789012345678901234567890123456789012345678901234567890123456789
            ts_scmGetFirstCommand_TestTokenPositions("jkf_d<!fjdk<!fduezhf!>hjfdjkfd!>", 11, 20, TRUE);
                                                    //          1111111111222222222233333333334444444444555555555566666666667777777777
                                                    //01234567890123456789012345678901234567890123456789012345678901234567890123456789
            ts_scmGetFirstCommand_TestTokenPositions("<!fjdk<!fjdkslii!>lji!>dkslfjkds", 6, 16, TRUE);
                                                    //          1111111111222222222233333333334444444444555555555566666666667777777777
                                                    //01234567890123456789012345678901234567890123456789012345678901234567890123456789
            ts_scmGetFirstCommand_TestTokenPositions("fjdkslj<!fjkdiie<!8901234!>fez!>fff", 16, 25, TRUE);
                                                    //          1111111111222222222233333333334444444444555555555566666666667777777777
                                                    //01234567890123456789012345678901234567890123456789012345678901234567890123456789

            ts_scmGetFirstCommand_MaximalRecursionRateExceeded(15);

            ts_scmGetFirstCommand_NoOpeningToken();
            ts_scmGetFirstCommand_NoClosingToken();

            ts_scmGetParameterValue_Standard();
            ts_scmGetParameterValue_WrongName();

            ts_scmGetCommandName();

            ts_scmIsParameterDefined_ParameterDefined();
            ts_scmIsParameterDefined_ParameterNotDefined();

            ts_scmFetchCommand();

            // On envoie les resultats.
            printResult("ts_scm_basis");
        } else if (GetIsPC(OBJECT_SELF)) {
            if (GetArea(OBJECT_SELF) == OBJECT_INVALID) {
                DelayCommand(2.0f, ExecuteScript("ts_scm_basis", OBJECT_SELF));
                return;
            }
            // Tests ex�cut�s sur un PJ dans une aire valide.
            ts_scmExecuteCommand(OBJECT_SELF);

            // On envoie les resultats.
            printResult("ts_scm_basis");
        }
    }
}

