/*********************************************************************/
/** Nom :              afke_entr_area.nss
/** Date de cr�ation : 22/03/2011
/** Version :          1.0.0
/** Createur :         Loup Peluso
/***************************** ChangeLog *****************************/
/** V1.0.0 :
/**     Script � mettre dans l'�v�nement OnEnter de la map cible du
/**  syst�me de mise en mode AFK.
/*********************************************************************/

#include "afka_constants"
#include "cosa_globalvar"

/************************** IMPLEMENTATIONS **************************/

// TODO : Syst�me d'arriv�e dans la map afk � faire.
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

