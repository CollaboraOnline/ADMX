# ADMX
Collabora Office / LibreOffice Windows Group Policy Template

For more info visit https://www.collaboraoffice.com/windows-group-policy-admx/

Pull requests are welcome, see [CONTRIBUTING.md](CONTRIBUTING.md). Please help with translations at [Transifex](https://explore.transifex.com/collabora-productivity-ltd/collabora-office-libreoffice-windows-group-policy-template-amdx/).

The template is licensed under [CC-BY-SA 4.0](LICENSE).

## Installation

Copy `Collabora-Office.admx` into the `PolicyDefinitions` folder, and each
`<language>/Collabora-Office.adml` into the matching language subfolder, for
example `PolicyDefinitions\en-US`. For a domain, use the central store
`\\<domain>\SYSVOL\<domain>\Policies\PolicyDefinitions`; for a single
computer, `C:\Windows\PolicyDefinitions`.

Download the files themselves, either with the green "Code" button -
"Download ZIP", or by opening a file on GitHub and clicking "Download raw
file". Saving a file with "Save link as..." from the GitHub file list saves
the HTML web page instead, and the Group Policy Management Console then
fails with "DTD is prohibited". The `.admx` and `.adml` files must start with
`<?xml version="1.0" encoding="utf-8"?>`.

## Notes for contributors
See also [CONTRIBUTING.md](CONTRIBUTING.md).

### caution!
When you add a "policy" in the admx file, add the corresponding "presentation" in all adml. Not just in your language.
Otherwise, this causes the following error for users of these adml files:

Resource "$(string.something)" referenced in attribute displayName could not be found. 
File Path\to\something.admx, line xxx, column xxx

## Localization notes
[ITS Tool](http://itstool.org) is used to extract strings from adml file, and merge them back. The very simple `adml.its` file in this repository should be copied into e.g. `/usr/local/share/itstool/its/`. It sets one `preserveSpaceRule`.

Create the pot from the adml file:

    itstool -i adml.its -o en-US/Collabora-Office-adml.pot en-US/Collabora-Office.adml

Merge the translated strings to the adml file:

    itstool -m Collabora-Office-adml.mo -o it-IT/ Collabora-Office.adml
