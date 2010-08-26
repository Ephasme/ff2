/*********************************************************************/
/** Nom :              cos_ev_onmodload
/** Date de création : 12/07/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lancé au chargement du module.
/*********************************************************************/

/***************************** INCLUDES ******************************/

    // #include "usu_in_location"
#include "sql_in_basis"

    // #include "cos_in_config"
#include "cos_in_globalvar"

/************************** IMPLEMENTATIONS **************************/

void main() {
    /* On active tous les systèmes du jeu. */

    // Systèmes principaux.
    sqlInit(); // Système de connection à la base de donnée.

    // Tests.
    ExecuteScript("ts_usu_strings", OBJECT_SELF); // Test des fonctions de manipulation de chaîne.
    ExecuteScript("ts_usu_location", OBJECT_SELF); // Test des fonctions de location.

    ExecuteScript("ts_sql_basis", OBJECT_SELF); // Test des fonctions SQL de base.
    ExecuteScript("ts_scm_basis", OBJECT_SELF); // Test des fonctions de gestion des commandes.

    // On a terminé l'initialisation du module.
    cosSetGlobalInt(GV_MODULE_INIT_IS_OK, TRUE);
}
