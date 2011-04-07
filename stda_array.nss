/*********************************************************************/
/** Nom :              stda_array
/** Date de création : 02/04/2011
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les fonctions de simulation de tableau.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "stda_constants"

/***************************** PROTOTYPES ****************************/

// DEF_IN "stda_array"
// Crée une nouvelle structure utilisable comme un tableau grâce aux
// fonctions de ce script.
//   > int iCol - Taille de chaque élément du tableau, exemple, 23 fait
//                une taille de 2 et 345 de 3.
//   > int iSize - Taille du tableau (optionnel et 0 par défaut).
//   o struct std_array - Tableau créé.
struct std_array stdCreateArray(int iDigits, int iSize);

// Structure représentant un tableau.
struct std_array {
    string value;
    int array_s;
    int type_s;
};

/************************** IMPLEMENTATIONS **************************/

struct std_array stdCreateArray(int iDigits, int iSize) {
    struct std_array aRes;
    aRes.array_s = iSize;
    aRes.type_s = iDigits;
    int i = 0;
    for (i;i<iSize;i++) {
        int j = 0;
        for (j;j<iDigits;j++) {
            aRes.value += " ";
        }
    }
}
