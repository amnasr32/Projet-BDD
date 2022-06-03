/* requete qui retourne les id et noms des navires ayant une categorie en 3 et 5 et le nombre de leurs voyages */
select 
    navire.id_navire, navire.name,count(*) as nbr_voyages 
from 
    voyage join navire on voyage.id_navire=navire.id_navire 
    group by navire.id_navire, navire.name having navire.categorie between 3 and 5;
