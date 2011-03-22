/*********************************************************************/
/** Nom :              cose_entr_area
/** Date de création : 22/03/2011
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lancé à chaque fois qu'un personnage entre dans une
/**   zone.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "cosa_log"
#include "cosa_pcmanips"
#include "cosa_globalvar"

/************************** IMPLEMENTATIONS **************************/

void main() {
    /*DEBUG*/ PrintString("=> (cose_entr_area)");

    // On récupère les données et on les stock.
    object oObj = GetEnteringObject();
    /*DEBUG*/ PrintString("  oObj="+GetName(oObj));
    cosSaveOnEnter(oObj);
    /*DEBUG*/ PrintString("  OnEnterObject saved = "+GetName(cosGetOnEnter()));

    // ==== SYTEME AFK =================================================
    /*DEBUG*/ PrintString("  ExecuteScript '"+COS_AFK_ON_ENTER_AREA+"'");
    ExecuteScript(COS_AFK_ON_ENTER_AREA, oObj);
    
    // On récupère l'aire.
    object oArea = GetArea(oObj);
    /*DEBUG*/ PrintString("  ooArea="+GetName(oArea));
    // On teste si les données sont toujours valides.
    if (GetIsPC(oObj) && GetIsObjectValid(oArea)) {
        /*DEBUG*/ PrintString("  GetIsPC(oObj) && GetIsObjectValid(oArea)=true");
        string sAreaTag = GetTag(oArea);
        string sLastAreaTag = cosGetLocalString(oObj, COS_PC_LASTAREA_TAG);
        /*DEBUG*/ PrintString("    COS_PC_LASTAREA_TAG (before)="+sLastAreaTag);
        if (sAreaTag != sLastAreaTag) {
            /*DEBUG*/ PrintString("        sAreaTag != sLastAreaTag=true");
            // La nouvelle map devient l'ancienne.
            cosSetLocalString(oObj, COS_PC_LASTAREA_TAG, sAreaTag);
            /*DEBUG*/ PrintString("        COS_PC_LASTAREA_TAG (after)="+cosGetLocalString(oObj, COS_PC_LASTAREA_TAG));
        }
        // On log la transition.
        cosLogTransition(oObj, sLastAreaTag, sAreaTag);
        /*DEBUG*/ PrintString("    LogTransition");
    }

    /*DEBUG*/ PrintString("<= (cose_entr_area)");
}
