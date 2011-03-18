/*********************************************************************/
/** Nom :              cosef_mlod_main
/** Date de création : 12/07/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lancé au chargement du module.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "sqlaf_main"
#include "cosaf_globalvar"
#include "cosaf_log"

/************************** IMPLEMENTATIONS **************************/

void main() {
    // Systèmes principaux.
    sqlInit(); // Système de connection à la base de donnée.

    // Tests.
    ExecuteScript("ts_cos_sys", OBJECT_SELF);
    ExecuteScript("ts_usu_sys", OBJECT_SELF);
    ExecuteScript("ts_cmd_sys", OBJECT_SELF);
    ExecuteScript("ts_sql_sys", OBJECT_SELF);

    // On a terminé l'initialisation du module.
    cosSetGlobalInt(COS_MOD_IS_INIT_VARNAME, TRUE);
    
    // On log le démarrage du module en BDD.
    cosLogModuleLoad();
}
