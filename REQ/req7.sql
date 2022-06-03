
-- solution pour req 3+5 

/** le total des cargaisons ajoutés selon regroupe*/

WITH tab AS (select regroupe, sum(vol_achete) as CHARGE1
from cargaison
where vol_achete IS NOT NULL
group by regroupe
UNION ALL
SELECT regroupe, sum(vol_encours) as CHARGE1
from cargaison
where vol_vendu IS NOT NULL
group by regroupe
)
SELECT regroupe, SUM(CHARGE1) as charge
FROM tab
GROUP BY regroupe ;


/**
regroupe | charge 
----------+--------
       11 |   7148
        9 |   3550
        3 |   4300
        4 |   3653
       10 |   6000
       14 |  10206
       13 |   1586
        2 |   4000
       12 |   4300
        1 |   1000
       18 |   3702
        8 |   3700
(12 rows)

