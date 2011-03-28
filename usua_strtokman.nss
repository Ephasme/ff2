/*********************************************************************/
/** Nom :              usua_strtokman
/** Date de création : 21/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les fonctions relatives à la gestion des
/**    chaines de caractères.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "usua_constants"

/***************************** PROTOTYPES ****************************/

// DEF IN "usua_strtokman"
// Fonction qui renvoie la position du dernier délimiteur dans une chaine.
//   > string sStr - Chaîne à scanner.
//   > string sTok - Délimiteur.
//   o int - Position du dernier Délimiteur trouvé ou USU_TOKEN_POSITION_ERROR si rien n'a été trouvé.
int usuGetLastTokenPosition(string sStr, string sTok);

// DEF IN "usua_strtokman"
// Fonction qui renvoie la position du dernier Délimiteur dans une chaine.
//   > string sStr - Chaîne à scanner.
//   > string sTok - Délimiteur.
//   o int - Position du dernier Délimiteur trouvé ou USU_TOKEN_POSITION_ERROR si rien n'a été trouvé.
int usuGetFirstTokenPosition(string sStr, string sTok);

// DEF IN "usua_strtokman"
// Fonction qui renvoie tous les caractères d'une chaîne qui sont situés après un Délimiteur.
//   > string sStr - Chaîne à scanner.
//   > int iTokLgth - Taille du Délimiteur.
//   > int iTokPos - Position de d part.
//   o string - chaîne situ e après la position du Délimiteur donn .
string usuGetStringAfterToken(string sStr, int iTokLgth, int iTokPos);

// DEF IN "usua_strtokman"
// Fonction qui renvoie tous les caractères d'une chaîne qui sont situés avant un Délimiteur.
//   > string sStr - Chaîne à scanner.
//   > int iTokPos - Position de d part.
//   o string - chaîne situ e avant la position du Délimiteur donn .
string usuGetStringBeforeToken(string sStr, int iTokPos);

// DEF IN "usua_strtokman"
// Fonction qui renvoie tous les caractères d'une chaîne qui sont situés entre deux Délimiteurs.
//   > string sStr - Chaîne à scanner.
//   > int iOpenTokPos - Position du Délimiteur d'ouverture.
//   > int iOpenTokLength - Taille du Délimiteur d'ouverture.
//   > int iCloseTokPos - Position du Délimiteur de fermeture.
//   o string - chaîne situ e entre les deux Délimiteurs donn s ou USU_TOKEN_POSITION_ERROR si
//              la position du token d'ouverture est situ e après celle de celui de fermeture.
string usuGetStringBetweenTokens(string sStr, int iOpenTokPos, int iOpenTokLength, int iCloseTokPos);

// DEF IN "usua_strtokman"
// Fonction qui renvoie la position du premier Délimiteur trouvé précédant une position donnée.
//   > string sStr - Chaîne à scanner.
//   > string sTokToFind - Délimiteur dont la position est à trouver.
//   > string sTokSource - Délimiteur à partir duquel le scan commence.
//   > int iPosTokSource - Position du Délimiteur de d part du scan.
//   o int - Position trouvée ou USU_TOKEN_POSITION_ERROR si rien n'a été trouvé.
int usuGetPreviousTokenPosition(string sStr, string sTokToFind, string sTokSource, int iPosTokSource);

// DEF IN "usua_strtokman"
// Fonction qui renvoie tous les caractères d'une chaîne qui sont situés après un Délimiteur.
//   > string sStr - Chaîne à scanner.
//   > string sTokToFind - Délimiteur dont la position est à trouver.
//   > string sTokSource - Délimiteur à partir duquel le scan commence.
//   > int iPosTokSource - Position du Délimiteur de d part du scan.
//   o int - Position trouvée ou USU_TOKEN_POSITION_ERROR si rien n'a été trouvé.
int usuGetNextTokenPosition(string sStr, string sTokToFind, string sTokSource, int iPosTokSource);

// DEF IN "usua_strtokman"
// Fonction qui supprime tous les espaces de début de chaîne.
//   > string sString - Chaîne à modifier.
//   o string - chaîne identique mais d pourvue d'espaces au début.
string usuTrimLeftSpaces(string sStr);

// DEF IN "usua_strtokman"
// Fonction qui supprime tous les espaces de fin de chaîne.
//   > string sStr - Chaîne à modifier.
//   o string - chaîne identique mais d pourvue d'espaces à la fin.
string usuTrimRightSpaces(string sStr);

// DEF IN "usua_strtokman"
// Fonction supprimant les espaces en début et en fin de chaine.
//   > string sStr - Chaîne à modifier.
//   o string - chaîne identique mais d pourvue d'espaces au début et   la fin.
string usuTrimAllSpaces(string sStr);

/************************** IMPLEMENTATIONS **************************/

int usuGetLastTokenPosition(string sStr, string sTok) {
    // On stocke la dernière position valide, initialisée à une valeur d'erreur.
    int iResult = USU_TOKEN_POSITION_ERROR;

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

int usuGetFirstTokenPosition(string sStr, string sTok) {
    // On stocke la dernière position valide, initialisée à 0.
    int iResult = USU_TOKEN_POSITION_ERROR;

    // Compteur et longueur de chaîne.
    int iLength = GetStringLength(sStr);
    int iTokLength = GetStringLength(sTok);
    int i = 0;

    // Et on parcourt la chaîne.
    for (i=0; i<iLength; i++) {
        if (GetSubString(sStr, i, iTokLength) == sTok) {
            // Match ! On arr te la chaine et on renvoit la position.
            iResult = i;
            break;
        }
    }
    // On renvoie la dernière position valide.
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
    // On récupère la chaîne qui se trouve après le Délimiteur.
    string sPart = usuGetStringAfterToken(sStr, iTokSourceLgth, iPosTokSource);
    // Ensuite on cherche le dernier Délimiteur dans cette chaîne divis e.
    int iResult = usuGetFirstTokenPosition(sPart, sTokToFind);
    // Si rien n'a été trouvé, on renvoie une erreur.
    if (iResult == USU_TOKEN_POSITION_ERROR) {
        return USU_TOKEN_POSITION_ERROR;
    }
    // On ajoute alors la position originelle + la taille du Délimiteur r f rence.
    iResult += iPosTokSource + iTokSourceLgth;
    return iResult;
}

int usuGetPreviousTokenPosition(string sStr, string sTokToFind, string sTokSource, int iPosTokSource) {
    // On récupère la chaîne qui se trouve après le Délimiteur de d part.
    string sPart = usuGetStringBeforeToken(sStr, iPosTokSource);
    // Ensuite on cherche le dernier Délimiteur dans cette chaîne divis e.
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
