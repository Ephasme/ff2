/*********************************************************************/
/** Nom :              stda_strtokman
/** Date de cr�ation : 21/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les fonctions relatives � la gestion des
/**    chaines de caract�res.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "stda_constants"

/***************************** PROTOTYPES ****************************/

// DEF IN "stda_strtokman"
// Fonction qui renvoie la position du dernier d�limiteur dans une chaine.
//   > string sStr - Cha�ne � scanner.
//   > string sTok - D�limiteur.
//   o int - Position du dernier D�limiteur trouv� ou STD_TOKEN_POSITION_ERROR si rien n'a �t� trouv�.
int stdGetLastTokenPosition(string sStr, string sTok);

// DEF IN "stda_strtokman"
// Fonction qui renvoie la position du dernier D�limiteur dans une chaine.
//   > string sStr - Cha�ne � scanner.
//   > string sTok - D�limiteur.
//   o int - Position du dernier D�limiteur trouv� ou STD_TOKEN_POSITION_ERROR si rien n'a �t� trouv�.
int stdGetFirstTokenPosition(string sStr, string sTok);

// DEF IN "stda_strtokman"
// Fonction qui renvoie tous les caract�res d'une cha�ne qui sont situ�s apr�s un D�limiteur.
//   > string sStr - Cha�ne � scanner.
//   > int iTokLgth - Taille du D�limiteur.
//   > int iTokPos - Position de d part.
//   o string - cha�ne situ e apr�s la position du D�limiteur donn .
string stdGetStringAfterToken(string sStr, int iTokLgth, int iTokPos);

// DEF IN "stda_strtokman"
// Fonction qui renvoie tous les caract�res d'une cha�ne qui sont situ�s avant un D�limiteur.
//   > string sStr - Cha�ne � scanner.
//   > int iTokPos - Position de d part.
//   o string - cha�ne situ e avant la position du D�limiteur donn .
string stdGetStringBeforeToken(string sStr, int iTokPos);

// DEF IN "stda_strtokman"
// Fonction qui renvoie tous les caract�res d'une cha�ne qui sont situ�s entre deux D�limiteurs.
//   > string sStr - Cha�ne � scanner.
//   > int iOpenTokPos - Position du D�limiteur d'ouverture.
//   > int iOpenTokLength - Taille du D�limiteur d'ouverture.
//   > int iCloseTokPos - Position du D�limiteur de fermeture.
//   o string - cha�ne situ e entre les deux D�limiteurs donn s ou STD_TOKEN_POSITION_ERROR si
//              la position du token d'ouverture est situ e apr�s celle de celui de fermeture.
string stdGetStringBetweenTokens(string sStr, int iOpenTokPos, int iOpenTokLength, int iCloseTokPos);

// DEF IN "stda_strtokman"
// Fonction qui renvoie la position du premier D�limiteur trouv� pr�c�dant une position donn�e.
//   > string sStr - Cha�ne � scanner.
//   > string sTokToFind - D�limiteur dont la position est � trouver.
//   > string sTokSource - D�limiteur � partir duquel le scan commence.
//   > int iPosTokSource - Position du D�limiteur de d part du scan.
//   o int - Position trouv�e ou STD_TOKEN_POSITION_ERROR si rien n'a �t� trouv�.
int stdGetPreviousTokenPosition(string sStr, string sTokToFind, string sTokSource, int iPosTokSource);

// DEF IN "stda_strtokman"
// Fonction qui renvoie tous les caract�res d'une cha�ne qui sont situ�s apr�s un D�limiteur.
//   > string sStr - Cha�ne � scanner.
//   > string sTokToFind - D�limiteur dont la position est � trouver.
//   > string sTokSource - D�limiteur � partir duquel le scan commence.
//   > int iPosTokSource - Position du D�limiteur de d part du scan.
//   o int - Position trouv�e ou STD_TOKEN_POSITION_ERROR si rien n'a �t� trouv�.
int stdGetNextTokenPosition(string sStr, string sTokToFind, string sTokSource, int iPosTokSource);

// DEF IN "stda_strtokman"
// Fonction qui supprime tous les espaces de d�but de cha�ne.
//   > string sString - Cha�ne � modifier.
//   o string - cha�ne identique mais d pourvue d'espaces au d�but.
string stdTrimLeftSpaces(string sStr);

// DEF IN "stda_strtokman"
// Fonction qui supprime tous les espaces de fin de cha�ne.
//   > string sStr - Cha�ne � modifier.
//   o string - cha�ne identique mais d pourvue d'espaces � la fin.
string stdTrimRightSpaces(string sStr);

// DEF IN "stda_strtokman"
// Fonction supprimant les espaces en d�but et en fin de chaine.
//   > string sStr - Cha�ne � modifier.
//   o string - cha�ne identique mais d pourvue d'espaces au d�but et   la fin.
string stdTrimAllSpaces(string sStr);

/************************** IMPLEMENTATIONS **************************/

int stdGetLastTokenPosition(string sStr, string sTok) {
    // On stocke la derni�re position valide, initialis�e � une valeur d'erreur.
    int iResult = STD_TOKEN_POSITION_ERROR;

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

int stdGetFirstTokenPosition(string sStr, string sTok) {
    // On stocke la derni�re position valide, initialis�e � 0.
    int iResult = STD_TOKEN_POSITION_ERROR;

    // Compteur et longueur de cha�ne.
    int iLength = GetStringLength(sStr);
    int iTokLength = GetStringLength(sTok);
    int i = 0;

    // Et on parcourt la cha�ne.
    for (i=0; i<iLength; i++) {
        if (GetSubString(sStr, i, iTokLength) == sTok) {
            // Match ! On arr�te la chaine et on renvoit la position.
            iResult = i;
            break;
        }
    }
    // On renvoie la derni�re position valide.
    return iResult;
}

string stdGetStringAfterToken(string sStr, int iTokLgth, int iTokPos) {
    int iStrLgth = GetStringLength(sStr);
    return GetSubString(sStr, iTokPos+iTokLgth, iStrLgth-iTokPos-iTokLgth);
}

string stdGetStringBeforeToken(string sStr, int iTokPos) {
    return GetSubString(sStr, 0, iTokPos);
}

string stdGetStringBetweenTokens(string sStr, int iOpenTokPos, int iOpenTokLength, int iCloseTokPos) {
    string sRes = sStr;
    if (iOpenTokPos > iCloseTokPos) {
        return STD_STRING_RESULT_ERROR;
    } else {
        sRes = stdGetStringBeforeToken(sRes, iCloseTokPos);
        sRes = stdGetStringAfterToken(sRes, iOpenTokLength, iOpenTokPos);
        return sRes;
    }
}

int stdGetNextTokenPosition(string sStr, string sTokToFind, string sTokSource, int iPosTokSource) {
    int iTokSourceLgth = GetStringLength(sTokSource);
    // On r�cup�re la cha�ne qui se trouve apr�s le D�limiteur.
    string sPart = stdGetStringAfterToken(sStr, iTokSourceLgth, iPosTokSource);
    // Ensuite on cherche le dernier D�limiteur dans cette cha�ne divis�e.
    int iResult = stdGetFirstTokenPosition(sPart, sTokToFind);
    // Si rien n'a �t� trouv�, on renvoie une erreur.
    if (iResult == STD_TOKEN_POSITION_ERROR) {
        return STD_TOKEN_POSITION_ERROR;
    }
    // On ajoute alors la position originelle + la taille du D�limiteur r�f�rence.
    iResult += iPosTokSource + iTokSourceLgth;
    return iResult;
}

int stdGetPreviousTokenPosition(string sStr, string sTokToFind, string sTokSource, int iPosTokSource) {
    // On r�cup�re la cha�ne qui se trouve apr�s le D�limiteur de d�part.
    string sPart = stdGetStringBeforeToken(sStr, iPosTokSource);
    // Ensuite on cherche le dernier D�limiteur dans cette cha�ne divis�e.
    return stdGetLastTokenPosition(sPart, sTokToFind);
}

string stdTrimLeftSpaces(string sStr) {
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

string stdTrimRightSpaces(string sStr) {
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

string stdTrimAllSpaces(string sStr) {
    sStr = stdTrimLeftSpaces(sStr);
    sStr = stdTrimRightSpaces(sStr);
    return sStr;
}
