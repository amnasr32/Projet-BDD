/* une requete pour recuperer les noms des navires qui n'ont effectue aucun voyage court avec leurs nationnalité */
/* requete avec jointure*/

select
    navire.name, navire.nationalite
from
    voyage join navire  on voyage.id_navire = navire.id_navire
where
    not exists ( select * from voyage voy2 where voy2.id_navire=voyage.id_navire and voy2.type_voyage='court');