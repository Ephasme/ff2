/*********************************************************************/
/** Nom :              ts_usu_sys
/** Date de cr�ation : 19/07/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script sp�cial pour tester les fonctions de manipulation de
/**   chaines.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "usu_testfuncs"

#include "usu_stringtokman"
#include "usu_movings"
#include "usu_locmanip"

/***************************** CONSTANTES ****************************/

// Constante � d�sactiver pour supprimer cette s�rie de test des logs.
const int TS_USU_SYS = TRUE;

/* Cha�ne utilis�e pour tester les fonctions de manipulation de cha�ne. */
const string TEST_STRING = "jfi<omJ  F IE!>fj <JKFMDio  <  uhuaibj!> k lru<jeuirez!> f5kdsmHB<uohe>!!!";
//                                       1    1         2         3       4       5          6    6  //
//                             3         3    8         8         8       6       4          5    0  //

const string TEST_TRIM_SPACE_STRING = "    testme    ";

/************************** IMPLEMENTATIONS **************************/

/* Private function */
location pv_SetLocation(object oArea, float x, float y, float z, float facing) {
    vector v;
    v.x = x;
    v.y = y;
    v.z = z;
    return Location(oArea, v, facing);
}

void ts_usuLocationToString_LocationValid() {
    // Cr�ation de la location � tester.
    location lLoc = pv_SetLocation(GetObjectByTag("area001"), 1.0, 2.0, 3.0, 90.0);

    string sResult = usuLocationToString(lLoc);
    addTest("usuLocationToString", "Test avec une Location valide.", sResult == "##area001##1.000##2.000##3.000##90.000##");
    addTestInfo("Resultat", sResult);
}

void ts_usuLocationToString_LocationInvalid() {
    // Cr�ation de la location � tester.
    location lLoc = pv_SetLocation(GetObjectByTag("__##__"), 0.0, 0.0, 0.0, 0.0);
    string sResult = usuLocationToString(lLoc);
    addTest("usuLocationToString", "Test avec une Location invalide.", sResult == "####0.000##0.000##0.000##0.000##");
    addTestInfo("Resultat", sResult);
}

void ts_usuStringToLocation_StringValid() {
    string sTestValue = "##area001##1.000##2.000##3.000##90.000##";
    location lLoc = usuStringToLocation(sTestValue);
    vector v = GetPositionFromLocation(lLoc);
    float fac = GetFacingFromLocation(lLoc);
    object o = GetAreaFromLocation(lLoc);

    int iResult = (v.x == 1.0 && v.y == 2.0 && v.z == 3.0 && fac == 90.0 && GetTag(o) == "area001");

    addTest("usuLocationToString", "Test avec une cha�ne valide.", iResult);
    addTestInfo("Cha�ne test�e", sTestValue);
    addTestInfo("X", FloatToString(v.x, 0, 3));
    addTestInfo("Y", FloatToString(v.y, 0, 3));
    addTestInfo("Z", FloatToString(v.z, 0, 3));
    addTestInfo("Facing", FloatToString(v.x, 0, 3));
    addTestInfo("Aire", GetTag(o));
}

void ts_usuStringToLocation_StringInvalid() {
    string sTestValue = "####1.000##2.000##3.000##90.000##";
    location lLoc = usuStringToLocation(sTestValue);
    vector v = GetPositionFromLocation(lLoc);
    float fac = GetFacingFromLocation(lLoc);
    object o = GetAreaFromLocation(lLoc);

    int iResult = (v.x == 1.0 && v.y == 2.0 && v.z == 3.0 && fac == 90.0 && GetTag(o) == "");
    iResult = (iResult && !GetIsObjectValid(o));

    addTest("usuLocationToString", "Test avec une cha�ne valide.", iResult);
    addTestInfo("Cha�ne test�e", sTestValue);
    addTestInfo("X", FloatToString(v.x, 0, 3));
    addTestInfo("Y", FloatToString(v.x, 0, 3));
    addTestInfo("Z", FloatToString(v.x, 0, 3));
    addTestInfo("Facing", FloatToString(v.x, 0, 3));
    addTestInfo("Aire invalide", IntToString(!GetIsObjectValid(o)));
    addTestInfo("Tag de l'aire", GetTag(o));
}

void ts_usuGetLastTokenPosition() {
    int iPos = usuGetLastTokenPosition(TEST_STRING, "!>");
    addTest("usuGetLastTokenPosition", "Renvoyer la position du premier token.", iPos == 54);
}

void ts_usuGetFirstTokenPosition() {
    int iPos = usuGetFirstTokenPosition(TEST_STRING, "<");
    addTest("usuGetFirstTokenPosition", "Renvoyer la position du premier token.", iPos == 3);
}

void ts_usuTrimLeftSpaces() {
    string sRes = usuTrimLeftSpaces(TEST_TRIM_SPACE_STRING);
    addTest("usuTrimRightSpaces", "Retirer les espaces � gauche.", GetStringLeft(sRes, 1) != " ");
}

void ts_usuTrimRightSpaces() {
    string sRes = usuTrimRightSpaces(TEST_TRIM_SPACE_STRING);
    addTest("usuTrimRightSpaces", "Retirer les espaces � droite.", GetStringRight(sRes, 1) != " ");
}

void ts_usuGetStringBeforeToken() {
    string sRes = usuGetStringBeforeToken(TEST_STRING, 18);
    addTest("usuGetStringBeforeToken", "R�cup�ration d'une cha�ne avant un token.", sRes == "jfi<omJ  F IE!>fj ");
}

void ts_usuGetStringAfterToken() {
    string sRes = usuGetStringAfterToken(TEST_STRING, 2, 54);
    addTest("usuGetStringAfterToken", "R�cup�ration d'une cha�ne apr�s un token.", sRes == " f5kdsmHB<uohe>!!!");
}

void ts_usuGetStringBetweenTokens_TokenPositionOK() {
    string sRes = usuGetStringBetweenTokens(TEST_STRING, 28, 1, 38);
    addTest("usuGetStringBetweenTokens", "R�cup�ration d'une cha�ne entre deux tokens, les tokens sont bien plac�s.", sRes == "  uhuaibj");
    addTestInfo("Cha�ne test�e", TEST_STRING);
    addTestInfo("R�sultat attendu", "  uhuaibj");
    addTestInfo("R�sultat", sRes);
}

void ts_usuGetStringBetweenTokens_TokenPositionError() {
    string sRes = usuGetStringBetweenTokens(TEST_STRING, 28, 1, 13);
    addTest("usuGetStringBetweenTokens", "R�cup�ration d'une cha�ne entre deux tokens, les tokens sont mal plac�s.", sRes == STRING_RESULT_ERROR);
    addTestInfo("Cha�ne test�e", TEST_STRING);
    addTestInfo("R�sultat attendu", STRING_RESULT_ERROR);
    addTestInfo("R�sultat", sRes);
}

void ts_usuGetPreviousTokenPosition_IdenticalTokens(string sTok) {
    string sFirstString = "_rfi&(v";
    string sSecondString = "ds_�fkijszl:fuhy";
    string sThirdString = "jhf_zbr";
    string sTestString = sFirstString + sTok + sSecondString + sTok + sThirdString;
    int iFirstTokPos = GetStringLength(sFirstString);
    int iSecondTokPos = iFirstTokPos + GetStringLength(sTok) + GetStringLength(sSecondString);
    int iRes = usuGetPreviousTokenPosition(sTestString, sTok, sTok, iSecondTokPos);
    addTest("usuGetPreviousTokenPosition", "Deux tokens identiques.", iRes == iFirstTokPos);
}

void ts_usuGetPreviousTokenPosition_TokenSize(int iSize = 5) {
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
    int iRes = usuGetPreviousTokenPosition(sTestString, sOpenTok, sEndingTok, iSecondTokPos);
    addTest("usuGetPreviousTokenPosition", "Deux tokens diff�rents de taille donn�e.", iRes == iFirstTokPos);
}

void ts_usuGetNextTokenPosition_IdenticalTokens(string sTok) {
    string sFirstString = "_rfi&(v";
    string sSecondString = "ds_�fkijszl:fuhy";
    string sThirdString = "jhf_zbr";
    string sTestString = sFirstString + sTok + sSecondString + sTok + sThirdString;
    int iFirstTokPos = GetStringLength(sFirstString);
    int iSecondTokPos = iFirstTokPos + GetStringLength(sTok) + GetStringLength(sSecondString);
    int iRes = usuGetNextTokenPosition(sTestString, sTok, sTok, iFirstTokPos);
    addTest("usuGetNextTokenPosition", "Deux tokens identiques.", iRes == iSecondTokPos);
    addTestInfo("Cha�ne test�e", sTestString);
    addTestInfo("Position du premier token", IntToString(iFirstTokPos));
    addTestInfo("Position du deuxi�me token", IntToString(iSecondTokPos));
    addTestInfo("R�sultat", IntToString(iRes));
}

void ts_usuGetNextTokenPosition_NotExists() {
    string sTest = "fhuz<!�=$^�<!qfdsh";
    //                         1
    //                  4      1
    int iRes = usuGetNextTokenPosition(sTest, "!>", "<!", 4);
    addTest("usuGetNextTokenPosition", "Le token suivant n'existe pas.", iRes == TOKEN_POSITION_ERROR);
    addTestInfo("Cha�ne test�e", sTest);
    addTestInfo("Position du premier token", IntToString(4));
    addTestInfo("R�sultat esp�r�", IntToString(TOKEN_POSITION_ERROR));
    addTestInfo("R�sultat", IntToString(iRes));
}

void ts_usuGetPreviousTokenPosition_NotExists() {
    string sTest = "fhuz!>�=$^�!>qfdsh";
    //                         1
    //                  4      1
    int iRes = usuGetPreviousTokenPosition(sTest, "<!", "!>", 11);
    addTest("usuGetPreviousTokenPosition", "Le token pr�c�dent n'existe pas.", iRes == TOKEN_POSITION_ERROR);
    addTestInfo("Cha�ne test�e", sTest);
    addTestInfo("Position du premier token", IntToString(11));
    addTestInfo("R�sultat esp�r�", IntToString(TOKEN_POSITION_ERROR));
    addTestInfo("R�sultat", IntToString(iRes));
}

void ts_usuGetNextTokenPosition_TokenSize(int iSize = 5) {
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
    int iRes = usuGetNextTokenPosition(sTestString, sEndingTok, sOpenTok, iFirstTokPos);
    addTest("usuGetNextTokenPosition", "Deux tokens diff�rents de taille donn�e.", iRes == iSecondTokPos);
}


void main()
{
    // On ex�cute les tests.
    if (TEST_MODE && TS_USU_SYS) {
        ts_usuLocationToString_LocationValid();
        ts_usuLocationToString_LocationInvalid();
        ts_usuStringToLocation_StringValid();
        ts_usuStringToLocation_StringInvalid();

        ts_usuGetLastTokenPosition();
        ts_usuGetFirstTokenPosition();

        ts_usuTrimLeftSpaces();
        ts_usuTrimRightSpaces();

        ts_usuGetStringAfterToken();
        ts_usuGetStringBeforeToken();
        ts_usuGetStringBetweenTokens_TokenPositionOK();
        ts_usuGetStringBetweenTokens_TokenPositionError();

        ts_usuGetNextTokenPosition_TokenSize(3);
        ts_usuGetNextTokenPosition_IdenticalTokens("/!%*");
        ts_usuGetNextTokenPosition_NotExists();

        ts_usuGetPreviousTokenPosition_TokenSize(3);
        ts_usuGetPreviousTokenPosition_IdenticalTokens("/!%*");
        ts_usuGetPreviousTokenPosition_NotExists();

        // On envoie les resultats.
        printResult("USU SYSTEM");
    }
}
