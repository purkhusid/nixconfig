{ pkgs ? import <nixpkgs> {} }:

# To make use of this derivation, use
# `programs.zsh.promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";`

pkgs.stdenv.mkDerivation rec {
  name = "powerlevel10k-${version}";
  version = "2019-08-26";
  src = pkgs.fetchFromGitHub {
    owner = "romkatv";
    repo = "powerlevel10k";
    rev = "613b1a646eae3deb964d7d69aa986c78a5986542";
    sha256 = "0g927va2mgszxx7m7v8nxi9b4zy1yvzh4nmydpnxp3zcghsw11xk";
  };

  phases = ["installPhase"];

  installPhase= ''
    mkdir -p $out/share/zsh-powerlevel10k
    ln -s $src/* $out/share/zsh-powerlevel10k
    ls -la $out/share/zsh-powerlevel10k
  '';

  meta = {
    description = "A beautiful theme for zsh";
    homepage = https://github.com/romkatv/powerlevel10k;
    license = pkgs.stdenv.lib.licenses.mit;

    platforms = pkgs.stdenv.lib.platforms.unix;
  };
}