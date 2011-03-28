/*********************************************************************/
/** Nom :              atha_main.ss
/** Date de création : 26/03/2011
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script regroupant les fonctions de permission.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "sqla_main"
#include "atha_constants"
#include "cosa_pcmanips"

/***************************** PROTOTYPES ****************************/

// TODO (Anael) : Documenter les fonctions.
int athIsAllowed(string sAuth, object oPC);
void athFlush();

/************************** IMPLEMENTATIONS **************************/

// TODO : à poursuivre.

int athIsAllowed(string sAuth, object oPC) {
    int iAuth = sqlEAFDSingleInt("SELECT MAX("+ATH_SQLF_AUTH_TYPE+") FROM "+ATH_SQLT_GLOBAL+" g, "+ATH_SQLT_AUTH+" a, "+COS_SQLT_CHAR+" c WHERE a."+ATH_SQLF_NAME+" = "+sqlQuote(sAuth)+" AND a."+ATH_SQLF_ID+" = g."+ATH_SQLF_ID_AUTH+" AND c."+ATH_SQLF_ID+" = g."+ATH_SQLF_ID_CHAR+";");
    if (iAuth == ATH_FORBIDDEN || iAuth == ATH_RESTRICTED) {
        return FALSE;
    }
    return TRUE;
}

void athFlush() {
    sqlExecDirect("DROP TABLE IF EXISTS "+ATH_SQLT_GLOBAL+";");
    sqlExecDirect("CREATE TABLE "+ATH_SQLT_GLOBAL+" AS SELECT * FROM ("+
        "SELECT "+ATH_SQLF_AUTH_TYPE+", a."+ATH_SQLF_ID+" AS "+ATH_SQLF_ID_AUTH+", c."+ATH_SQLF_ID+" AS "+ATH_SQLF_ID_CHAR+" "+
        "FROM "+ATH_SQLT_AUTH+" a, "+ATH_SQLT_AUTH_TO_CHAR+" ac, "+COS_SQLT_CHAR+" c "+
        "WHERE ac."+ATH_SQLF_ID_CHAR+" = c."+ATH_SQLF_ID+" "+
        "AND ac."+ATH_SQLF_ID_AUTH+" = a."+ATH_SQLF_ID+" "+
                  "UNION "+
        "SELECT ag."+ATH_SQLF_AUTH_TYPE+" as "+ATH_SQLF_AUTH_TYPE+", ag."+ATH_SQLF_ID_AUTH+" as "+ATH_SQLF_ID_AUTH+", cg."+ATH_SQLF_ID_CHAR+" as "+ATH_SQLF_ID_CHAR+" "+
        "FROM "+ATH_SQLT_AUTH_TO_GROUP_AUTH+" ag, "+ATH_SQLT_CHAR_TO_GROUP+" cg "+
        "WHERE ag."+ATH_SQLF_ID_GROUP+" = cg."+ATH_SQLF_ID_GROUP+") AS req;");
    sqlExecDirect("ALTER TABLE "+ATH_SQLT_GLOBAL+" ADD PRIMARY KEY("+ATH_SQLF_AUTH_TYPE+","+ATH_SQLF_ID_AUTH+","+ATH_SQLF_ID_CHAR+"), ENGINE=MyISAM;");
}
