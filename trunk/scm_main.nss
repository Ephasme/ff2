/*********************************************************************/
/** Nom :              scm_main
/** Date de création : 21/07/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/***************************** ChangeLog *****************************/
/** V1.0.0 (par Peluso Loup) :
/**      Script principal d'exécution des commandes.
/*********************************************************************/

            // Donnees de config.
            // #include "cos_config"

            // Fonctions de manipulation des chaînes de caractères.
            // #include "usu_stringtokman"
        // Fonctions de manipulation et de traîtement.
        // #include "scm_utils"

        // Fonctions de déplacement.
        // #include "usumoves"
    // Commandes de déplacement des PJs.
    // #include "scm_cmmoving"
// Toutes les commandes.
#include "scm_commands"

/***************************** PROTOTYPES ****************************/

// DEF IN "scm_main"
// Fonction qui exécute une commande et renvoie le résultat sous forme de chaîne.
//   > string sCommand - Commande à traîter.
//   > object oPC - Personnage qui a lancé la requête.
//   o string - Résultat de la commande (renvoie une chaîne vide si aucun résultat n'est trouvé).
string scmExecuteCommand(string sCommand, object oPC);

// DEF IN "scm_main"
// Renvoie un speech intégrant le résultat d'une commande.
//   > struct scm_command_datas strScmCommandDatas - Structure de la commande.
//   > string sResult - Résultat à intégrer.
//   o string - Résultat de la commande (renvoie une chaîne vide si aucun résultat n'est trouvé).
string scmFetchCommand(struct scm_command_datas strScmCommandDatas, string sResult);

// DEF IN "scm_main"
// Fonction qui exécute une commande et la remplace par son résultat dans le speech d'origine.
//   > struct scm_command_datas strScmCommandDatas - Structure de la commande.
//   > object oPC - Personnage qui a lancé la requête.
//   o string - Résultat de la commande (renvoie une chaîne vide si aucun résultat n'est trouvé).
string scmExecAndFetchCommand(struct scm_command_datas strScmCommandDatas, object oPC);

/************************** IMPLEMENTATIONS **************************/

string scmExecuteCommand(string sCommand, object oPC) {
    string sCommandName;

    // On teste si le système est actif.
    if (SMC_ENABLED == FALSE) {
        return SCM_EMPTY_RESULT;
    }
    // On récupère le nom de la commande.
    sCommandName = scmGetCommandName(sCommand);

    // Et on cherche la fonction correspondante.
    if (sCommandName == SCM_CM_SAVE_LOC) {

        return scmSaveLocCommand(sCommand, oPC);

    } else if (sCommandName == SCM_CM_MOVE_TO) {

        return scmMoveToCommand(sCommand, oPC);

    }

    // Enfin, on renvoie un résultat vide si aucune fonction n'a été trouvé pour la commande.
    return SCM_EMPTY_RESULT;
}

string scmFetchCommand(struct scm_command_datas strScmCommandDatas, string sResult) {
    if (scmIsValidCommand(strScmCommandDatas)) {
        // On extrait la partie gauche, avant la commande.
        string sLeftPart = usuGetStringBeforeToken(strScmCommandDatas.sSpeech, strScmCommandDatas.iOpeningTokPos);
        // On extrait la partie droite, après la commande.
        string sRightPart = usuGetStringAfterToken(strScmCommandDatas.sSpeech, SCM_CLOSING_TOKEN_LENGTH, strScmCommandDatas.iClosingTokPos);
        // On remplace la commande par son résultat.
        return sLeftPart+sResult+sRightPart;
    } else {
        return strScmCommandDatas.sSpeech;
    }
}

string scmExecAndFetchCommand(struct scm_command_datas strScmCommandDatas, object oPC) {
    // Si la commande n'est pas vide, on l'exécute et on remplace directement le résultat. 
    if (scmIsValidCommand(strScmCommandDatas)) {
        return scmFetchCommand(strScmCommandDatas, scmExecuteCommand(strScmCommandDatas.sCommand, oPC));
    }
    // Et on renvoie le texte d'origine modifié.
    return SCM_EMPTY_RESULT;
}