#15/05/2024 par Dr Hamid MADANI
# how to use : sudo ./mka2ensite.sh amia.fr chales
#!/bin/bash

# Vérifier si le nombre d'arguments est correct
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <nom_du_site> <nom_du_store>"
    exit 1
fi

# Récupérer le nom du site et du store à partir des arguments
nom_du_site="$1"
nom_du_store="$2"
nom_du_repertoire="/etc/apache2/sites-available"



# Copier les fichiers de configuration originaux
cp "${nom_du_repertoire}/template_site.conf" "${nom_du_repertoire}/${nom_du_store}.${nom_du_site}.conf"
cp "${nom_du_repertoire}/template_site-ssl.conf" "${nom_du_repertoire}/${nom_du_store}.${nom_du_site}-ssl.conf"

# Modifier les fichiers de configuration en fonction du nom du site et du store
sed -i "s/site/${nom_du_site}/g" "${nom_du_repertoire}/${nom_du_store}.${nom_du_site}.conf"
sed -i "s/site/${nom_du_site}/g" "${nom_du_repertoire}/${nom_du_store}.${nom_du_site}-ssl.conf"
sed -i "s/store/${nom_du_store}/g" "${nom_du_repertoire}/${nom_du_store}.${nom_du_site}.conf"
sed -i "s/store/${nom_du_store}/g" "${nom_du_repertoire}/${nom_du_store}.${nom_du_site}-ssl.conf"

echo "Les fichiers de configuration ont été créés et modifiés pour le site ${nom_du_store}.${nom_du_site} avec le store ${nom_du_store}"

# Activation du site
a2ensite "${nom_du_store}.${nom_du_site}.conf"
a2ensite "${nom_du_store}.${nom_du_site}-ssl.conf"

echo "Activation du site"

# Redémarrage du service Apache
systemctl restart apache2

echo "Redemarrage du serveur"
