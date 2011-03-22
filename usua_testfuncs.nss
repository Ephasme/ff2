/*********************************************************************/
/** Nom :              usua_testfuncs
/** Date de cr�ation : 01/08/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant toutes les fonctions n�cessaires aux tests.
/*********************************************************************/

#include "usua_constants"

/***************************** PROTOTYPES ****************************/

// TODO: D�crire les fonctions.

void addTestInfos(string sString);
void addTest(string sFunction, string sCase, int iTest);
void addTestNext(string sString);
void addToFinalString(string sStringToAdd);
void printResult(string sScriptName);

/***************************** VARIABLES *****************************/

/* Variable servant de r�ceptacle aux informations r�sultantes des tests. */
string sFinalString = "";

/************************** IMPLEMENTATIONS **************************/

void addTestInfo(string sTitle, string sValue) {
    addToFinalString("           | "+sTitle+" : "+sValue);
}

void addTest(string sFunction, string sCase, int iTest) {
    string sResult;
    if (iTest) {
        sResult = "V OK -> "+TS_L_CORRECT_FUNCTIONING_OF;
    } else {
        sResult = "X ER -> "+TS_L_ABNORMAL_FUNCTIONING_OF;
    }
    addToFinalString(sResult+" "+sFunction+". ");
    addTestNext(TS_L_CASE+" : "+sCase);
}

void addTestNext(string sString) {
    addToFinalString("         o "+sString);
}

void addToFinalString(string sStringToAdd) {
    sFinalString += "** "+sStringToAdd+"\n";
}

void printResult(string sScriptName) {
    PrintString("\n*************** "+TS_L_TESTS_BEGIN+" "+TS_L_FOR+" "+sScriptName+" ***************"
                +"\n**    X "+TS_L_HOUR+" : "+IntToString(GetTimeMillisecond())
                +"\n**    X "+TS_L_SOURCE+" : "+GetName(OBJECT_SELF)+"\n"
                +sFinalString+
                "*************** "+TS_L_TESTS_END+" "+TS_L_FOR+" "+sScriptName+" ***************\n");
}
