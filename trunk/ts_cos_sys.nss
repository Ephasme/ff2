/*********************************************************************/
/** Nom :              ts_cos_sys
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

                // #include "usuaf_strtokman"
            // #include "usuaf_locmanip"
            // #include "sqlaf_constants"
        // #include "sqlaf_main"
    // #include "sqlaf_charmanips"
    // #include "cosaf_constants"
#include "cosaf_pcmanips"

    // #include "usuaf_constants"
#include "usuaf_testfuncs"

/************************** IMPLEMENTATIONS **************************/

void ts_cosGetPCWaypoint(object oPC) {
    object oPCWP = cosGetPCWaypoint(oPC);
    addTest (
        "cosGetPCWaypoint",
        "Test de la récupération du waypoint de donnée de personnage.",
        GetIsObjectValid(oPCWP) && GetObjectType(oPCWP) == OBJECT_TYPE_WAYPOINT
    );
    addTestInfo("Nom du waypoint", GetName(oPCWP));
    addTestInfo("Nom du PJ", GetName(oPC));
}

void ts_cosSaveIntOnPC(object oPC) {
    int iResult;
    int iToStore = 50;
    string sVarName = "testSavingIntOnPC";
    cosSaveIntOnPC(oPC, sVarName, iToStore);

    object oPCWP = GetLocalObject(oPC, COS_WP_CHARDATA_VARNAME);
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

void ts_cosGetIntFromPC(object oPC) {
    int iResult;
    int iToGet = 51;
    string sVarName = "testGettingIntFromPC";

    object oPCWP = GetLocalObject(oPC, COS_WP_CHARDATA_VARNAME);
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

void ts_cosSaveLocationOnPC(object oPC) {
    location lResult;
    vector v;
    v.x = 5.0f; v.y = 6.0f; v.z = 0.0f;
    location lToStore = Location(GetAreaFromLocation(GetStartingLocation()), v, 90.0f);
    string sVarName = "testSavingLocOnPC";
    cosSaveLocationOnPC(oPC, sVarName, lToStore);

    object oPCWP = GetLocalObject(oPC, COS_WP_CHARDATA_VARNAME);
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

void ts_cosGetLocationFromPC(object oPC) {
    location lResult;
    vector v;
    v.x = 5.0f; v.y = 6.0f; v.z = 0.0f;
    location lToGet = Location(GetAreaFromLocation(GetStartingLocation()), v, 90.0f);
    string sVarName = "testGettingLocFromPC";

    object oPCWP = GetLocalObject(oPC, COS_WP_CHARDATA_VARNAME);
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

void ts_cosSaveStringOnPC(object oPC) {
    string sResult;
    string sToStore = "STRING_TEST";
    string sVarName = "testSavingStringOnPC";
    cosSaveStringOnPC(oPC, sVarName, sToStore);

    object oPCWP = GetLocalObject(oPC, COS_WP_CHARDATA_VARNAME);
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

void ts_cosGetStringFromPC(object oPC) {
    string sResult;
    string sToGet = "STRING_TEST";
    string sVarName = "testGettingLocFromPC";

    object oPCWP = GetLocalObject(oPC, COS_WP_CHARDATA_VARNAME);
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

void ts_cosLoadPCIdentifiers(object oPC) {
    cosLoadPCIdentifiers(oPC);

    int iId = cosGetIntFromPC(oPC, COS_PC_ID);
    int iIdAccount = cosGetIntFromPC(oPC, COS_PC_ACCOUNT_ID);
    int iIdKey = cosGetIntFromPC(oPC, COS_PC_KEY_ID);
    int iIdLinkKeyAccount = cosGetIntFromPC(oPC, COS_PC_KEY_ACCOUNT_LINK_ID);

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

void ts_cosIsPCIdentifiersValid(object oPC) {
    cosLoadPCIdentifiers(oPC);

    int iId = cosGetIntFromPC(oPC, COS_PC_ID);
    int iIdAccount = cosGetIntFromPC(oPC, COS_PC_ACCOUNT_ID);
    int iIdKey = cosGetIntFromPC(oPC, COS_PC_KEY_ID);
    int iIdLinkKeyAccount = cosGetIntFromPC(oPC, COS_PC_KEY_ACCOUNT_LINK_ID);

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

void ts_cosIsPCIdentifiersValid_WrongAccount(object oPC) {
    cosLoadPCIdentifiers(oPC);

    int iId = cosGetIntFromPC(oPC, COS_PC_ID);

    // On change temporairement l'id de compte du personnage.
    int iSave = cosGetIntFromPC(oPC, COS_PC_ACCOUNT_ID);
    int iIdWrongAccount = iSave + 5;
    cosSaveIntOnPC(oPC, COS_PC_ACCOUNT_ID, iIdWrongAccount);
    iIdWrongAccount = cosGetIntFromPC(oPC, COS_PC_ACCOUNT_ID);

    int iIdKey = cosGetIntFromPC(oPC, COS_PC_KEY_ID);
    int iIdLinkKeyAccount = cosGetIntFromPC(oPC, COS_PC_KEY_ACCOUNT_LINK_ID);

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
    cosSaveIntOnPC(oPC, COS_PC_ACCOUNT_ID, iSave);
}

void ts_cosIsBan_PCIsBan(object oPC) {
    string sId = IntToString(cosGetIntFromPC(oPC, COS_PC_ID));

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

/* Private Function */
void pv_do_OnModuleLoad_Tests() {

    // INSERER ICI LES TESTS A FAIRE LORS DE L'EVENEMENT ON_MODULE_LOAD.

    printResult(TS_COS_TITLE);
}

/* Private Function */
void pv_do_OnClientEnter_Tests(object oPC, int iDepth = 0) {
    if (iDepth < TS_LOOP_MAX) {
        if (GetIsObjectValid(GetArea(oPC))) {

            ts_cosGetPCWaypoint(oPC);

            ts_cosSaveIntOnPC(oPC);
            ts_cosGetIntFromPC(oPC);

            ts_cosSaveLocationOnPC(oPC);
            ts_cosGetLocationFromPC(oPC);

            ts_cosSaveStringOnPC(oPC);
            ts_cosGetStringFromPC(oPC);

            ts_cosLoadPCIdentifiers(oPC);
            ts_cosIsPCIdentifiersValid(oPC);
            ts_cosIsPCIdentifiersValid_WrongAccount(oPC);

            ts_cosIsBan_PCIsBan(oPC);

            printResult(TS_COS_TITLE);
        } else {
            DelayCommand(TS_LOOP_DELAY, pv_do_OnClientEnter_Tests(oPC, iDepth++));
        }
    }
}

void main() {
    if (TEST_MODE && TS_COS_SYS) {
        object oMe = OBJECT_SELF;
        if (oMe == GetModule()) {
            pv_do_OnModuleLoad_Tests();

        } else if (GetIsPC(oMe)) {
            pv_do_OnClientEnter_Tests(oMe);
        }
    }
}
