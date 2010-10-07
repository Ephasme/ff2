/*********************************************************************/
/** Nom :              cmdaf_main
/** Date de cr�ation : 21/07/2010
/** Version :          1.0.0
/** Cr ateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script principal d'ex cution des commandes.
/*********************************************************************/

                // #include "usuaf_constants"
            // #include "usuaf_strtokman"
            // #include "cmdaf_constants"
        // #include "cmdaf_utils"

            // #include "usuaf_constants"
        // #include "usuaf_movings"
    // #include "cmdaf_cmmoving"
#include "cmdaf_commands"

/***************************** PROTOTYPES ****************************/

// DEF IN "cmdaf_main"
// Fonction qui ex cute une commande et renvoie le r�sultat sous forme de cha�ne.
//   > string sCommand - Commande � tra ter.
//   > object oPC - Personnage qui a lanc  la requ te.
//   o string - r�sultat de la commande (renvoie une cha�ne vide si aucun r�sultat n'est trouv�).
string cmdExecute(string sCommand, object oPC);

// DEF IN "cmdaf_main"
// Renvoie un speech int grant le r�sultat d'une commande.
//   > struct cmd_data_str strCmdData - Structure de la commande.
//   > string sResult - r�sultat   int grer.
//   o string - r�sultat de la commande (renvoie une cha�ne vide si aucun r�sultat n'est trouv�).
string cmdFetch(struct cmd_data_str strCmdData, string sResult);

// DEF IN "cmdaf_main"
// Fonction qui ex cute une commande et la remplace par son r�sultat dans le speech d'origine.
//   > struct cmd_data_str strCmdData - Structure de la commande.
//   > object oPC - Personnage qui a lanc  la requ te.
//   o string - r�sultat de la commande (renvoie une cha�ne vide si aucun r�sultat n'est trouv�).
string cmdExecAndFetch(struct cmd_data_str strCmdData, object oPC);

/************************** IMPLEMENTATIONS **************************/

string cmdExecute(string sCommand, object oPC) {
    string sCommandName;

    // On teste si le syst�me est actif.
    if (CMD_ENABLED == FALSE) {
        return CMD_EMPTY_RESULT;
    }
    // On r�cup�re le nom de la commande.
    sCommandName = cmdGetCommandName(sCommand);

    // Et on cherche la fonction correspondante.
    if (sCommandName == CMD_C_SAVE_LOC) {

        return cmdSaveLocCommand(sCommand, oPC);

    } else if (sCommandName == CMD_C_MOVE_TO) {

        return cmdMoveToCommand(sCommand, oPC);

    }

    // Enfin, on renvoie un r�sultat vide si aucune fonction n'a �t� trouv� pour la commande.
    return CMD_EMPTY_RESULT;
}

string cmdFetch(struct cmd_data_str strCmdData, string sResult) {
    if (cmdIsCommandValid(strCmdData)) {
        // On extrait la partie gauche, avant la commande.
        string sLeftPart = usuGetStringBeforeToken(strCmdData.sSpeech, strCmdData.iOpeningTokPos);
        // On extrait la partie droite, apr�s la commande.
        string sRightPart = usuGetStringAfterToken(strCmdData.sSpeech, CMD_CLOSING_TOKEN_LENGTH, strCmdData.iClosingTokPos);
        // On remplace la commande par son r�sultat.
        return sLeftPart+sResult+sRightPart;
    } else {
        return strCmdData.sSpeech;
    }
}

string cmdExecAndFetch(struct cmd_data_str strCmdData, object oPC) {
    // Si la commande n'est pas vide, on l'ex cute et on remplace directement le r�sultat.
    if (cmdIsCommandValid(strCmdData)) {
        return cmdFetch(strCmdData, cmdExecute(strCmdData.sCommand, oPC));
    }
    // Et on renvoie le texte d'origine modifi .
    return CMD_EMPTY_RESULT;
}
