/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\

      CONVENTION - MAPPING

    S'asseoir sur des objets
    ------------------------

    Les chaises doivent �tre pos�es sur vos maps en mode Static. Les pla�ables "Place pour s'asseoir"
(tag ffp_plsitdown) permettent � un personnage cliquant dessus de s'y asseoir, il suffit donc d'en mettre par dessus les 
chaises ou les tilesets o� vous souhaitez que le personnage s'asseye.
    Si, malgr� tout, vous souhaitez que le personnage s'asseye directement sur un pla�able il faut
simplement mettre le script cos_ev_on_used sur l'�v�nement OnUsed et d�finir une variable nomm�e
ON_USED_ACTION_SIT de type int et de valeur 1.

    Il est cependant pr�f�rable d'�viter cette fa�on de faire afin de centraliser un maximum les
syst�me de FF. Cela permet une maintenance plus ais�e, en effet, s'il fallait �diter le pla�able
pour s'asseoir, il suffirait d'�diter le pla�able ffp_plsitdown et de mettre � jour toutes les
instances du module.

\* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
