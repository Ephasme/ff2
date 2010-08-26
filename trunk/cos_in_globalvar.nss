/*********************************************************************/
/** Nom :              cos_in_globalvar
/** Date de création : 15/07/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les fonctions d'accès et de création des
/**    Waypoints de stockage est variables globales.
/*********************************************************************/

/***************************** INCLUDES ******************************/

// Fichier de configuration.
#include "cos_in_config"

/***************************** CONSTANTES ****************************/

/** CONSTANTES DU SYSTEME DE VARIABLES GLOBALES **/
// SGVN = Stocked Global Variable Name.
const string ENTERING_OBJECT = "EnteringObject";

/***************************** PROTOTYPES ****************************/

// DEF IN "cos_in_globalvar"
// Fonction qui renvoie le Waypoint qui stocke les variables globales du module.
//   o object - Waypoint de stockage des variables globales.
object cosGetGlobalVarWaypoint();

// DEF IN "cos_in_globalvar"
// Fonction qui stocke une variable globale de type int.
//   > string sGlobalVarName - Nom de la variable globale.
//   > int iValue - Valeur de cette variable.
void cosSetGlobalInt(string sGlobalVarName, int iValue);

// DEF IN "cos_in_globalvar"
// Fonction qui stocke une variable globale de type object.
//   > string sGlobalVarName - Nom de la variable globale.
//   > object oObject - Valeur de cette variable.
void cosSetGlobalObject(string sGlobalVarName, object oObject);

// DEF IN "cos_in_globalvar"
// Fonction qui renvoie une variable globale de type int stockée.
//   > string sGlobalVarName - Nom de la variable globale.
//   o int - Variable stockée globalement.
int cosGetGlobalInt(string sGlobalVarName);

// DEF IN "cos_in_globalvar"
// Fonction qui renvoie une variable globale de type object stockée.
//   > string sGlobalVarName - Nom de la variable globale.
//   o object - Objet stocké globalement.
object cosGetGlobalObject(string sGlobalVarName);

/************************** IMPLEMENTATIONS **************************/

object cosGetGlobalVarWaypoint() {
    // On crée la variable à la valeur nulle.
    object oGlobalVarWP;
    // On tente de récupérer le Waypoint (s'il existe, l'objet sera valide.)
    oGlobalVarWP = GetObjectByTag(GV_STOCK_OBJECT_TAG);
    if (!GetIsObjectValid(oGlobalVarWP)) {
        /* L'objet est invalide, donc le Waypoint n'a pas encore été créé.
        On crée un Waypoint avec un tag spécifique défini dans le script de
        configuration qui contiendra toutes les variables globales du module. */
        oGlobalVarWP = CreateObject(OBJECT_TYPE_WAYPOINT, GV_STOCK_OBJECT_RESREF, GetStartingLocation(), FALSE, GV_STOCK_OBJECT_TAG);
    }
    // Dans tous les cas, on renvoie l'objet sus-créé.
    return oGlobalVarWP;
}

void cosSetGlobalInt(string sGlobalVarName, int iValue) {
    // Récupération du Waypoint de stockage.
    object oGlobalVarWP = cosGetGlobalVarWaypoint();
    if (GetIsObjectValid(oGlobalVarWP)) {
        // Tout se passe bien : on stocke la variable.
        SetLocalInt(oGlobalVarWP, sGlobalVarName, iValue);
    }
}

void cosSetGlobalObject(string sGlobalVarName, object oObject) {
    // Récupération du Waypoint de stockage.
    object oGlobalVarWP = cosGetGlobalVarWaypoint();
    if (GetIsObjectValid(oGlobalVarWP)) {
        // Tout se passe bien : on stocke la variable.
        SetLocalObject(oGlobalVarWP, sGlobalVarName, oObject);
    }
}

int cosGetGlobalInt(string sGlobalVarName) {
    // Récupération du Waypoint de stockage.
    object oGlobalVarWP = cosGetGlobalVarWaypoint();
    int result = -1;
    if (GetIsObjectValid(oGlobalVarWP)) {
        // Tout se passe bien : on renvoie la variable.
        result = GetLocalInt(oGlobalVarWP, sGlobalVarName);
    }
    // Fin de la fonction, expédition du résultat.
    return result;
}

object cosGetGlobalObject(string sGlobalVarName) {
    // Récupération du Waypoint de stockage.
    object oGlobalVarWP = cosGetGlobalVarWaypoint();
    object result = OBJECT_INVALID;
    if (GetIsObjectValid(oGlobalVarWP)) {
        // Tout se passe bien : on renvoie la variable.
        result = GetLocalObject(oGlobalVarWP, sGlobalVarName);
    }
    // Fin de la fonction, expédition du résultat.
    return result;
}