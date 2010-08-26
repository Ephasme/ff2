/*********************************************************************/
/** Nom :              ts_cos_character
/** Date de création : 20/08/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script spécial à lancer dans le OnClientEnter afin de tester
/**    toutes les fonctionnalités liées à la gestion des personnages.
/**    ATTENTION : Il faut lancer le script sur le personnage entrant.
/*********************************************************************/

/***************************** INCLUDES ******************************/

            // #include "usu_in_location"
        // #include "sql_in_basis"
    // #include "sql_in_character"
#include "cos_in_character"

#include "usu_in_tests"

/***************************** CONSTANTES ****************************/

// Nom du script de test.
const string TEST_SCRIPT_NAME = "ts_cos_character";

// Fréquence de la boucle d'attente de PJ valide.
const float VALID_PJ_FREQUENCY_LOOP = 2.0f;

// Constante à désactiver pour supprimer cette série de test des logs.
const int TS_COS_CHARACTER_ENABLED = TRUE;

/***************************** VARIABLES *****************************/

/************************** IMPLEMENTATIONS **************************/

void ts_cosGetPCWaypoint() {
    object oPC = OBJECT_SELF;

    object oPCWP = cosGetPCWaypoint(oPC);
    addTest (
        "cosGetPCWaypoint",
        "Test de la récupération du waypoint de donnée de personnage.",
        GetIsObjectValid(oPCWP) && GetObjectType(oPCWP) == OBJECT_TYPE_WAYPOINT
    );
    addTestInfo("Nom du waypoint", GetName(oPCWP));
    addTestInfo("Nom du PJ", GetName(oPC));
}

void ts_cosSaveIntOnPC() {
    object oPC = OBJECT_SELF;

    int iResult;
    int iToStore = 50;
    string sVarName = "testSavingIntOnPC";
    cosSaveIntOnPC(oPC, sVarName, iToStore);

    object oPCWP = GetLocalObject(oPC, PCWP_VARNAME);
    if (GetIsObjectValid(oPCWP)) {
        iResult = GetLocalInt(oPCWP, sVarName);
    }
    addTest (
        "cosSaveIntOnPC",
        "Sauvegarde d'un entier sur le Waypoint de donnée d'un PJ.",
        iResult == 50
    );
    addTestInfo("Valeur stokée", IntToString(iToStore));
    addTestInfo("Valeur retrouvée", IntToString(iResult));
    addTestInfo("Nom de la variable", sVarName);
}

void ts_cosGetIntFromPC() {
    object oPC = OBJECT_SELF;

    int iResult;
    int iToGet = 51;
    string sVarName = "testGettingIntFromPC";

    object oPCWP = GetLocalObject(oPC, PCWP_VARNAME);
    if (GetIsObjectValid(oPCWP)) {
        SetLocalInt(oPCWP, sVarName, iToGet);
    }

    iResult = cosGetIntFromPC(oPC, sVarName);

    addTest (
        "cosGetIntFromPC",
        "Récupération d'un entier du Waypoint de donnée d'un PJ.",
        iResult == 51
    );
    addTestInfo("Valeur stokée", IntToString(iToGet));
    addTestInfo("Valeur retrouvée", IntToString(iResult));
    addTestInfo("Nom de la variable", sVarName);
}

void ts_cosSaveLocationOnPC() {
    object oPC = OBJECT_SELF;

    location lResult;
    vector v;
    v.x = 5.0f; v.y = 6.0f; v.z = 0.0f;
    location lToStore = Location(GetAreaFromLocation(GetStartingLocation()), v, 90.0f);
    string sVarName = "testSavingLocOnPC";
    cosSaveLocationOnPC(oPC, sVarName, lToStore);

    object oPCWP = GetLocalObject(oPC, PCWP_VARNAME);
    if (GetIsObjectValid(oPCWP)) {
        lResult = GetLocalLocation(oPCWP, sVarName);
    }
    addTest (
        "cosSaveLocationOnPC",
        "Sauvegarde d'une location sur le Waypoint de donnée d'un PJ.",
        lResult == lToStore
    );
    addTestInfo("Valeur stokée", usuLocationToString(lToStore));
    addTestInfo("Valeur retrouvée", usuLocationToString(lResult));
    addTestInfo("Nom de la variable", sVarName);
}

void ts_cosGetLocationFromPC() {
    object oPC = OBJECT_SELF;

    location lResult;
    vector v;
    v.x = 5.0f; v.y = 6.0f; v.z = 0.0f;
    location lToGet = Location(GetAreaFromLocation(GetStartingLocation()), v, 90.0f);
    string sVarName = "testGettingLocFromPC";

    object oPCWP = GetLocalObject(oPC, PCWP_VARNAME);
    if (GetIsObjectValid(oPCWP)) {
        SetLocalLocation(oPCWP, sVarName, lToGet);
    }

    lResult = cosGetLocationFromPC(oPC, sVarName);

    addTest (
        "cosGetLocationFromPC",
        "Récupération d'un entier du Waypoint de donnée d'un PJ.",
        lResult == lToGet
    );
    addTestInfo("Valeur stokée", usuLocationToString(lToGet));
    addTestInfo("Valeur retrouvée", usuLocationToString(lResult));
    addTestInfo("Nom de la variable", sVarName);
}

void ts_cosSaveStringOnPC() {
    object oPC = OBJECT_SELF;

    string sResult;
    string sToStore = "STRING_TEST";
    string sVarName = "testSavingStringOnPC";
    cosSaveStringOnPC(oPC, sVarName, sToStore);

    object oPCWP = GetLocalObject(oPC, PCWP_VARNAME);
    if (GetIsObjectValid(oPCWP)) {
        sResult = GetLocalString(oPCWP, sVarName);
    }
    addTest (
        "cosSaveStringOnPC",
        "Sauvegarde d'une string sur le Waypoint de donnée d'un PJ.",
        sResult == sToStore
    );
    addTestInfo("Valeur stokée", sToStore);
    addTestInfo("Valeur retrouvée", sResult);
    addTestInfo("Nom de la variable", sVarName);
}

void ts_cosGetStringFromPC() {
    object oPC = OBJECT_SELF;

    string sResult;
    string sToGet = "STRING_TEST";
    string sVarName = "testGettingLocFromPC";

    object oPCWP = GetLocalObject(oPC, PCWP_VARNAME);
    if (GetIsObjectValid(oPCWP)) {
        SetLocalString(oPCWP, sVarName, sToGet);
    }

    sResult = cosGetStringFromPC(oPC, sVarName);

    addTest (
        "cosGetStringFromPC",
        "Récupération d'un entier du Waypoint de donnée d'un PJ.",
        sResult == sToGet
    );
    addTestInfo("Valeur stokée", sToGet);
    addTestInfo("Valeur retrouvée", sResult);
    addTestInfo("Nom de la variable", sVarName);
}

void ts_cosLoadPCIdentifiers() {
    object oPC = OBJECT_SELF;

    cosLoadPCIdentifiers(oPC);

    int iId = cosGetIntFromPC(oPC, PC_ID);
    int iIdAccount = cosGetIntFromPC(oPC, PC_ACCOUNT_ID);
    int iIdKey = cosGetIntFromPC(oPC, PC_KEY_ID);
    int iIdLinkKeyAccount = cosGetIntFromPC(oPC, PC_KEY_ACCOUNT_LINK_ID);

    addTest(
        "cosLoadPCIdentifiers",
        "Récupération des identifiants du personnage.",
        iId != SQL_ERROR && iIdAccount != SQL_ERROR && iIdKey != SQL_ERROR && iIdLinkKeyAccount != SQL_ERROR
    );
    addTestInfo("Id du personnage", IntToString(iId));
    addTestInfo("Id du compte", IntToString(iIdAccount));
    addTestInfo("Id de la clef CD", IntToString(iIdKey));
    addTestInfo("Id du lien (clef CD/Compte joueur)", IntToString(iIdLinkKeyAccount));
}

void ts_cosIsPCIdentifiersValid() {
    object oPC = OBJECT_SELF;

    cosLoadPCIdentifiers(oPC);

    int iId = cosGetIntFromPC(oPC, PC_ID);
    int iIdAccount = cosGetIntFromPC(oPC, PC_ACCOUNT_ID);
    int iIdKey = cosGetIntFromPC(oPC, PC_KEY_ID);
    int iIdLinkKeyAccount = cosGetIntFromPC(oPC, PC_KEY_ACCOUNT_LINK_ID);

    int iResA = (iId != SQL_ERROR && iIdAccount != SQL_ERROR && iIdKey != SQL_ERROR && iIdLinkKeyAccount != SQL_ERROR);
    int iResB = cosIsPCIdentifiersValid(oPC);
    addTest(
        "cosIsPCIdentifiersValid",
        "Vérification des identifiants du personnage.",
        iResA == TRUE && iResB == TRUE
    );
    addTestInfo("Identifiant tous != de SQL_ERROR ?", IntToString(iResA));
    addTestInfo("cosIsPCIdentifiersValid == TRUE ?", IntToString(iResB));
}

void ts_cosIsPCIdentifiersValid_WrongAccount() {
    object oPC = OBJECT_SELF;

    cosLoadPCIdentifiers(oPC);

    int iId = cosGetIntFromPC(oPC, PC_ID);

    // On change temporairement l'id de compte du personnage.
    int iSave = cosGetIntFromPC(oPC, PC_ACCOUNT_ID);
    int iIdWrongAccount = iSave + 5;
    cosSaveIntOnPC(oPC, PC_ACCOUNT_ID, iIdWrongAccount);
    iIdWrongAccount = cosGetIntFromPC(oPC, PC_ACCOUNT_ID);

    int iIdKey = cosGetIntFromPC(oPC, PC_KEY_ID);
    int iIdLinkKeyAccount = cosGetIntFromPC(oPC, PC_KEY_ACCOUNT_LINK_ID);

    int iResA = (iId != SQL_ERROR && iIdWrongAccount != SQL_ERROR && iIdKey != SQL_ERROR && iIdLinkKeyAccount != SQL_ERROR);
    int iResB = cosIsPCIdentifiersValid(oPC);
    addTest(
        "cosIsPCIdentifiersValid",
        "L'identifiant du compte trouvé ne correspond pas à l'identifiant de compte associé au personnage.",
        iResA == TRUE && iResB == FALSE
    );
    addTestInfo("Identifiant tous != de SQL_ERROR ?", IntToString(iResA));
    addTestInfo("cosIsPCIdentifiersValid == TRUE ?", IntToString(iResB));

    // On rétablit l'identifiant du compte joueur originel.
    cosSaveIntOnPC(oPC, PC_ACCOUNT_ID, iSave);
}

void ts_cosIsBan_PCIsBan() {
    object oPC = OBJECT_SELF;

    string sId = IntToString(cosGetIntFromPC(oPC, PC_ID));

    // On banni temporairement le personnage.
    int iBan = sqlEAFDSingleInt("SELECT "+BAN+" FROM "+TABLE_CHARACTERS+" WHERE "+ID+" = "+sId+";");
    if (iBan == FALSE) {
        sqlExecDirect("UPDATE "+TABLE_CHARACTERS+" SET "+BAN+" = 1 WHERE "+ID+" = "+sId+";");
    }

    int iRes = cosIsBan(oPC);
    addTest("cosIsBan", "Le personnage est effectivement banni.", iRes == TRUE);

    // On revient à la normale.
    if (iBan == FALSE) {
        sqlExecDirect("UPDATE "+TABLE_CHARACTERS+" SET "+BAN+" = 0 WHERE "+ID+" = "+sId+";");
    }
}

void main()
{
    // On exécute les tests.
    if (TEST_MODE && TS_COS_CHARACTER_ENABLED) {
        if (OBJECT_SELF == GetModule()) {
            // Test exécutés sur le module.
            printResult(TEST_SCRIPT_NAME);
        } else if (GetIsPC(OBJECT_SELF)) {
            if (GetArea(OBJECT_SELF) == OBJECT_INVALID) {
                DelayCommand(VALID_PJ_FREQUENCY_LOOP, ExecuteScript(TEST_SCRIPT_NAME, OBJECT_SELF));
                return;
            }

            ts_cosGetPCWaypoint();

            ts_cosSaveIntOnPC();
            ts_cosGetIntFromPC();

            ts_cosSaveLocationOnPC();
            ts_cosGetLocationFromPC();

            ts_cosSaveStringOnPC();
            ts_cosGetStringFromPC();

            ts_cosLoadPCIdentifiers();
            ts_cosIsPCIdentifiersValid();
            ts_cosIsPCIdentifiersValid_WrongAccount();

            ts_cosIsBan_PCIsBan();

            // On envoie les resultats.
            printResult(TEST_SCRIPT_NAME);
        }
    }
}
