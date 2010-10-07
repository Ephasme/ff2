/**************************************************************************************************/
/** Nom :              usuaf_constants
/** Date de création : 29/08/2010
/** Version :          1.0.0
/** Créateur :         Peluso Loup
/******************************************* ChangeLog ********************************************/
/** V1.0.0 (par Peluso Loup) :
/**      Fichier contenant toutes les constantes de la bibliothèque de fonctions.
/**************************************************************************************************/

// Erreurs des fonctions de détection des tokens.
const int USU_TOKEN_POSITION_ERROR = -1;
const string USU_STRING_RESULT_ERROR = "ERR";

// Contantes de langue.
const string USU_L_AUTOMATIC_MOVEMENT_UP_TO_THE_MAP = "Déplacement automatique jusqu'à la map";
const string USU_L_INSTANT_MOVING                   = "Mouvement instantané";
const string USU_L_TO_THE_POSITION                  = "A la position";

// Token de Location.
const string USU_LOCATION_TOKEN = "##";

const int USU_HASHSET_ERROR = FALSE;
const int USU_HASHSET_SUCCESS = TRUE;

// Tag de l'objet contenant les HashSet du module.
const string USU_WP_HASHSET_TAG = "cos_wpHashSet";
const string USU_WP_HASHSET_RESREF = "nw_waypoint001";

// ********************** TESTS ************************* //

const int TS_TEST_MODE = TRUE;

const int TS_USU_SYS = TRUE;
const int TS_SQL_SYS = TRUE;
const int TS_CMD_SYS = TRUE;
const int TS_COS_SYS = TRUE;

const int TS_LOOP_MAX = 10;
const float TS_LOOP_DELAY = 2.0f;

const string TS_CMD_TITLE = "CMD_SYSTEM";
const string TS_USU_TITLE = "USU_SYSTEM";
const string TS_SQL_TITLE = "SQL_SYSTEM";
const string TS_COS_TITLE = "COS_SYSTEM";

/* Chaîne utilisée pour tester les fonctions de manipulation de chaîne. */
const string TS_CMD_STRING = "jfi<omJ  F IE!>fj <JKFMDio  <  uhuaibj!> k lru<jeuirez!> f5kdsmHB<uohe>!!!";
const string TS_CMD_TRIM_SPACES = "    testme    ";

/* Constantes de langage. */
const string TS_L_TESTS_BEGIN = "Début des tests";
const string TS_L_TESTS_END = "Fin des tests";
const string TS_L_CORRECT_FUNCTIONING_OF = "Fonctionnement correct de";
const string TS_L_ABNORMAL_FUNCTIONING_OF = "Fonctionnement anormal de";
const string TS_L_CASE = "Cas";
const string TS_L_FOR = "pour";
const string TS_L_HOUR = "Temps écoulé";
const string TS_L_SOURCE = "Source";

// ********************** TESTS ************************* //