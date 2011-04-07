/*********************************************************************/
/** Nom :              stda_strtokman
/** Date de création : 21/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les fonctions relatives à la gestion des
/**    chaines de caractères.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "stda_constants"

/***************************** PROTOTYPES ****************************/

// DEF IN "stda_strtokman"
// Fonction qui renvoie la position du dernier délimiteur dans une chaine.
//   > string sStr - Chaîne à scanner.
//   > string sTok - Délimiteur.
//   o int - Position du dernier Délimiteur trouvé ou STD_TOKEN_POSITION_ERROR si rien n'a été trouvé.
int stdGetLastTokenPosition(string sStr, string sTok);

// DEF IN "stda_strtokman"
// Fonction qui renvoie la position du dernier Délimiteur dans une chaine.
//   > string sStr - Chaîne à scanner.
//   > string sTok - Délimiteur.
//   o int - Position du dernier Délimiteur trouvé ou STD_TOKEN_POSITION_ERROR si rien n'a été trouvé.
int stdGetFirstTokenPosition(string sStr, string sTok);

// DEF IN "stda_strtokman"
// Fonction qui renvoie tous les caractères d'une chaîne qui sont situés après un Délimiteur.
//   > string sStr - Chaîne à scanner.
//   > int iTokLgth - Taille du Délimiteur.
//   > int iTokPos - Position de d part.
//   o string - chaîne situ e après la position du Délimiteur donn .
string stdGetStringAfterToken(string sStr, int iTokLgth, int iTokPos);

// DEF IN "stda_strtokman"
// Fonction qui renvoie tous les caractères d'une chaîne qui sont situés avant un Délimiteur.
//   > string sStr - Chaîne à scanner.
//   > int iTokPos - Position de d part.
//   o string - chaîne situ e avant la position du Délimiteur donn .
string stdGetStringBeforeToken(string sStr, int iTokPos);

// DEF IN "stda_strtokman"
// Fonction qui renvoie tous les caractères d'une chaîne qui sont situés entre deux Délimiteurs.
//   > string sStr - Chaîne à scanner.
//   > int iOpenTokPos - Position du Délimiteur d'ouverture.
//   > int iOpenTokLength - Taille du Délimiteur d'ouverture.
//   > int iCloseTokPos - Position du Délimiteur de fermeture.
//   o string - chaîne situ e entre les deux Délimiteurs donn s ou STD_TOKEN_POSITION_ERROR si
//              la position du token d'ouverture est situ e après celle de celui de fermeture.
string stdGetStringBetweenTokens(string sStr, int iOpenTokPos, int iOpenTokLength, int iCloseTokPos);

// DEF IN "stda_strtokman"
// Fonction qui renvoie la position du premier Délimiteur trouvé précédant une position donnée.
//   > string sStr - Chaîne à scanner.
//   > string sTokToFind - Délimiteur dont la position est à trouver.
//   > string sTokSource - Délimiteur à partir duquel le scan commence.
//   > int iPosTokSource - Position du Délimiteur de d part du scan.
//   o int - Position trouvée ou STD_TOKEN_POSITION_ERROR si rien n'a été trouvé.
int stdGetPreviousTokenPosition(string sStr, string sTokToFind, string sTokSource, int iPosTokSource);

// DEF IN "stda_strtokman"
// Fonction qui renvoie tous les caractères d'une chaîne qui sont situés après un Délimiteur.
//   > string sStr - Chaîne à scanner.
//   > string sTokToFind - Délimiteur dont la position est à trouver.
//   > string sTokSource - Délimiteur à partir duquel le scan commence.
//   > int iPosTokSource - Position du Délimiteur de d part du scan.
//   o int - Position trouvée ou STD_TOKEN_POSITION_ERROR si rien n'a été trouvé.
int stdGetNextTokenPosition(string sStr, string sTokToFind, string sTokSource, int iPosTokSource);

// DEF IN "stda_strtokman"
// Fonction qui supprime tous les espaces de début de chaîne.
//   > string sString - Chaîne à modifier.
//   o string - chaîne identique mais d pourvue d'espaces au début.
string stdTrimLeftSpaces(string sStr);

// DEF IN "stda_strtokman"
// Fonction qui supprime tous les espaces de fin de chaîne.
//   > string sStr - Chaîne à modifier.
//   o string - chaîne identique mais d pourvue d'espaces à la fin.
string stdTrimRightSpaces(string sStr);

// DEF IN "stda_strtokman"
// Fonction supprimant les espaces en début et en fin de chaine.
//   > string sStr - Chaîne à modifier.
//   o string - chaîne identique mais d pourvue d'espaces au début et   la fin.
string stdTrimAllSpaces(string sStr);

/************************** IMPLEMENTATIONS **************************/

int stdGetLastTokenPosition(string sStr, string sTok) {
    // On stocke la dernière position valide, initialisée à une valeur d'erreur.
    int iResult = STD_TOKEN_POSITION_ERROR;

    // Compteur et longueur de chaîne.
    int iLength = GetStringLength(sStr);
    int iTokLength = GetStringLength(sTok);
    int i = 0;

    // Et on parcourt la chaîne.
    for (i=0; i<iLength; i++) {
        if (GetSubString(sStr, i, iTokLength) == sTok) {
            // Match ! On modifie la dernière position valide.
            iResult = i;
        }
    }
    // On renvoit la dernière position valide.
    return iResult;
}

int stdGetFirstTokenPosition(string sStr, string sTok) {
    // On stocke la dernière position valide, initialisée à 0.
    int iResult = STD_TOKEN_POSITION_ERROR;

    // Compteur et longueur de chaîne.
    int iLength = GetStringLength(sStr);
    int iTokLength = GetStringLength(sTok);
    int i = 0;

    // Et on parcourt la chaîne.
    for (i=0; i<iLength; i++) {
        if (GetSubString(sStr, i, iTokLength) == sTok) {
            // Match ! On arrête la chaine et on renvoit la position.
            iResult = i;
            break;
        }
    }
    // On renvoie la dernière position valide.
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
    // On récupère la chaîne qui se trouve après le Délimiteur.
    string sPart = stdGetStringAfterToken(sStr, iTokSourceLgth, iPosTokSource);
    // Ensuite on cherche le dernier Délimiteur dans cette chaîne divisée.
    int iResult = stdGetFirstTokenPosition(sPart, sTokToFind);
    // Si rien n'a été trouvé, on renvoie une erreur.
    if (iResult == STD_TOKEN_POSITION_ERROR) {
        return STD_TOKEN_POSITION_ERROR;
    }
    // On ajoute alors la position originelle + la taille du Délimiteur référence.
    iResult += iPosTokSource + iTokSourceLgth;
    return iResult;
}

int stdGetPreviousTokenPosition(string sStr, string sTokToFind, string sTokSource, int iPosTokSource) {
    // On récupère la chaîne qui se trouve après le Délimiteur de départ.
    string sPart = stdGetStringBeforeToken(sStr, iPosTokSource);
    // Ensuite on cherche le dernier Délimiteur dans cette chaîne divisée.
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
