drop table if exists navire cascade;
drop table if exists voyage cascade ;
drop table if exists port cascade ;
drop table if exists nation cascade ;
drop table if exists relation_deplomatique cascade ;
drop table if exists passagers  cascade ;
drop table if exists etape_transitoire  cascade ;
drop table if exists cargaison  cascade ;
drop table if exists produit  cascade ;
drop table if exists categorie_produit  cascade ;



create table nation (
    name text primary key
);

create table port (
    name text  primary key,
    localisation text  not null,
    nationnalite text not null,
    categorie integer not null,
    check ( categorie BETWEEN 1 AND 5 ),
    foreign key (nationnalite) references nation(name)
);
create table navire (
    id_navire integer primary key,
    name text not null,
    type text not null,
    categorie integer not null,
    nationalite text not null, 
    vol_marchandise_max integer,
    nb_passagers_max integer,
    mouille text not null,
    check ( categorie BETWEEN 1 AND 5 ),
    /*check (categorie <= port(categorie) ),*/
    foreign key (mouille) references port(name),
    foreign key (nationalite) references nation(name)
    /* un navire mouille dans un port, on verra comment on doit le représenter*/
);

/* une cargaison appartient à un navire, donc cargaison(volume)<=navire(vol_marchandise_max) */
create table cargaison(
    id_cargaison integer primary key,
    regroupe integer,
    vol_max integer not null, /* volume max de la cargaison qui est le volume max de marchandise d'un navire*/
    vol_encours integer not null, /* volume après chaque etape transitoire  */
    check (vol_max >= vol_encours),
    vol_achete integer,
    vol_vendu integer ,
   check (((vol_max-(vol_vendu+vol_achete)) <= vol_max) AND ((vol_max-(vol_vendu+vol_achete)) >= 0))
); 
create table passagers(
    id_pass integer primary key,
    nb_max integer not null,
    nb_encours integer not null,
    check (nb_max >= nb_encours),
    nb_pris integer not null,
    nb_depose integer not null,
     check (((nb_max-(nb_depose+nb_pris)) <= nb_max) AND ((nb_max-(nb_depose+nb_pris)) >= 0))
);

/* j'ai relié la cargaison au voyage et non au navire, car les changement de la cargaison (vente/achat)
changent selon le voyage/etape_transitoires du voyage et non selon le navire */

create table voyage(
    id_voyage integer primary key,
    id_navire integer not null, /* references id_navire dans navire */
    provenance text  not null,
    destination text not null,
    distance integer not null,
    date_debut date not null,
    date_fin date not null,
    check ( date_fin > date_debut ),
    duree integer not null,
    classe text not null,  /*  la classe est le continent du port de destination*/
    etat_voyage text not null, /*  supprimé, effectué, en cours*/
    check (etat_voyage in ('encours','effectue','supprime')),
    type_voyage text not null,
    check (type_voyage in ('court','long','moyen')),
    cargaison integer not null, /* un autre voyage ne peut pas avoir la meme cargaison, elle est unique*/
   /* check ( cargaison(vol_initial) <= navire(vol_marchandise) ),*/
    passagers integer not null ,
    foreign key (passagers) references passagers(id_pass),
    foreign key (cargaison) references cargaison(id_cargaison),
    foreign key (id_navire) references navire(id_navire),
    foreign key (provenance) references port (name),
    foreign key (destination) references port(name)
);



/*  une etape transitoir een realité est un port où un voyage fait une etape tarnsitoire
donc on va la représenter par un port, nation et un voyage
*/

create table etape_transitoire( 
    id_etape integer primary key,
    name_port text not null,
    id_voyage integer not null,
    cargaison integer not null,
    passagers integer not null,
    foreign key (passagers) references passagers(id_pass),
    foreign key (cargaison) references cargaison(id_cargaison),
    foreign key ( name_port) references port(name),
    foreign key (id_voyage) references voyage(id_voyage)
);


create table categorie_produit(
    id_cat integer primary key,
    name text not null,
    prix_kg integer not null,
    conservation integer not null
);
/*
clé primaire : (id_produit,cargaison), pour pouvoir distinguer les produit selon leurs quantité dans 
chaque cargaison
*/

create table produit(
    id_produit text,
    name text not null,
    type bool not null, /* true si produit sec, false si périssable */
    quantite integer not null,
    categorie integer not null,
    cargaison integer not null, /* un produit peut appartenir à une cargaison ou non (null) */
    primary key (id_produit,cargaison),
    foreign key (cargaison) references cargaison(id_cargaison),
    foreign key (categorie) references categorie_produit(id_cat)
);


create table relation_deplomatique(
    nation1 text not null,
    nation2 text not null,
    check (nation1 <> nation2),
    relation text not null,
    check ( relation in ('allies commerciaux', 'neutre','en guerre')),
    primary key (nation1,nation2),
    foreign key (nation1) references nation(name),
    foreign key (nation2) references nation(name)
); 



-- remplissage des tables

\COPY nation FROM './CSV/nation.csv' WITH (DELIMITER ',',FORMAT csv,HEADER true)
\COPY port FROM './CSV/port.csv' WITH (DELIMITER ',',FORMAT csv,HEADER true)
\COPY navire FROM './CSV/navire.csv' WITH (DELIMITER ',',FORMAT csv,HEADER true)
\COPY cargaison FROM './CSV/cargaison.csv' WITH (DELIMITER ',',FORMAT csv,HEADER true)
\COPY passagers FROM './CSV/passagers.csv' WITH (DELIMITER ',',FORMAT csv,HEADER true)
\COPY voyage FROM './CSV/voyage.csv' WITH (DELIMITER ',',FORMAT csv,HEADER true)
\COPY etape_transitoire FROM './CSV/etape_transitoire.csv' WITH (DELIMITER ',',FORMAT csv,HEADER true)
\COPY categorie_produit FROM './CSV/categorie_produit.csv' WITH (DELIMITER ',',FORMAT csv,HEADER true)
\COPY produit FROM './CSV/produit.csv' WITH (DELIMITER ',',FORMAT csv,HEADER true)
\COPY relation_deplomatique FROM './CSV/relation_deplomatique.csv' WITH (DELIMITER ',',FORMAT csv,HEADER true)




