/*********************************************************************/
/** Nom :              ts_std_sys
/** Date de cr�ation : 19/07/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script sp�cial pour tester les fonctions de manipulation de
/**   chaines.
/*********************************************************************/

/***************************** INCLUDES ******************************/

    // #include "stda_constants"
#include "stda_testfuncs"

    // #include "stda_constants"
#include "stda_moving"

        // #include "stda_constants"
    // #include "stda_strtokman"
#include "stda_locmanips"

/************************** IMPLEMENTATIONS **************************/

/* Private function */
location pv_SetLocation(object oArea, float x, float y, float z, float facing) {
    vector v;
    v.x = x;
    v.y = y;
    v.z = z;
    return Location(oArea, v, facing);
}

void ts_stdLocationToString_LocationValid() {
    // Cr�ation de la location � tester.
    location lLoc = pv_SetLocation(GetObjectByTag("sys_ar_00"), 1.0, 2.0, 3.0, 90.0);

    string sResult = stdLocationToString(lLoc);
    addTest("stdLocationToString", "Test avec une Location valide.", sResult == "##sys_ar_00##1.000##2.000##3.000##90.000##");
    addTestInfo("Resultat", sResult);
}

void ts_stdLocationToString_LocationInvalid() {
    // Cr�ation de la location � tester.
    //location lLoc = pv_SetLocation(GetObjectByTag(""), 0.0, 0.0, 0.0, 0.0);
    location lLoc = GetLocation(OBJECT_INVALID);
    string sResult = stdLocationToString(lLoc);
    addTest("stdLocationToString", "Test avec une Location invalide.", sResult == "####0.000##0.000##0.000##0.000##");
    addTestInfo("Resultat", sResult);
}

void ts_stdStringToLocation_StringValid() {
    string sTestValue = "##sys_ar_00##1.000##2.000##3.000##90.000##";
    location lLoc = stdStringToLocation(sTestValue);
    vector v = GetPositionFromLocation(lLoc);
    float fac = GetFacingFromLocation(lLoc);
    object o = GetAreaFromLocation(lLoc);

    int iResult = (v.x == 1.0 && v.y == 2.0 && v.z == 3.0 && fac == 90.0 && GetTag(o) == "sys_ar_00");

    addTest("stdLocationToString", "Test avec une cha�ne valide.", iResult);
    addTestInfo("Cha�ne test�e", sTestValue);
    addTestInfo("X", FloatToString(v.x, 0, 3));
    addTestInfo("Y", FloatToString(v.y, 0, 3));
    addTestInfo("Z", FloatToString(v.z, 0, 3));
    addTestInfo("Facing", FloatToString(v.x, 0, 3));
    addTestInfo("Aire", GetTag(o));
}

void ts_stdStringToLocation_StringInvalid() {
    string sTestValue = "####1.000##2.000##3.000##90.000##";
    location lLoc = stdStringToLocation(sTestValue);
    vector v = GetPositionFromLocation(lLoc);
    float fac = GetFacingFromLocation(lLoc);
    object o = GetAreaFromLocation(lLoc);

    int iResult = (v.x == 1.0 && v.y == 2.0 && v.z == 3.0 && fac == 90.0 && GetTag(o) == "");
    iResult = (iResult && !GetIsObjectValid(o));

    addTest("stdLocationToString", "Test avec une cha�ne valide.", iResult);
    addTestInfo("Cha�ne test�e", sTestValue);
    addTestInfo("X", FloatToString(v.x, 0, 3));
    addTestInfo("Y", FloatToString(v.x, 0, 3));
    addTestInfo("Z", FloatToString(v.x, 0, 3));
    addTestInfo("Facing", FloatToString(v.x, 0, 3));
    addTestInfo("Aire invalide", IntToString(!GetIsObjectValid(o)));
    addTestInfo("Tag de l'aire", GetTag(o));
}

void ts_stdGetLastTokenPosition() {
    int iPos = stdGetLastTokenPosition(TS_CMD_STRING, "!>");
    addTest("stdGetLastTokenPosition", "Renvoyer la position du premier token.", iPos == 54);
}

void ts_stdGetFirstTokenPosition() {
    int iPos = stdGetFirstTokenPosition(TS_CMD_STRING, "<");
    addTest("stdGetFirstTokenPosition", "Renvoyer la position du premier token.", iPos == 3);
}

void ts_stdTrimLeftSpaces() {
    string sRes = stdTrimLeftSpaces(TS_CMD_TRIM_SPACES);
    addTest("stdTrimRightSpaces", "Retirer les espaces � gauche.", GetStringLeft(sRes, 1) != " ");
}

void ts_stdTrimRightSpaces() {
    string sRes = stdTrimRightSpaces(TS_CMD_TRIM_SPACES);
    addTest("stdTrimRightSpaces", "Retirer les espaces � droite.", GetStringRight(sRes, 1) != " ");
}

void ts_stdGetStringBeforeToken() {
    string sRes = stdGetStringBeforeToken(TS_CMD_STRING, 18);
    addTest("stdGetStringBeforeToken", "R�cup�ration d'une cha�ne avant un token.", sRes == "jfi<omJ  F IE!>fj ");
}

void ts_stdGetStringAfterToken() {
    string sRes = stdGetStringAfterToken(TS_CMD_STRING, 2, 54);
    addTest("stdGetStringAfterToken", "R�cup�ration d'une cha�ne apr�s un token.", sRes == " f5kdsmHB<uohe>!!!");
}

void ts_stdGetStringBetweenTokens_TokenPositionOK() {
    string sRes = stdGetStringBetweenTokens(TS_CMD_STRING, 28, 1, 38);
    addTest("stdGetStringBetweenTokens", "R�cup�ration d'une cha�ne entre deux tokens, les tokens sont bien plac�s.", sRes == "  uhuaibj");
    addTestInfo("Cha�ne test�e", TS_CMD_STRING);
    addTestInfo("R�sultat attendu", "  uhuaibj");
    addTestInfo("R�sultat", sRes);
}

void ts_stdGetStringBetweenTokens_TokenPositionError() {
    string sRes = stdGetStringBetweenTokens(TS_CMD_STRING, 28, 1, 13);
    addTest("stdGetStringBetweenTokens", "R�cup�ration d'une cha�ne entre deux tokens, les tokens sont mal plac�s.", sRes == STD_STRING_RESULT_ERROR);
    addTestInfo("Cha�ne test�e", TS_CMD_STRING);
    addTestInfo("R�sultat attendu", STD_STRING_RESULT_ERROR);
    addTestInfo("R�sultat", sRes);
}

void ts_stdGetPreviousTokenPosition_IdenticalTokens(string sTok) {
    string sFirstString = "_rfi&(v";
    string sSecondString = "ds_�fkijszl:fuhy";
    string sThirdString = "jhf_zbr";
    string sTestString = sFirstString + sTok + sSecondString + sTok + sThirdString;
    int iFirstTokPos = GetStringLength(sFirstString);
    int iSecondTokPos = iFirstTokPos + GetStringLength(sTok) + GetStringLength(sSecondString);
    int iRes = stdGetPreviousTokenPosition(sTestString, sTok, sTok, iSecondTokPos);
    addTest("stdGetPreviousTokenPosition", "Deux tokens identiques.", iRes == iFirstTokPos);
}

void ts_stdGetPreviousTokenPosition_TokenSize(int iSize = 5) {
    // Cr�ation du Token.
    string sOpenTok = "<";
    string sEndingTok = "";
    int i;
    for (i=0; i<iSize; i++) {
        sOpenTok += "$";
        sEndingTok += "$";
    }
    sEndingTok += ">";
    // Cr�ation de la cha�ne de test.
    string sFirstString = "_rfi&(v";
    string sSecondString = "ds_�fkijszl:fuhy";
    string sThirdString = "jhf_zbr";
    string sTestString = sFirstString + sOpenTok + sSecondString + sEndingTok + sThirdString;
    // R�cup�ration des positions des tokens.
    int iFirstTokPos = GetStringLength(sFirstString);
    int iSecondTokPos = iFirstTokPos + GetStringLength(sOpenTok) + GetStringLength(sSecondString);
    int iRes = stdGetPreviousTokenPosition(sTestString, sOpenTok, sEndingTok, iSecondTokPos);
    addTest("stdGetPreviousTokenPosition", "Deux tokens diff�rents de taille donn�e.", iRes == iFirstTokPos);
}

void ts_stdGetNextTokenPosition_IdenticalTokens(string sTok) {
    string sFirstString = "_rfi&(v";
    string sSecondString = "ds_�fkijszl:fuhy";
    string sThirdString = "jhf_zbr";
    string sTestString = sFirstString + sTok + sSecondString + sTok + sThirdString;
    int iFirstTokPos = GetStringLength(sFirstString);
    int iSecondTokPos = iFirstTokPos + GetStringLength(sTok) + GetStringLength(sSecondString);
    int iRes = stdGetNextTokenPosition(sTestString, sTok, sTok, iFirstTokPos);
    addTest("stdGetNextTokenPosition", "Deux tokens identiques.", iRes == iSecondTokPos);
    addTestInfo("Cha�ne test�e", sTestString);
    addTestInfo("Position du premier token", IntToString(iFirstTokPos));
    addTestInfo("Position du deuxi�me token", IntToString(iSecondTokPos));
    addTestInfo("R�sultat", IntToString(iRes));
}

void ts_stdGetNextTokenPosition_NotExists() {
    string sTest = "fhuz<!�=$^�<!qfdsh";
    //                         1
    //                  4      1
    int iRes = stdGetNextTokenPosition(sTest, "!>", "<!", 4);
    addTest("stdGetNextTokenPosition", "Le token suivant n'existe pas.", iRes == STD_TOKEN_POSITION_ERROR);
    addTestInfo("Cha�ne test�e", sTest);
    addTestInfo("Position du premier token", IntToString(4));
    addTestInfo("R�sultat esp�r�", IntToString(STD_TOKEN_POSITION_ERROR));
    addTestInfo("R�sultat", IntToString(iRes));
}

void ts_stdGetPreviousTokenPosition_NotExists() {
    string sTest = "fhuz!>�=$^�!>qfdsh";
    //                         1
    //                  4      1
    int iRes = stdGetPreviousTokenPosition(sTest, "<!", "!>", 11);
    addTest("stdGetPreviousTokenPosition", "Le token pr�c�dent n'existe pas.", iRes == STD_TOKEN_POSITION_ERROR);
    addTestInfo("Cha�ne test�e", sTest);
    addTestInfo("Position du premier token", IntToString(11));
    addTestInfo("R�sultat esp�r�", IntToString(STD_TOKEN_POSITION_ERROR));
    addTestInfo("R�sultat", IntToString(iRes));
}

void ts_stdGetNextTokenPosition_TokenSize(int iSize = 5) {
    // Cr�ation du Token.
    string sOpenTok = "<";
    string sEndingTok = "";
    int i;
    for (i=0; i<iSize; i++) {
        sOpenTok += "$";
        sEndingTok += "$";
    }
    sEndingTok += ">";
    // Cr�ation de la cha�ne de test.
    string sFirstString = "_rfi&(v";
    string sSecondString = "ds_�fkijszl:fuhy";
    string sThirdString = "jhf_zbr";
    string sTestString = sFirstString + sOpenTok + sSecondString + sEndingTok + sThirdString;
    // R�cup�ration des positions des tokens.
    int iFirstTokPos = GetStringLength(sFirstString);
    int iSecondTokPos = iFirstTokPos + GetStringLength(sOpenTok) + GetStringLength(sSecondString);
    int iRes = stdGetNextTokenPosition(sTestString, sEndingTok, sOpenTok, iFirstTokPos);
    addTest("stdGetNextTokenPosition", "Deux tokens diff�rents de taille donn�e.", iRes == iSecondTokPos);
}

/* Private Function */
void pv_do_OnModuleLoad_Tests() {

    ts_stdLocationToString_LocationValid();
    ts_stdLocationToString_LocationInvalid();
    ts_stdStringToLocation_StringValid();
    ts_stdStringToLocation_StringInvalid();

    ts_stdGetLastTokenPosition();
    ts_stdGetFirstTokenPosition();

    ts_stdTrimLeftSpaces();
    ts_stdTrimRightSpaces();

    ts_stdGetStringAfterToken();
    ts_stdGetStringBeforeToken();
    ts_stdGetStringBetweenTokens_TokenPositionOK();
    ts_stdGetStringBetweenTokens_TokenPositionError();

    ts_stdGetNextTokenPosition_TokenSize(3);
    ts_stdGetNextTokenPosition_IdenticalTokens("/!%*");
    ts_stdGetNextTokenPosition_NotExists();

    ts_stdGetPreviousTokenPosition_TokenSize(3);
    ts_stdGetPreviousTokenPosition_IdenticalTokens("/!%*");
    ts_stdGetPreviousTokenPosition_NotExists();

    printResult(TS_STD_TITLE);
}

/* Private Function */
void pv_do_OnClientEnter_Tests(object oPC, int iDepth = 0) {
    if (iDepth < TS_LOOP_MAX) {
        if (GetIsObjectValid(GetArea(oPC))) {

            /* INSERER LES TESTS A FAIRE SUR UN PC ICI */

            printResult(TS_STD_TITLE);
        } else {
            DelayCommand(TS_LOOP_DELAY, pv_do_OnClientEnter_Tests(oPC, iDepth++));
        }
    }
}

void main() {
    if (TS_TEST_MODE && TS_STD_SYS) {
        object oMe = OBJECT_SELF;
        if (oMe == GetModule()) {
            pv_do_OnModuleLoad_Tests();

        } else if (GetIsPC(oMe)) {
            pv_do_OnClientEnter_Tests(oMe);
        }
    }
}
