/*********************************************************************/
/** Nom :              stda_locmanips
/** Date de cr�ation : 15/08/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script regroupant les fonctions de manipulation des Locations.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "stda_strtokman"

/***************************** PROTOTYPES ****************************/

// TODO : Faire les prototypes
string stdLocationToString(location lLocation);
location stdStringToLocation(string sLocation);

/************************** IMPLEMENTATIONS **************************/

string stdLocationToString(location lLocation) {
    string sAreaTag = GetTag(GetAreaFromLocation(lLocation));
    vector vVect = GetPositionFromLocation(lLocation);
    float fFacing = GetFacingFromLocation(lLocation);
    string sResult = STD_LOCATION_TOKEN+sAreaTag+
                     STD_LOCATION_TOKEN+FloatToString(vVect.x, 0, 3)+
                     STD_LOCATION_TOKEN+FloatToString(vVect.y, 0, 3)+
                     STD_LOCATION_TOKEN+FloatToString(vVect.z, 0, 3)+
                     STD_LOCATION_TOKEN+FloatToString(fFacing, 0, 3)+
                     STD_LOCATION_TOKEN;
    return sResult;
}

location stdStringToLocation(string sLocation) {
    int iTokLength = GetStringLength(STD_LOCATION_TOKEN);

    int iAreaTagPos = stdGetFirstTokenPosition(sLocation, STD_LOCATION_TOKEN);
    int iXPos = stdGetNextTokenPosition(sLocation, STD_LOCATION_TOKEN, STD_LOCATION_TOKEN, iAreaTagPos);
    int iYPos = stdGetNextTokenPosition(sLocation, STD_LOCATION_TOKEN, STD_LOCATION_TOKEN, iXPos);
    int iZPos = stdGetNextTokenPosition(sLocation, STD_LOCATION_TOKEN, STD_LOCATION_TOKEN, iYPos);
    int iFacingPos = stdGetNextTokenPosition(sLocation, STD_LOCATION_TOKEN, STD_LOCATION_TOKEN, iZPos);
    int iEndPos = stdGetNextTokenPosition(sLocation, STD_LOCATION_TOKEN, STD_LOCATION_TOKEN, iFacingPos);

    // On r�cup�re le tag de l'aire.
    string sTag = stdGetStringBetweenTokens(sLocation, iAreaTagPos, iTokLength, iXPos);

    // On cr�e le vecteur.
    vector vVect;
    vVect.x = StringToFloat(stdGetStringBetweenTokens(sLocation, iXPos, iTokLength, iYPos));
    vVect.y = StringToFloat(stdGetStringBetweenTokens(sLocation, iYPos, iTokLength, iZPos));
    vVect.z = StringToFloat(stdGetStringBetweenTokens(sLocation, iZPos, iTokLength, iFacingPos));

    // On r�cup�re le facing.
    float fFacing;
    fFacing = StringToFloat(stdGetStringBetweenTokens(sLocation, iFacingPos, iTokLength, iEndPos));

    // On cr�e la location.
    location lResult = Location(GetObjectByTag(sTag), vVect, fFacing);
    return lResult;
}