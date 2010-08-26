/*********************************************************************/
/** Nom :              a017on_enterAAA
/** Date de création : 25/08/2010
/** Version :          1.0.0
/** Createur :         Loup Peluso
/***************************** ChangeLog *****************************/
/** V1.0.0 :
/**      Script spécifique à la map 017. Déclenché quand le personnage
/**   déclenche l'évènement OnEnter de l'objet dont le tag termine
/**   par AAA.
/*********************************************************************/

void main()
{
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC)) {
        SendMessageToPC(oPC, "Bienvenue sur FF2, allez parler à l'homme qui se trouve devant vous.");
    }
}
