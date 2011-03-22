/*********************************************************************/
/** Nom :              cose_clen_main
/** Date de cr�ation : 12/07/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lanc� � chaque fois qu'un client NWN se connecte.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "cosa_globalvar"
#include "cosa_pcmanips"
#include "cosa_log"

/************************** IMPLEMENTATIONS **************************/

void main() {
    // D�clarations de variables.
    object oPC;

    // On r�cup�re le personnage qui vient d'arriver.
    oPC = GetEnteringObject();

    // VALIDITE MODULE
    // On v�rifie que le module est bien initialis� et que le personnage est valide.
    if (!(cosGetGlobalInt(COS_MOD_IS_INIT_VARNAME) &&
          GetIsObjectValid(oPC) &&
          GetIsPC(oPC) &&
          (GetPCPublicCDKey(oPC) != ""))) {
        BootPC(oPC);
        return;
    }    

    // VALIDITE PERSONNAGE
    // On v�rifie que le personnage existe.
    if (cosIsNewPC(oPC)) {
        cosCreatePCId(oPC);
    }
    // On stocke la date de sa derni�re connexion.
    cosUpdateLastConnexion(oPC);
    // On log l'arriv�e du personnage.
    cosLogClientEnter(oPC);

    // POSITIONNEMENT PERSONNAGE
    // On d�place le personnage � la derni�re position connue.
    cosMovePCToStartLocation(oPC);
    // On lance la boucle de sauvegarde de position.
    cosSavePCLocationLoop(oPC);

    // SCRIPTS SYSTEMES
    ExecuteScript(COS_TCT_ON_CLIENT_ENTER, oPC);

    // SCRIPTS TESTS
    ExecuteScript("ts_cos_sys", oPC);
    ExecuteScript("ts_usu_sys", oPC);
    ExecuteScript("ts_cmd_sys", oPC);
    ExecuteScript("ts_sql_sys", oPC);

    // On affiche un message de bienvenue.
    FloatingTextStringOnCreature(COS_M_WELCOME_ONTO_SERVER+" "+GetName(oPC)+" !", oPC);
}
