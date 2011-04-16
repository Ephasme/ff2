/*********************************************************************/
/** Nom :              cose_clen_main
/** Date de création : 12/07/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lancé à chaque fois qu'un client NWN se connecte.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "cosa_globalvar"
#include "cosa_pcmanips"
#include "cosa_log"

/************************** IMPLEMENTATIONS **************************/

void main() {
    // Déclarations de variables.
    object oPC;

    // On récupère le personnage qui vient d'arriver.
    oPC = GetEnteringObject();

    // VALIDITE MODULE
    // On vérifie que le module est bien initialisé et que le personnage est valide.
    if (!(cosGetGlobalInt(COS_MOD_IS_INIT_VARNAME) &&
          GetIsObjectValid(oPC) &&
          GetIsPC(oPC) &&
          (GetPCPublicCDKey(oPC) != ""))) {
        BootPC(oPC);
        return;
    }

    // VALIDITE PERSONNAGE
    // On vérifie que le personnage existe.
    if (cosIsNewPC(oPC)) {
        cosCreatePCId(oPC);
    }
    // On stocke la date de sa dernière connexion.
    cosUpdateLastConnexion(oPC);
    // On log l'arrivée du personnage.
    cosLogClientEnter(oPC);

    // EQUIPEMENT STANDARD
    cosGivePlayerTools(oPC);

    // POSITIONNEMENT PERSONNAGE
    // On démarre la gestion du positionnement du personnage.
    cosStartLocationManager(oPC);

    // SCRIPTS SYSTEMES

    // SCRIPTS TESTS

    // On affiche un message de bienvenue.
    FloatingTextStringOnCreature(COS_M_WELCOME_ONTO_SERVER+" "+GetName(oPC)+" !", oPC);
}
