/*********************************************************************/
/** Nom :              cose_mlod_main
/** Date de cr�ation : 12/07/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lanc� au chargement du module.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "sqla_main"
#include "atha_main"
#include "cosa_globalvar"
#include "cosa_log"

/************************** IMPLEMENTATIONS **************************/

void main() {
    // Syst�mes principaux.
    sqlInit(); // ==== SYSTEM SQL ==== //
    athInit(); // ==== SYSTEM ATH ==== //

    // On a termin� l'initialisation du module.
    cosSetGlobalInt(COS_MOD_IS_INIT_VARNAME, TRUE);

    // On log le d�marrage du module en BDD.
    cosLogModuleLoad();
}
