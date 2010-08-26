/*********************************************************************/
/** Nom :              ts_usu_location
/** Date de création : 19/07/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script spécial pour tester les fonctions de manipulation de
/**   chaines.
/*********************************************************************/

/***************************** INCLUDES ******************************/

// Fonctions de gestion des tests.
#include "usu_in_tests"

// Inclusion du fichier à tester.
#include "usu_in_location"

/***************************** CONSTANTES ****************************/

// Constante à désactiver pour supprimer cette série de test des logs.
const int TS_USU_LOCATION_ENABLED = FALSE;

/************************** IMPLEMENTATIONS **************************/

location _SetLocation(object oArea, float x, float y, float z, float facing) {
    vector v;
    v.x = x;
    v.y = y;
    v.z = z;
    return Location(oArea, v, facing);
}

void ts_usuLocationToString_LocationValid() {
    // Création de la location à tester.
    location lLoc = _SetLocation(GetObjectByTag("area001"), 1.0, 2.0, 3.0, 90.0);

    string sResult = usuLocationToString(lLoc);
    addTest("usuLocationToString", "Test avec une Location valide.", sResult == "##area001##1.000##2.000##3.000##90.000##");
    addTestInfo("Resultat", sResult);
}

void ts_usuLocationToString_LocationInvalid() {
    // Création de la location à tester.
    location lLoc = _SetLocation(GetObjectByTag("__##__"), 0.0, 0.0, 0.0, 0.0);
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

    addTest("usuLocationToString", "Test avec une chaîne valide.", iResult);
    addTestInfo("Chaîne testée", sTestValue);
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

    addTest("usuLocationToString", "Test avec une chaîne valide.", iResult);
    addTestInfo("Chaîne testée", sTestValue);
    addTestInfo("X", FloatToString(v.x, 0, 3));
    addTestInfo("Y", FloatToString(v.x, 0, 3));
    addTestInfo("Z", FloatToString(v.x, 0, 3));
    addTestInfo("Facing", FloatToString(v.x, 0, 3));
    addTestInfo("Aire invalide", IntToString(!GetIsObjectValid(o)));
    addTestInfo("Tag de l'aire", GetTag(o));
}


void main()
{
    // On exécute les tests.
    if (TEST_MODE && TS_USU_LOCATION_ENABLED) {
        ts_usuLocationToString_LocationValid();
        ts_usuLocationToString_LocationInvalid();
        ts_usuStringToLocation_StringValid();
        ts_usuStringToLocation_StringInvalid();
        // On envoie les resultats.
        printResult("ts_usu_location");
    }
}
