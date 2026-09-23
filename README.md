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
[ITS Tool](http://itstool.org) is used to extract strings from the adml file,
and merge them back. The very simple `adml.its` file in this repository sets
one `preserveSpaceRule`; pass it with `-i adml.its`.

### Updating the pot file

After changing strings in `en-US/Collabora-Office.adml`, regenerate the pot:

    itstool -i adml.its -o en-US/Collabora-Office-adml.pot en-US/Collabora-Office.adml

If the pot is not picked up by Transifex automatically, upload it with the
Transifex CLI (see below):

    tx push --source

### Updating translations from Transifex

One-time setup:

1. Install the [Transifex CLI](https://developers.transifex.com/docs/cli),
   for example:

       mkdir -p ~/.local/bin
       curl -sL https://github.com/transifex/cli/releases/download/v1.6.17/tx-linux-amd64.tar.gz | tar -xz -C ~/.local/bin tx
       tx --version

   Make sure `~/.local/bin` is in your `PATH`. `msgfmt` (gettext) and
   `itstool` are needed too.

2. Create an API token at https://app.transifex.com/user/settings/api/ and
   put it into `~/.transifexrc`:

       [https://app.transifex.com]
       rest_hostname = https://rest.api.transifex.com
       token = <your token>

   Alternatively, pass it in the `TX_TOKEN` environment variable.

The project and the resource are configured in `.tx/config`. To update the
translations, run:

    ./transifex.sh

It pulls the translations into `translations/` (ignored by git and removed
at the end), merges each of them into its adml file with itstool, and adds
back the credits of the French and Italian translators. Check the result
before committing:

    xmllint --noout */Collabora-Office.adml
    git diff --stat
