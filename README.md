# ADMX
Collabora Office / LibreOffice Windows Group Policy Template

For more info visit https://www.collaboraoffice.com/windows-group-policy-admx/

Pull requests are welcome. Please help with translations at [Transifex](https://www.transifex.com/collabora-productivity-ltd/collabora-office-libreoffice-windows-group-policy-template-amdx/).

## Localization notes
[ITS Tool](http://itstool.org) is used to extract strings from adml file, and merge them back. The very simple `adml.its` file in this repository should be copied into e.g. `/usr/local/share/itstool/its/`. It sets one `preserveSpaceRule`.

Create the pot from the adml file:
    itstool -o LibreOffice-from-Collabora-adml.pot LibreOffice-from-Collabora.adml

Merge the translated strings to the adml file:
    itstool -m LibreOffice-from-Collabora-adml.mo -o it-IT/ LibreOffice-from-Collabora.adml
