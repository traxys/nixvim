{
  self,
  pkgs,
  ...
}:
pkgs.runCommand "check-line-len" {} ''
  matches=$(
    cd ${self} && ${pkgs.fd}/bin/fd -e nix \
      -x ${pkgs.ripgrep}/bin/rg -ilU --pcre2 '(?<!#skip long line)\n.{101}' {}
  ) || true

  if [[ -n $matches ]]; then
    {
      echo "$matches"
      echo "Some files contain lines that are too long"
      echo "Use '# skip long line' on the previous line to allow it"
    } >&2
    exit 1
  fi

  touch $out
''
