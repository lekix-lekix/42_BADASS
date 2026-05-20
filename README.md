# 🌐 42_BADASS
 
> Projet réalisé dans le cadre du cursus **42 Paris** — exploration des protocoles réseau avancés via GNS3.
 
---
 
## 📋 Description
 
BADASS (**B**GP **A**t **D**oors **A**nd **S**witches **S**cale) est un projet réseau qui explore les protocoles de routage dynamique et les technologies d'overlay réseau.  
L'ensemble de l'infrastructure est simulée dans **GNS3**.
 
---
 
## 📚 Concepts abordés
 
| Technologie | Rôle |
|---|---|
| **OSPF** | Routage dynamique interne (IGP) - découverte automatique des routes |
| **BGP** | Routage inter-AS (EGP) - échange de routes entre systèmes autonomes |
| **VXLAN** | Overlay network - encapsulation L2 over L3, isolation des réseaux virtuels |
 
---

 
## 🛠️ Prérequis
 
- **GNS3** installé avec le serveur local ou VM
- Images routeurs compatibles (FRRouting)
- Wireshark (recommandé pour l'analyse des trames)
---
 
## 🚀 Utilisation
 
1. Ouvrir GNS3 et importer le projet (`.gns3project`)
2. Démarrer tous les équipements
3. Lancer le script de configuration. Exemple pour la partie 2 :
```
sh config_machines.sh
``` 
5. Vérifier la convergence OSPF :
```
Router# show ip ospf neighbor
Router# show ip route ospf
```
5. Vérifier les sessions BGP :
```
Router# show bgp summary
Router# show bgp neighbors
```
6. Vérifier le tunnel VXLAN :
```
Router# show vxlan vtep
Router# show vxlan vni
```
 
---
 
## 📌 Points clés
 
- **OSPF** — protocole à état de lien (link-state), algorithme SPF de Dijkstra
- **BGP** — protocole à vecteur de chemin (path-vector), politique de routage flexible
- **VXLAN** — extension de VLAN sur IP, supporte jusqu'à 16 millions de segments (24 bits de VNI)
- Combinaison **OSPF + BGP** : OSPF comme IGP pour la connectivité underlay, BGP pour la propagation des routes overlay
 
