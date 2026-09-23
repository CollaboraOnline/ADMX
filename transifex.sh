#!/bin/bash
#
# Pull the translations from Transifex and merge them into the ADML files.
#
# Needs the Transifex CLI (https://developers.transifex.com/docs/cli), msgfmt
# and itstool. The CLI reads the API token from ~/.transifexrc or from the
# TX_TOKEN environment variable, see
# https://developers.transifex.com/docs/cli#authentication
# The project and the resource are configured in .tx/config.

set -e
cd "$(dirname "$0")"

declare -a langs=("cs" "de" "es" "fr" "hu" "it" "pt_BR" "tr")

tx pull --translations --force --languages "$(IFS=,; echo "${langs[*]}")"

for i in "${langs[@]}"
do
	if [ "$i" = "pt_BR" ]; then
		dir="pt-BR"
	else
		dir=$(echo "$i"-*)
	fi
	po="translations/$i.po"
	msgfmt -cvo "$i.mo" "$po"
	itstool -i adml.its -m "$i.mo" -o "$dir" en-US/Collabora-Office.adml
	rm "$i.mo"
done
rm -rf translations

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
