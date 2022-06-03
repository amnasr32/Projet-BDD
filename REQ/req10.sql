/* requete qui retourne le nombre de passagers descendu à marseille pendant toutes les étapes tansitoire*/

select
    SUM(passagers.nb_depose) 
from 
    passagers join etape_transitoire on passagers.id_pass=etape_transitoire.passagers 
where etape_transitoire.name_port='Marseille';

