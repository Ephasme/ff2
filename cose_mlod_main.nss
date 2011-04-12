/*********************************************************************/
/** Nom :              cose_mlod_main
/** Date de création : 12/07/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lancé au chargement du module.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "sqla_main"
#include "atha_main"
#include "cosa_globalvar"
#include "cosa_log"

/************************** IMPLEMENTATIONS **************************/

void main() {
    // Systèmes principaux.
    sqlInit(); // ==== SYSTEM SQL ==== //
    athInit(); // ==== SYSTEM ATH ==== //

    // On a terminé l'initialisation du module.
    cosSetGlobalInt(COS_MOD_IS_INIT_VARNAME, TRUE);

    // On log le démarrage du module en BDD.
    cosLogModuleLoad();
}
