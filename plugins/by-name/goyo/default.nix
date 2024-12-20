{
  lib,
  helpers,
  ...
}:
with helpers.vim-plugin;
with lib;
mkVimPlugin {
  name = "goyo";
  packPathName = "goyo.vim";
  package = "goyo-vim";
  globalPrefix = "goyo_";

  maintainers = [ maintainers.GaetanLepage ];

  # TODO introduced 2024-03-01: remove 2024-05-01
  deprecateExtraConfig = true;
  optionsRenamedToSettings = [
    "width"
    "height"
  ];
  imports = [
    (mkRenamedOptionModule
      [
        "plugins"
        "goyo"
        "showLineNumbers"
      ]
      [
        "plugins"
        "goyo"
        "settings"
        "linenr"
      ]
    )
  ];

  settingsOptions = {
    width = helpers.mkNullOrOption types.ints.unsigned "width";

    height = helpers.mkNullOrOption types.ints.unsigned "height";

    linenr = helpers.defaultNullOpts.mkFlagInt 0 ''
      Show line numbers when in Goyo mode.
    '';
  };
}
