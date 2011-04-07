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

#include "cosa_pcmanips"
#include "stda_testfuncs"

/************************** IMPLEMENTATIONS **************************/

void ts_cosGetPCId(object oPC) {

}

void ts_cosIsNewPC(object oPC) {

}

void ts_cosCreatePCId(object oPC) {

}

void ts_cosGetAccountId(object oPC) {

}

void ts_cosHasNewAccount(object oPC) {

}

void ts_cosCreateAccountId(object oPC) {

}

void ts_cosGetPublicCDKeyId(object oPC) {

}

void ts_cosHasNewPublicCDKey(object oPC) {

}

void ts_cosCreatePublicCDKeyId(object oPC) {

}

void ts_cosLinkAccountToKey(object oPC) {

}

void ts_cosGetPCWaypoint(object oPC) {

}

void ts_cosSaveLocalValue(object oPC) {

}

void ts_cosSetLocalInt(object oPC) {

}

void ts_cosGetLocalInt(object oPC) {

}

void ts_cosSetLocalLocation(object oPC) {

}

void ts_cosGetLocalLocation(object oPC) {

}

void ts_cosSetLocalString(object oPC) {

}

void ts_cosGetLocalString(object oPC) {

}

void ts_cosSavePCLocation(object oPC) {
  
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

            printResult(TS_COS_TITLE);
        } else {
            DelayCommand(TS_LOOP_DELAY, pv_do_OnClientEnter_Tests(oPC, iDepth++));
        }
    }
}

void main() {
    if (TS_TEST_MODE && TS_COS_SYS) {
        object oMe = OBJECT_SELF;
        if (oMe == GetModule()) {
            pv_do_OnModuleLoad_Tests();
        } else if (GetIsPC(oMe)) {
            pv_do_OnClientEnter_Tests(oMe);
        }
    }
}
