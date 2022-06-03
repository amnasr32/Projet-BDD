/*requete qui retourne les produits avec la date de conservation la plus longues*/
select distinct 
    produit.name,produit.categorie 
from 
    produit 
where 
    produit.categorie IN 
        (select id_cat from categorie_produit where conservation=(select max(conservation) from categorie_produit ));
