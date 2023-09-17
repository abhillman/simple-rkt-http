with import <nixpkgs> { };
stdenv.mkDerivation {
  name = "simple-rkt-http";
  buildInputs = [
    racket-minimal
  ];
}
