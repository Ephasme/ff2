/*********************************************************************/
/** Nom :              cmda_c_afk
/** Date de cr�ation : 23/03/2011
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script contenant les commandes relatives � l'AFK.
/*********************************************************************/

/***************************** INCLUDES ******************************/

#include "cmda_utils"
#include "afka_main"

/***************************** PROTOTYPES ****************************/

// DEF IN "cmda_commands"
// Fonction qui active ou d�sactive le mode AFK d'un personnage.
//   > string sCommand - Commande � traiter.
//   > object oPC - Source de la requ�te.
//   o string - Cha�ne vide.
string cmd_afkToggleAFKState(string sCommand, object oPC);

/************************** IMPLEMENTATIONS **************************/

string cmd_afkToggleAFKState(string sCommand, object oPC) {
    afkToggleState(oPC);
    return CMD_EMPTY_RESULT;
}
