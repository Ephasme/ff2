/*********************************************************************/
/** Nom :              cos_mlod_main
/** Date de création : 12/07/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lancé au chargement du module.
/*********************************************************************/

/***************************** INCLUDES ******************************/

    // #include "usu_locmanip"
#include "sql_main"

    // #include "cos_config"
#include "cos_globalvar"

/************************** IMPLEMENTATIONS **************************/

void main() {
    /* On active tous les systèmes du jeu. */

    // Systèmes principaux.
    sqlInit(); // Système de connection à la base de donnée.

    // Tests.
    ExecuteScript("ts_usu_sys", OBJECT_SELF); // Test des fonctions usuelles.

    // On a terminé l'initialisation du module.
    cosSetGlobalInt(COS_MODULE_IS_INIT, TRUE);
}
