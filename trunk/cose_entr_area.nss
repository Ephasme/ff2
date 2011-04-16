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
    // On r�cup�re les donn�es et on les stock.
    object oObj = GetEnteringObject();
    cosSaveOnEnter(oObj);

    // On r�cup�re l'aire.
    object oArea = GetArea(oObj);
    // On teste si les donn�es sont toujours valides.
    if (GetIsPC(oObj) && GetIsObjectValid(oArea)) {
        string sAreaTag = GetTag(oArea);
        string sLastAreaTag = cosGetLocalString(oObj, COS_PC_LASTAREA_TAG);
        if (sAreaTag != "" && sAreaTag != sLastAreaTag) {
            // La nouvelle map devient l'ancienne.
            cosSetLocalString(oObj, COS_PC_LASTAREA_TAG, sAreaTag);
        }
        // On log la transition.
        cosLogTransition(oObj, sLastAreaTag, sAreaTag);
    }
}
