/*********************************************************************/
/** Nom :              usua_strtokman
/** Date de cr�ation : 21/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les fonctions relatives � la gestion des
/**    chaines de caract�res.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "usua_constants"

/***************************** PROTOTYPES ****************************/

// DEF IN "usua_strtokman"
// Fonction qui renvoie la position du dernier d�limiteur dans une chaine.
//   > string sStr - Cha�ne � scanner.
//   > string sTok - D�limiteur.
//   o int - Position du dernier D�limiteur trouv� ou USU_TOKEN_POSITION_ERROR si rien n'a �t� trouv�.
int usuGetLastTokenPosition(string sStr, string sTok);

// DEF IN "usua_strtokman"
// Fonction qui renvoie la position du dernier D�limiteur dans une chaine.
//   > string sStr - Cha�ne � scanner.
//   > string sTok - D�limiteur.
//   o int - Position du dernier D�limiteur trouv� ou USU_TOKEN_POSITION_ERROR si rien n'a �t� trouv�.
int usuGetFirstTokenPosition(string sStr, string sTok);

// DEF IN "usua_strtokman"
// Fonction qui renvoie tous les caract�res d'une cha�ne qui sont situ�s apr�s un D�limiteur.
//   > string sStr - Cha�ne � scanner.
//   > int iTokLgth - Taille du D�limiteur.
//   > int iTokPos - Position de d part.
//   o string - cha�ne situ e apr�s la position du D�limiteur donn .
string usuGetStringAfterToken(string sStr, int iTokLgth, int iTokPos);

// DEF IN "usua_strtokman"
// Fonction qui renvoie tous les caract�res d'une cha�ne qui sont situ�s avant un D�limiteur.
//   > string sStr - Cha�ne � scanner.
//   > int iTokPos - Position de d part.
//   o string - cha�ne situ e avant la position du D�limiteur donn .
string usuGetStringBeforeToken(string sStr, int iTokPos);

// DEF IN "usua_strtokman"
// Fonction qui renvoie tous les caract�res d'une cha�ne qui sont situ�s entre deux D�limiteurs.
//   > string sStr - Cha�ne � scanner.
//   > int iOpenTokPos - Position du D�limiteur d'ouverture.
//   > int iOpenTokLength - Taille du D�limiteur d'ouverture.
//   > int iCloseTokPos - Position du D�limiteur de fermeture.
//   o string - cha�ne situ e entre les deux D�limiteurs donn s ou USU_TOKEN_POSITION_ERROR si
//              la position du token d'ouverture est situ e apr�s celle de celui de fermeture.
string usuGetStringBetweenTokens(string sStr, int iOpenTokPos, int iOpenTokLength, int iCloseTokPos);

// DEF IN "usua_strtokman"
// Fonction qui renvoie la position du premier D�limiteur trouv� pr�c�dant une position donn�e.
//   > string sStr - Cha�ne � scanner.
//   > string sTokToFind - D�limiteur dont la position est � trouver.
//   > string sTokSource - D�limiteur � partir duquel le scan commence.
//   > int iPosTokSource - Position du D�limiteur de d part du scan.
//   o int - Position trouv�e ou USU_TOKEN_POSITION_ERROR si rien n'a �t� trouv�.
int usuGetPreviousTokenPosition(string sStr, string sTokToFind, string sTokSource, int iPosTokSource);

// DEF IN "usua_strtokman"
// Fonction qui renvoie tous les caract�res d'une cha�ne qui sont situ�s apr�s un D�limiteur.
//   > string sStr - Cha�ne � scanner.
//   > string sTokToFind - D�limiteur dont la position est � trouver.
//   > string sTokSource - D�limiteur � partir duquel le scan commence.
//   > int iPosTokSource - Position du D�limiteur de d part du scan.
//   o int - Position trouv�e ou USU_TOKEN_POSITION_ERROR si rien n'a �t� trouv�.
int usuGetNextTokenPosition(string sStr, string sTokToFind, string sTokSource, int iPosTokSource);

// DEF IN "usua_strtokman"
// Fonction qui supprime tous les espaces de d�but de cha�ne.
//   > string sString - Cha�ne � modifier.
//   o string - cha�ne identique mais d pourvue d'espaces au d�but.
string usuTrimLeftSpaces(string sStr);

// DEF IN "usua_strtokman"
// Fonction qui supprime tous les espaces de fin de cha�ne.
//   > string sStr - Cha�ne � modifier.
//   o string - cha�ne identique mais d pourvue d'espaces � la fin.
string usuTrimRightSpaces(string sStr);

// DEF IN "usua_strtokman"
// Fonction supprimant les espaces en d�but et en fin de chaine.
//   > string sStr - Cha�ne � modifier.
//   o string - cha�ne identique mais d pourvue d'espaces au d�but et   la fin.
string usuTrimAllSpaces(string sStr);

/************************** IMPLEMENTATIONS **************************/

int usuGetLastTokenPosition(string sStr, string sTok) {
    // On stocke la derni�re position valide, initialis�e � une valeur d'erreur.
    int iResult = USU_TOKEN_POSITION_ERROR;

    // Compteur et longueur de cha�ne.
    int iLength = GetStringLength(sStr);
    int iTokLength = GetStringLength(sTok);
    int i = 0;

    // Et on parcourt la cha�ne.
    for (i=0; i<iLength; i++) {
        if (GetSubString(sStr, i, iTokLength) == sTok) {
            // Match ! On modifie la derni�re position valide.
            iResult = i;
        }
    }
    // On renvoit la derni�re position valide.
    return iResult;
}

int usuGetFirstTokenPosition(string sStr, string sTok) {
    // On stocke la derni�re position valide, initialis�e � 0.
    int iResult = USU_TOKEN_POSITION_ERROR;

    // Compteur et longueur de cha�ne.
    int iLength = GetStringLength(sStr);
    int iTokLength = GetStringLength(sTok);
    int i = 0;

    // Et on parcourt la cha�ne.
    for (i=0; i<iLength; i++) {
        if (GetSubString(sStr, i, iTokLength) == sTok) {
            // Match ! On arr te la chaine et on renvoit la position.
            iResult = i;
            break;
        }
    }
    // On renvoie la derni�re position valide.
    return iResult;
}

string usuGetStringAfterToken(string sStr, int iTokLgth, int iTokPos) {
    int iStrLgth = GetStringLength(sStr);
    return GetSubString(sStr, iTokPos+iTokLgth, iStrLgth-iTokPos-iTokLgth);
}

string usuGetStringBeforeToken(string sStr, int iTokPos) {
    return GetSubString(sStr, 0, iTokPos);
}

string usuGetStringBetweenTokens(string sStr, int iOpenTokPos, int iOpenTokLength, int iCloseTokPos) {
    string sRes = sStr;
    if (iOpenTokPos > iCloseTokPos) {
        return USU_STRING_RESULT_ERROR;
    } else {
        sRes = usuGetStringBeforeToken(sRes, iCloseTokPos);
        sRes = usuGetStringAfterToken(sRes, iOpenTokLength, iOpenTokPos);
        return sRes;
    }
}

int usuGetNextTokenPosition(string sStr, string sTokToFind, string sTokSource, int iPosTokSource) {
    int iTokSourceLgth = GetStringLength(sTokSource);
    // On r�cup�re la cha�ne qui se trouve apr�s le D�limiteur.
    string sPart = usuGetStringAfterToken(sStr, iTokSourceLgth, iPosTokSource);
    // Ensuite on cherche le dernier D�limiteur dans cette cha�ne divis e.
    int iResult = usuGetFirstTokenPosition(sPart, sTokToFind);
    // Si rien n'a �t� trouv�, on renvoie une erreur.
    if (iResult == USU_TOKEN_POSITION_ERROR) {
        return USU_TOKEN_POSITION_ERROR;
    }
    // On ajoute alors la position originelle + la taille du D�limiteur r f rence.
    iResult += iPosTokSource + iTokSourceLgth;
    return iResult;
}

int usuGetPreviousTokenPosition(string sStr, string sTokToFind, string sTokSource, int iPosTokSource) {
    // On r�cup�re la cha�ne qui se trouve apr�s le D�limiteur de d part.
    string sPart = usuGetStringBeforeToken(sStr, iPosTokSource);
    // Ensuite on cherche le dernier D�limiteur dans cette cha�ne divis e.
    return usuGetLastTokenPosition(sPart, sTokToFind);
}

string usuTrimLeftSpaces(string sStr) {
    int i = 0;
    int length = GetStringLength(sStr);
    while (i<length) {
        if (GetSubString(sStr, i, 1) != " ") {
            sStr = GetSubString(sStr, i, length-i);
            break;
        }
        i++;
    }
    return sStr;
}

string usuTrimRightSpaces(string sStr) {
    int length = GetStringLength(sStr);
    int i = length;
    while (i>=0) {
        if (GetSubString(sStr, i-1, 1) != " ") {
            sStr = GetSubString(sStr, 0, i);
            break;
        }
        i--;
    }
    return sStr;
}

string usuTrimAllSpaces(string sStr) {
    sStr = usuTrimLeftSpaces(sStr);
    sStr = usuTrimRightSpaces(sStr);
    return sStr;
}
