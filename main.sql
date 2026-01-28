CREATE DATABASE datalendo_db;


-- PARTIE 1 : EXPLOIRATION DES DONNÉES

--Etape 1 : Compter les lignes

-- Compter le nombre de clients
SELECT COUNT(*) AS total_clients
FROM clients;

-- Compter le nombre de ventes
SELECT COUNT(*) AS total_ventes
FROM ventes;

-- Compter le nombre de produits
SELECT COUNT(*) AS total_produits
FROM produits;

-- Compter le nombre de paiements
SELECT COUNT(*) AS total_paiements
FROM paiements;


-- Etape 2 : Afficher un échantillon

-- Voir les 5 premiers clients
SELECT *
FROM clients
LIMIT 5;

-- Voir les 5 premières ventes
SELECT *
FROM ventes
LIMIT 5;

-- Voir les 5 premiers produits
SELECT *
FROM produits
LIMIT 5;

-- Voir les 5 premiers paiements
SELECT *
FROM paiements
LIMIT 5;


-- Etape 3 : Vérifier les colonnes importantes
-- Voir les pays des clients
SELECT DISTINCT pays
FROM clients;

-- Vérifier les méthodes de paiement
SELECT DISTINCT methode, statut
FROM paiements;

-- Vérifier les catégories de produits
SELECT DISTINCT categorie
FROM produits;


-- Etape 4 : Statistiques simples
-- Montant total des ventes
SELECT SUM(montant_total) AS chiffre_affaires_total
FROM ventes;

-- Moyenne du montant des ventes
SELECT AVG(montant_total) AS panier_moyen
FROM ventes;

-- Vente maximale
SELECT MAX(montant_total) AS vente_max
FROM ventes;

-- Vente minimale
SELECT MIN(montant_total) AS vente_min
FROM ventes;

