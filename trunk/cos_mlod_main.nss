/*********************************************************************/
/** Nom :              cos_mlod_main
/** Date de cr ation : 12/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lanc‚ au chargement du module.
/*********************************************************************/

/***************************** INCLUDES ******************************/

            // #include "usu_constants"
        // #include "usu_stringtokman"
    // #include "usu_locmanip"
    // #include "sql_constants"
#include "sql_main"

    // #include "cos_constants"
#include "cos_globalvar"

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
    cosSetGlobalInt(COS_MODULE_IS_INIT, TRUE);
}
