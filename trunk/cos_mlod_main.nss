/*********************************************************************/
/** Nom :              cos_mlod_main
/** Date de cr�ation : 12/07/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lanc� au chargement du module.
/*********************************************************************/

/***************************** INCLUDES ******************************/

    // #include "usu_locmanip"
#include "sql_main"

    // #include "cos_config"
#include "cos_globalvar"

/************************** IMPLEMENTATIONS **************************/

void main() {
    /* On active tous les syst�mes du jeu. */

    // Syst�mes principaux.
    sqlInit(); // Syst�me de connection � la base de donn�e.

    // Tests.
    ExecuteScript("ts_usu_sys", OBJECT_SELF); // Test des fonctions usuelles.

    // On a termin� l'initialisation du module.
    cosSetGlobalInt(COS_MODULE_IS_INIT, TRUE);
}
