/*********************************************************************/
/** Nom :              cos_ev_onmodload
/** Date de cr�ation : 12/07/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lanc� au chargement du module.
/*********************************************************************/

/***************************** INCLUDES ******************************/

    // #include "usu_in_location"
#include "sql_in_basis"

    // #include "cos_in_config"
#include "cos_in_globalvar"

/************************** IMPLEMENTATIONS **************************/

void main() {
    /* On active tous les syst�mes du jeu. */

    // Syst�mes principaux.
    sqlInit(); // Syst�me de connection � la base de donn�e.

    // Tests.
    ExecuteScript("ts_usu_strings", OBJECT_SELF); // Test des fonctions de manipulation de cha�ne.
    ExecuteScript("ts_usu_location", OBJECT_SELF); // Test des fonctions de location.

    ExecuteScript("ts_sql_basis", OBJECT_SELF); // Test des fonctions SQL de base.
    ExecuteScript("ts_scm_basis", OBJECT_SELF); // Test des fonctions de gestion des commandes.

    // On a termin� l'initialisation du module.
    cosSetGlobalInt(GV_MODULE_INIT_IS_OK, TRUE);
}
