/*********************************************************************/
/** Nom :              cmda_c_afk
/** Date de création : 23/03/2011
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les commandes relatives à l'AFK.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "cmda_utils"
#include "afka_main"

/***************************** PROTOTYPES ****************************/

// DEF IN "cmda_commands"
// Fonction qui active ou désactive le mode AFK d'un personnage.
//   > string sCommand - Commande à traiter.
//   > object oPC - Source de la requête.
//   o string - Chaîne vide.
string cmd_afkToggleAFKState(string sCommand, object oPC);

/************************** IMPLEMENTATIONS **************************/

string cmd_afkToggleAFKState(string sCommand, object oPC) {
    afkToggleState(oPC);
    return CMD_EMPTY_RESULT;
}
