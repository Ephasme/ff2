/*********************************************************************/
/** Nom :              usu_in_tests
/** Date de cr�ation : 01/08/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant toutes les fonctions n�cessaires aux tests.
/*********************************************************************/

/***************************** PROTOTYPES ****************************/

// TODO: D�crire les fonctions.

void addTestInfos(string sString);
void addTest(string sFunction, string sCase, int iTest);
void addTestNext(string sString);
void addToFinalString(string sStringToAdd);
void printResult(string sScriptName);

/***************************** VARIABLES *****************************/

/* Variable servant de r�ceptacle aux informations r�sultantes des test. */
string sFinalString = "";

/***************************** CONSTANTES ****************************/

// D�fini si le syst�me de test est activ� ou non.
// D�sactiver (FALSE) absolument dans le cadre d'une Release car cela ralenti
// consid�rablement les performances du module.
const int TEST_MODE = TRUE;

/* Constantes de langage. */
const string L_TESTS_BEGIN = "D�but des tests";
const string L_TESTS_END = "Fin des tests";
const string L_CORRECT_FUNCTIONING_OF = "Fonctionnement correct de";
const string L_ABNORMAL_FUNCTIONING_OF = "Fonctionnement anormal de";
const string L_CASE = "Cas";
const string L_FOR = "pour";
const string L_HOUR = "Temps �coul�";
const string L_SOURCE = "Source";

/************************** IMPLEMENTATIONS **************************/

void addTestInfo(string sTitle, string sValue) {
    addToFinalString("           | "+sTitle+" : "+sValue);
}

void addTest(string sFunction, string sCase, int iTest) {
    string sResult;
    if (iTest) {
        sResult = "V OK -> "+L_CORRECT_FUNCTIONING_OF;
    } else {
        sResult = "X ER -> "+L_ABNORMAL_FUNCTIONING_OF;
    }
    addToFinalString(sResult+" "+sFunction+". ");
    addTestNext(L_CASE+" : "+sCase);
}

void addTestNext(string sString) {
    addToFinalString("         o "+sString);
}

void addToFinalString(string sStringToAdd) {
    sFinalString += "** "+sStringToAdd+"\n";
}

void printResult(string sScriptName) {
    PrintString("\n*************** "+L_TESTS_BEGIN+" "+L_FOR+" "+sScriptName+" ***************"
                +"\n**    X "+L_HOUR+" : "+IntToString(GetTimeMillisecond())
                +"\n**    X "+L_SOURCE+" : "+GetName(OBJECT_SELF)+"\n"
                +sFinalString+
                "*************** "+L_TESTS_END+" "+L_FOR+" "+sScriptName+" ***************\n");
}
