/*********************************************************************/
/** Nom :              cosef_mlod_main
/** Date de cr�ation : 12/07/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lanc� au chargement du module.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "sqlaf_main"
#include "cosaf_globalvar"
#include "cosaf_log"

/************************** IMPLEMENTATIONS **************************/

void main() {
    // Syst�mes principaux.
    sqlInit(); // Syst�me de connection � la base de donn�e.

    // Tests.
    ExecuteScript("ts_cos_sys", OBJECT_SELF);
    ExecuteScript("ts_usu_sys", OBJECT_SELF);
    ExecuteScript("ts_cmd_sys", OBJECT_SELF);
    ExecuteScript("ts_sql_sys", OBJECT_SELF);

    // On a termin� l'initialisation du module.
    cosSetGlobalInt(COS_MOD_IS_INIT_VARNAME, TRUE);
    
    // On log le d�marrage du module en BDD.
    cosLogModuleLoad();
}
