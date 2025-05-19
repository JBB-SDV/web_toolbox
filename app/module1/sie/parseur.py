import os
import json
from datetime import datetime

# Constantes des chemins et des textes
CHEMINS_FICHIERS = {
    "R1": "/tmp/module1/output/output_r1",
    "R2": "/tmp/module1/output/output_r2",
    "R3": "/tmp/module1/output/output_r3",
    "R4": "/tmp/module1/output/output_r4",
    "R5": "/tmp/module1/output/output_r5",
    "R6": "/tmp/module1/output/output_r6",
    "R7": "/tmp/module1/output/output_r7",
    "R8": "/tmp/module1/output/output_r8",
    "R9": "/tmp/module1/output/output_r9",
    "R10": "/tmp/module1/output/output_r10",
    "R11": "/tmp/module1/output/output_r11",
    "R12": "/tmp/module1/output/output_r12",
    "R13": "/tmp/module1/output/output_r2"  # Même que R2
}

TEXTES_RECHERCHES = {
    "R2": "Votre configuration de connexion ssh correspond aux normes demandées",
    "R3": "Dépôt NON officiel : ",
    "R4": "Attention la politque de mot de passe n'est pas appliqué !!",
    "R6": "Tous les comptes sont correctement sécurisés !",
    "R9": "Aucun antivirus n'est installé !",
    "R11": "Aucun fichier sans utilisateur ou groupe trouvé"
}

# Fonction pour vérifier si le fichier est vide
def est_fichier_vide(chemin_fichier):
    if os.path.exists(chemin_fichier) and os.path.getsize(chemin_fichier) == 0:
        return "NOK"
    return "OK"

# Fonction pour vérifier si un fichier contient un texte (ou pas)
def contient_texte(chemin_fichier, texte, doit_absent=False):
    """Retourne OK si :
    - `texte` est trouvé et `doit_absent=False`
    - `texte` est absent et `doit_absent=True`
    Sinon retourne NOK.
    """
    if not os.path.exists(chemin_fichier):
        return "NOK"
    
    try:
        with open(chemin_fichier, "r", encoding="utf-8") as fichier:
            contenu = fichier.read()
            contient = texte in contenu
            return "OK" if (contient and not doit_absent) or (not contient and doit_absent) else "NOK"
    except Exception as e:
        return f"Erreur: {e}"

# Création du dictionnaire de résultats
resultats = {
    "global": {
        "cible": "127.0.0.1",
        "date": datetime.now().strftime("%Y-%m-%d")
    },
    "test": {
        "R1": "jsp",
        "R2": contient_texte(CHEMINS_FICHIERS["R2"], TEXTES_RECHERCHES["R2"]),
        "R3": contient_texte(CHEMINS_FICHIERS["R3"], TEXTES_RECHERCHES["R3"], doit_absent=True),  # OK si absent
        "R4": contient_texte(CHEMINS_FICHIERS["R4"], TEXTES_RECHERCHES["R4"], doit_absent=True),  # OK si absent
        "R5": "jsp",
        "R6": contient_texte(CHEMINS_FICHIERS["R6"], TEXTES_RECHERCHES["R6"]),
        "R7": "jsp",
        "R8": "jsp",
        "R9": contient_texte(CHEMINS_FICHIERS["R9"], TEXTES_RECHERCHES["R9"], doit_absent=True),  # OK si absent
        "R10": "jsp",
        "R11": contient_texte(CHEMINS_FICHIERS["R11"], TEXTES_RECHERCHES["R11"]),
        "R12": "jsp",
        "R13": contient_texte(CHEMINS_FICHIERS["R13"], TEXTES_RECHERCHES["R2"])
    }
}


#est_fichier_vide(CHEMINS_FICHIERS["R1"]),


#with open("app/json/mod1.json", "w") as fichier_json:
with open("/tmp/module1/mod1.json", "w") as fichier_json:
    json.dump(resultats, fichier_json, indent=4)

# Affichage du JSON généré
print(json.dumps(resultats, indent=4))
