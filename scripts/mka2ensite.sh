#15/05/2024 par Dr Hamid MADANI
#!/bin/bash

# Vérifier si le nombre d'arguments est correct
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <nom_du_site>"
    exit 1
fi

# Récupérer le nom du site à partir des arguments
nom_du_site="$1"
nom_du_repertoire="/etc/apache2/sites-available/"


# Copier les fichiers de configuration
cp "${nom_du_repertoire}origin.conf" "${nom_du_repertoire}${nom_du_site}.conf"
cp "${nom_du_repertoire}origin-ssl.conf" "${nom_du_repertoire}${nom_du_site}-ssl.conf"

# Modifier les fichiers de configuration en fonction du nom du site
sed -i "s/origin/${nom_du_site}/g" "${nom_du_repertoire}${nom_du_site}.conf"
sed -i "s/origin/${nom_du_site}/g" "${nom_du_repertoire}${nom_du_site}-ssl.conf"

echo "Les fichiers de configuration ont été créés et modifiés pour le site ${nom_du_site}"

# Activation du site
a2ensite "${nom_du_site}.conf"
a2ensite "${nom_du_site}-ssl.conf"

echo "Activation du site"

# Redémarrage du service Apache
systemctl restart apache2

echo "Redemarrage du serveur"
