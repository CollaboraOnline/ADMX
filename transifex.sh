#!/bin/bash

read -p "Enter Transifex user name: " user
read -s -p "Password: " password
url="https://www.transifex.com/api/2/project/collabora-office-libreoffice-windows-group-policy-template-amdx/resource/collabora-office-admlpot/translation"
declare -a langs=("it" "hu" "fr" "es" "de" "pt_BR" "tr")

for i in ${langs[@]}
do
	l10nUrl="$url/$i/?mode=default&file"
	connectionResponse=$(curl -L --user $user:$password -X GET $l10nUrl);
	if [ "Authorization Required" == "${connectionResponse}" ]; then
		echo -e "\nERROR - $connectionResponse - ERROR\n"
		exit 1
	else
		if [ $i = "pt_BR" ]; then
			dir="pt-BR"
		else
			dir="$i-*"
		fi
		curl -L --user $user:$password -X GET $l10nUrl -o $i.po
		msgfmt -cvo $i.mo $i.po
		itstool -m $i.mo -o $dir en-US/Collabora-Office.adml
		unix2dos $dir/Collabora-Office.adml
		rm $i.po $i.mo
	fi
done

patch -p1 << 'EOF'
diff --git b/fr-FR/Collabora-Office.adml a/fr-FR/Collabora-Office.adml
index 89663f7..ddf5d23 100644
--- b/fr-FR/Collabora-Office.adml
+++ a/fr-FR/Collabora-Office.adml
@@ -1,5 +1,7 @@
 <?xml version="1.0" encoding="utf-8"?>
 <!-- (c) 2015 Collabora Ltd. CC-BY-SA 4.0 -->
+<!-- Traduction Française (c) 2016 Thierry BOULESTIN - Ministère l'Écologie
+     rapporter un bogue ou une amélioration à thierry.boulestin@developpement-durable.gouv.fr -->
 <policyDefinitionResources revision="1.0" schemaVersion="1.0">
   <displayName>
   </displayName>
diff --git b/it-IT/Collabora-Office.adml a/it-IT/Collabora-Office.adml
index 943a5f8..bb79d73 100644
--- b/it-IT/Collabora-Office.adml
+++ a/it-IT/Collabora-Office.adml
@@ -1,5 +1,7 @@
 <?xml version="1.0" encoding="utf-8"?>
 <!-- (c) 2015 Collabora Ltd. CC-BY-SA 4.0 -->
+<!-- Italian Translation (c) 2015 Marina Latini - Studio Storti srl CC-BY-SA 4.0
+     report bugs or improvements to marina@studiostorti.com -->
 <policyDefinitionResources revision="1.0" schemaVersion="1.0">
   <displayName>
   </displayName>
EOF
