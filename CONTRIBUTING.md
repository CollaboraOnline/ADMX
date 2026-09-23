# Contributing

Pull requests are welcome. By contributing you agree that your work is
licensed under [CC-BY-SA 4.0](LICENSE), the license of this repository.

## Supported products

The template is used with Collabora Office Classic, Collabora Office and
LibreOffice. Before adding or changing a policy, check that the
configuration setting exists in the `officecfg/registry/schema` of these
products, and that the code actually reads it.

When a setting only takes effect in some of the products, say so at the end
of the policy description, for example:

    This setting only takes effect in Collabora Office Classic and LibreOffice.

## How policies map to the configuration

Every policy writes registry values under
`Software\Policies\LibreOffice\<configuration path>\<property>`, for example
`Software\Policies\LibreOffice\org.openoffice.Office.Common\Save\Document\CreateBackup`.
The value names are:

- `Value` (string): the value of the property. Booleans are written as
  `true` or `false`, numbers as text (use `storeAsText="true"` on
  `decimal` elements).
- `Final` (DWORD, optional): `1` makes the property read-only for the user.
- `Type`, `Nil`, `External`, `ExternalBackend` (optional): see the comment
  at the top of `configmgr/source/winreg.cxx` in the engine sources.

A policy that is not finalized only supplies a default: a value the user has
changed in the user profile takes precedence.

## Adding a policy

1. Add the `policy` to `Collabora-Office.admx`.
2. Add its strings and its `presentation` to **all** ADML files, not only to
   `en-US`. Use the English text in the other languages; the translators
   replace it later. A missing string or presentation breaks the template for
   everybody using that language, with an error like:

       Resource "$(string.something)" referenced in attribute displayName could not be found.

3. Change existing descriptions only in `en-US/Collabora-Office.adml`, the
   translations are updated through Transifex.
4. Check that all files are well-formed XML, for example with
   `xmllint --noout Collabora-Office.admx */Collabora-Office.adml`.

## Translations

Translations are done at
[Transifex](https://explore.transifex.com/collabora-productivity-ltd/collabora-office-libreoffice-windows-group-policy-template-amdx/).
Translations made there are merged into the ADML files from time to time. See the Localization notes in the
[README](README.md) for how the pot file is generated and how translations
are merged.
