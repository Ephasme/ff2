/*********************************************************************/
/** Nom :              afke_entr_area.nss
/** Date de création : 22/03/2011
/** Version :          1.0.0
/** Createur :         Loup Peluso
/***************************** ChangeLog *****************************/
/** V1.0.0 :
/**     Script à mettre dans l'évènement OnEnter de la map cible du
/**  système de mise en mode AFK.
/*********************************************************************/

#include "afka_constants"
#include "cosa_globalvar"

/************************** IMPLEMENTATIONS **************************/

// TODO : Système d'arrivée dans la map afk à faire.
void main() {
    /*DEBUG*/ PrintString("=> (afke_entr_area)"); 
    object oObj = cosGetOnEnter();
    /*DEBUG*/ PrintString("  cosGetOnEnter()="+GetName(oObj)); 
    string sAreaTag = GetTag(GetArea(oObj));
    /*DEBUG*/ PrintString("  AreaTag="+sAreaTag); 
    if (AFK_SYSTEM_ENABLED && sAreaTag == AFK_AREA_TAG) {
        /*DEBUG*/ PrintString("    AFK_SYSTEM_ENABLED && sAreaTag == AFK_AREA_TAG=true"); 
        /*DEBUG*/ PrintString("    Enclencher mode AFK"); 
    }
    /*DEBUG*/ PrintString("<= (afke_entr_area)"); 
}

