/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\

      CONVENTION - MAPPING

    S'asseoir sur des objets
    ------------------------

    Les chaises doivent être posées sur vos maps en mode Static. Les plaçables "Place pour s'asseoir"
(tag ffp_plsitdown) permettent à un personnage cliquant dessus de s'y asseoir, il suffit donc d'en mettre par dessus les 
chaises ou les tilesets où vous souhaitez que le personnage s'asseye.
    Si, malgré tout, vous souhaitez que le personnage s'asseye directement sur un plaçable il faut
simplement mettre le script cos_ev_on_used sur l'évènement OnUsed et définir une variable nommée
ON_USED_ACTION_SIT de type int et de valeur 1.

    Il est cependant préférable d'éviter cette façon de faire afin de centraliser un maximum les
système de FF. Cela permet une maintenance plus aisée, en effet, s'il fallait éditer le plaçable
pour s'asseoir, il suffirait d'éditer le plaçable ffp_plsitdown et de mettre à jour toutes les
instances du module.

\* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
