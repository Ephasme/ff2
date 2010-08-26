/*********************************************************************/
/** Nom :              ts_sql_character
/** Date de création : 24/08/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**       Script de test des fonctions de manipulation des données SQL
/**    des personnages joueurs.
/*********************************************************************/

/***************************** INCLUDES ******************************/

        // #include "usu_in_location"
    // #include "sql_in_basis"
#include "sql_in_character"

#include "usu_in_tests"

/***************************** CONSTANTES ****************************/

// Nom du script de test.
const string TEST_SCRIPT_NAME = "ts_sql_character";

// Fréquence de la boucle d'attente de PJ valide.
const float VALID_PJ_FREQUENCY_LOOP = 2.0f;

// Constante à désactiver pour supprimer cette série de test des logs.
const int TS_SQL_CHARACTER_ENABLED = TRUE;

/***************************** VARIABLES *****************************/

/************************** IMPLEMENTATIONS **************************/

void ts_sqlGetAccountId() {
    object oPC = OBJECT_SELF;
    int iRes = sqlGetAccountId(GetPCPlayerName(oPC));
    addTest("sqlGetAccountId", "Récupération de l'identifiant du compte joueur.", iRes != SQL_ERROR);
    addTestInfo("Identifiant du compte", IntToString(iRes));
    addTestInfo("Nom du compte", GetPCPlayerName(oPC));
}

void ts_sqlGetPCId() {
    object oPC = OBJECT_SELF;
    string sAccount = GetPCPlayerName(oPC);
    string sName = GetName(oPC);
    int iAccountId = sqlGetAccountId(sAccount);
    int iPCId = sqlGetPCId(sName, iAccountId);
    addTest("sqlGetPCId", "Récupération de l'identifiant du personnage.", iPCId != SQL_ERROR);
    addTestInfo("Identifiant du personnage", IntToString(iPCId));
    addTestInfo("Identifiant du compte", IntToString(iAccountId));
    addTestInfo("Nom du personnage", sName);
    addTestInfo("Compte du joueur", sAccount);
}

void ts_sqlGetKeyId() {
    object oPC = OBJECT_SELF;
    string sAccount = GetPCPlayerName(oPC);
    string sKey = GetPCPublicCDKey(oPC);
    int iAccountId = sqlGetAccountId(sAccount);
    int iKeyId = sqlGetKeyId(sKey, iAccountId);
    addTest("sqlGetKeyId", "Récupération de l'identifiant de la clef CD.", iKeyId != SQL_ERROR);
    addTestInfo("Identifiant de la clef", IntToString(iKeyId));
    addTestInfo("Identifiant du compte", IntToString(iAccountId));
    addTestInfo("Clef du joueur", sKey);
    addTestInfo("Compte du joueur", sAccount);
}

void ts_sqlGetCDKeyAccountLinkId() {
    object oPC = OBJECT_SELF;
    string sAccount = GetPCPlayerName(oPC);
    string sKey = GetPCPublicCDKey(oPC);
    int iAccountId = sqlGetAccountId(sAccount);
    int iKeyId = sqlGetKeyId(sKey, iAccountId);
    int iLinkId = sqlGetCDKeyAccountLinkId(iKeyId, iAccountId);
    addTest("sqlGetCDKeyAccountLinkId", "Récupération d'un identifiant de couple (clef CD/Compte joueur).", iLinkId != SQL_ERROR);
    addTestInfo("Identifiant du couple (clef CD/Compte joueur)", IntToString(iLinkId));
    addTestInfo("Identifiant du compte", IntToString(iAccountId));
    addTestInfo("Identifiant de la clef", IntToString(iKeyId));
    addTestInfo("Clef du joueur", sKey);
    addTestInfo("Compte du joueur", sAccount);
}

void main()
{
    // On exécute les tests.
    if (TEST_MODE && TS_SQL_CHARACTER_ENABLED) {
        if (OBJECT_SELF == GetModule()) {
            // Test exécutés sur le module.
            printResult(TEST_SCRIPT_NAME);
        } else if (GetIsPC(OBJECT_SELF)) {
            if (GetArea(OBJECT_SELF) == OBJECT_INVALID) {
                DelayCommand(VALID_PJ_FREQUENCY_LOOP, ExecuteScript(TEST_SCRIPT_NAME, OBJECT_SELF));
                return;
            }

            ts_sqlGetAccountId();
            ts_sqlGetPCId();
            ts_sqlGetKeyId();
            ts_sqlGetCDKeyAccountLinkId();

            // On envoie les resultats.
            printResult(TEST_SCRIPT_NAME);
        }
    }
}

