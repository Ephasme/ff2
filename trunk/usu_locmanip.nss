/*********************************************************************/
/** Nom :              usu_locmanip
/** Date de création : 15/08/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script regroupant les fonctions de manipulation des Locations.
/*********************************************************************/

/***************************** INCLUDES ******************************/

    // #include "usu_constants"
#include "usu_stringtokman"

/***************************** PROTOTYPES ****************************/

// TODO:Faire les prototypes
string usuLocationToString(location lLocation);
location usuStringToLocation(string sLocation);

/************************** IMPLEMENTATIONS **************************/

string usuLocationToString(location lLocation) {
    string sAreaTag = GetTag(GetAreaFromLocation(lLocation));
    vector vVect = GetPositionFromLocation(lLocation);
    float fFacing = GetFacingFromLocation(lLocation);
    string sResult = LOCATION_TOKEN+sAreaTag+
                     LOCATION_TOKEN+FloatToString(vVect.x, 0, 3)+
                     LOCATION_TOKEN+FloatToString(vVect.y, 0, 3)+
                     LOCATION_TOKEN+FloatToString(vVect.z, 0, 3)+
                     LOCATION_TOKEN+FloatToString(fFacing, 0, 3)+
                     LOCATION_TOKEN;
    return sResult;
}

location usuStringToLocation(string sLocation) {
    int iTokLength = GetStringLength(LOCATION_TOKEN);

    int iAreaTagPos = usuGetFirstTokenPosition(sLocation, LOCATION_TOKEN);
    int iXPos = usuGetNextTokenPosition(sLocation, LOCATION_TOKEN, LOCATION_TOKEN, iAreaTagPos);
    int iYPos = usuGetNextTokenPosition(sLocation, LOCATION_TOKEN, LOCATION_TOKEN, iXPos);
    int iZPos = usuGetNextTokenPosition(sLocation, LOCATION_TOKEN, LOCATION_TOKEN, iYPos);
    int iFacingPos = usuGetNextTokenPosition(sLocation, LOCATION_TOKEN, LOCATION_TOKEN, iZPos);
    int iEndPos = usuGetNextTokenPosition(sLocation, LOCATION_TOKEN, LOCATION_TOKEN, iFacingPos);

    // On récupère le tag de l'aire.
    string sTag = usuGetStringBetweenTokens(sLocation, iAreaTagPos, iTokLength, iXPos);

    // On crée le vecteur.
    vector vVect;
    vVect.x = StringToFloat(usuGetStringBetweenTokens(sLocation, iXPos, iTokLength, iYPos));
    vVect.y = StringToFloat(usuGetStringBetweenTokens(sLocation, iYPos, iTokLength, iZPos));
    vVect.z = StringToFloat(usuGetStringBetweenTokens(sLocation, iZPos, iTokLength, iFacingPos));

    // On récupère le facing.
    float fFacing;
    fFacing = StringToFloat(usuGetStringBetweenTokens(sLocation, iFacingPos, iTokLength, iEndPos));

    // On crée la location.
    location lResult = Location(GetObjectByTag(sTag), vVect, fFacing);
    return lResult;
}
