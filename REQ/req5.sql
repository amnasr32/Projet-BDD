\! echo requete 5 qui calcule le gain de cargaison lors du voyage [achete+encours:res diff car nul]

/**
deux requetes qui renverraient le meme resultat si vos tables de ne contenaient pas de nulls, mais qui renvoient des resultats differents sinon
**/
--------req 2
SELECT regroupe , SUM(vol_achete) + SUM (vol_encours) as modification
from cargaison
group by regroupe;


/**
 regroupe | modification 
----------+--------------
       11 |         7148
        9 |         3550
        3 |         4300
        5 |             
        4 |         3653
       10 |         6000
        6 |             
       14 |        10206
       13 |         8789
        2 |         4000
        7 |             
       12 |             
        1 |         1000
       18 |         3702
        8 |         3700
(15 rows)




**/
