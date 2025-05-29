{ pkgs, wineprefix ? "", winearch ? "win32", fonts ? "corefonts cjkfonts" }:

let
  exe = pkgs.fetchurl {
    url = "https://app-pc.kakaocdn.net/talk/win32/KakaoTalk_Setup.exe";
    sha256 = "sha256-bTXhVo+nWctFxckR/nvD7ThZODozS/cYxi8jPb8Si7I=";
  };
in

pkgs.writeShellScriptBin "install-kakaotalk" ''
  PREFIX=${wineprefix}
  if [[ -z "${wineprefix}" ]]; then
    PREFIX=$(mktemp -d)
    echo PREFIX="$PREFIX"
  fi
  echo Install kakaotalk from ${exe}...
  if [[ -z "${fonts}" ]]; then
    echo Skip winetricks
  else
    WINEPREFIX=$PREFIX WINEDLLOVERRIDES="mscoree,mshtml=" WINEARCH=${winearch} ${pkgs.winetricks}/bin/winetricks ${fonts}
  fi
  WINEPREFIX=$PREFIX WINEDLLOVERRIDES="mscoree,mshtml=" WINEARCH=${winearch} ${pkgs.wineWowPackages.full}/bin/wine ${exe}
''