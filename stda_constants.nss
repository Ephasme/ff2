/**************************************************************************************************/
/** Nom :              stda_constants
/** Date de cr�ation : 29/08/2010
/** Version :          1.0.0
/** Cr�ateur :         Peluso Loup
/******************************************* ChangeLog ********************************************/
/** V1.0.0 (par Peluso Loup) :
/**      Fichier contenant toutes les constantes de la biblioth�que de fonctions.
/**************************************************************************************************/

// Constantes g�n�rales
const string STD_EMPTY_STRING = "";

// Erreurs des fonctions de d�tection des tokens.
const int STD_TOKEN_POSITION_ERROR = -1;
const string STD_STRING_RESULT_ERROR = "ERR";

// Constantes d'information du syst�me.
const string STD_SYS_NAME = "Syst�me g�n�ral.";
const string STD_SYS_ACRO = "STD";

// Contantes de langue.
const string STD_L_AUTOMATIC_MOVEMENT_UP_TO_THE_MAP = "D�placement automatique jusqu'� la map";
const string STD_L_INSTANT_MOVING                   = "Mouvement instantan�";
const string STD_L_TO_THE_POSITION                  = "A la position";

// Token de Location.
const string STD_LOCATION_TOKEN = "##";

// Tag de l'objet cible pour les d�placements de personnages.
const string STD_CIBLE_WP_RESREF = "nw_waypoint001";

// Temps avant la destruction du waypoint cible pour un d�placement de personnage.
const float STD_TIME_BEFORE_DESTROY_WP = 1.0f;

// Distance du personnage � la cible lors d'un d�placement de personnage
const float STD_DISTANCE_BETWEEN_CIBLE = 1.0f;

// ********************** TESTS ************************* //

const int TS_TEST_MODE = TRUE;

const int TS_STD_SYS = TRUE;
const int TS_SQL_SYS = TRUE;
const int TS_CMD_SYS = TRUE;
const int TS_COS_SYS = TRUE;

const int TS_LOOP_MAX = 10;
const float TS_LOOP_DELAY = 2.0f;

const string TS_CMD_TITLE = "CMD_SYSTEM";
const string TS_STD_TITLE = "STD_SYSTEM";
const string TS_SQL_TITLE = "SQL_SYSTEM";
const string TS_COS_TITLE = "COS_SYSTEM";

/* Cha�ne utilis�e pour tester les fonctions de manipulation de cha�ne. */
const string TS_CMD_STRING = "jfi<omJ  F IE!>fj <JKFMDio  <  uhuaibj!> k lru<jeuirez!> f5kdsmHB<uohe>!!!";
const string TS_CMD_TRIM_SPACES = "    testme    ";

/* Constantes de langage. */
const string TS_L_TESTS_BEGIN = "D�but des tests";
const string TS_L_TESTS_END = "Fin des tests";
const string TS_L_CORRECT_FUNCTIONING_OF = "Fonctionnement correct de";
const string TS_L_ABNORMAL_FUNCTIONING_OF = "Fonctionnement anormal de";
const string TS_L_CASE = "Cas";
const string TS_L_FOR = "pour";
const string TS_L_HOUR = "Temps �coul�";
const string TS_L_SOURCE = "Source";

// ********************** ERREUR ************************* //

const string STD_ERR_CANNOT_FIND_DESTINATION = "Impossible de trouver la destination voulue.";
const string STD_ERR_CHARACTER_INVALID = "Le personnage est invalide.";
