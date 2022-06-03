/* requete qui donne les noms des nations qui ont envoyé des navires différents dans des destinations différentes telle que le pays 
de la destination est en guerre*/
/* sous requete dans where*/

select 
    nationalite 
from 
    navire 
where 
    id_navire in
    (select distinct
        id_navire 
    from 
        voyage 
    where 
        destination 
    in 
        (select distinct 
            port.name 
        from 
            port 
        where nationnalite in 
            (select nation1 from relation_deplomatique where relation='en guerre')));

