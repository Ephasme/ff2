/*********************************************************************/
/** Nom :              cosef_mlod_main
/** Date de création : 12/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lanc‚ au chargement du module.
/*********************************************************************/

/***************************** INCLUDES ******************************/

            // #include "usuaf_constants"
        // #include "usuaf_strtokman"
    // #include "usuaf_locmanip"
    // #include "sqlaf_constants"
#include "sqlaf_main"

    // #include "cosaf_constants"
#include "cosaf_globalvar"

/************************** IMPLEMENTATIONS **************************/

void main() {
    // Syst‡mes principaux.
    sqlInit(); // Syst‡me de connection   la base de donn‚e.

    // Tests.
    ExecuteScript("ts_cos_sys", OBJECT_SELF);
    ExecuteScript("ts_usu_sys", OBJECT_SELF);
    ExecuteScript("ts_scm_sys", OBJECT_SELF);
    ExecuteScript("ts_sql_sys", OBJECT_SELF);

    // On a termin‚ l'initialisation du module.
    cosSetGlobalInt(COS_MOD_IS_INIT_VARNAME, TRUE);
}
