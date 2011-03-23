/*********************************************************************/
/** Nom :              cose_entr_area
/** Date de cr�ation : 22/03/2011
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script lanc� � chaque fois qu'un personnage entre dans une
/**   zone.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "cosa_log"
#include "cosa_pcmanips"
#include "cosa_globalvar"

/************************** IMPLEMENTATIONS **************************/

void main() {
/*DEBUG*/ dbgChangeSource("cose_entr_area.main");
/*DEBUG*/ dbgIncreaseIdentLevel();
    // On r�cup�re les donn�es et on les stock.
    object oObj = GetEnteringObject();
/*DEBUG*/ dbgWrite("oObj="+GetName(oObj));
    cosSaveOnEnter(oObj);
/*DEBUG*/ dbgWrite("onEnterObject saved = "+GetName(cosGetOnEnter()));

    // ==== SYTEME AFK =================================================
/*DEBUG*/ dbgWrite("ExecuteScript '"+COS_AFK_ON_ENTER_AREA+"'");
    ExecuteScript(COS_AFK_ON_ENTER_AREA, oObj);
    
    // On r�cup�re l'aire.
    object oArea = GetArea(oObj);
/*DEBUG*/ dbgWrite("ooArea="+GetName(oArea));
    // On teste si les donn�es sont toujours valides.
    if (GetIsPC(oObj) && GetIsObjectValid(oArea)) {
/*DEBUG*/ dbgIncreaseIdentLevel();
/*DEBUG*/ dbgWrite("GetIsPC(oObj) && GetIsObjectValid(oArea)=true");
        string sAreaTag = GetTag(oArea);
        string sLastAreaTag = cosGetLocalString(oObj, COS_PC_LASTAREA_TAG);
/*DEBUG*/ dbgWrite("COS_PC_LASTAREA_TAG (before)="+sLastAreaTag);
        if (sAreaTag != sLastAreaTag) {
/*DEBUG*/ dbgIncreaseIdentLevel();
/*DEBUG*/ dbgWrite("sAreaTag != sLastAreaTag=true");
            // La nouvelle map devient l'ancienne.
            cosSetLocalString(oObj, COS_PC_LASTAREA_TAG, sAreaTag);
/*DEBUG*/ dbgWrite("COS_PC_LASTAREA_TAG (after)="+cosGetLocalString(oObj, COS_PC_LASTAREA_TAG));
        }
/*DEBUG*/ dbgDecreaseIdentLevel();
        // On log la transition.
        cosLogTransition(oObj, sLastAreaTag, sAreaTag);
/*DEBUG*/ dbgWrite("LogTransition");
    }
/*DEBUG*/ dbgDecreaseIdentLevel();
}
