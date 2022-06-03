\! echo requete 3 qui calcule le gain de cargaison lors du voyage [achete+encours:res diff car nul]
/**
deux requetes qui renverraient le meme resultat si vos tables de ne contenaient pas de nulls, mais qui renvoient des resultats differents sinon
**/
--------req 1
SELECT regroupe , SUM(vol_achete + vol_encours) as modification
from cargaison
group by regroupe;

/**
 regroupe | modification 
----------+--------------
       11 |          180
        9 |            0
        3 |            0
        5 |             
        4 |            0
       10 |            0
        6 |             
       14 |        -1683
       13 |             
        2 |            0
        7 |             
       12 |             
        1 |            0
       18 |        -2693
        8 |            0
(15 rows)



**/
