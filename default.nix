{
  lib,
  stdenv,
  openjdk,
  bash,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "hello-java";
  version = "0.1.0";

  src = lib.cleanSource ./.;

  nativeBuildInputs = [
    openjdk
  ];

  java = openjdk;

  dontConfigure = true;

  buildPhase = ''
    runHook preBuild

    javac Main.java
    jar cfm hello.jar manifest.mf Main.class

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/libexec/hello

    substituteAll ./hello.sh.in $out/bin/hello-java

    chmod +x $out/bin/hello-java

    cp hello.jar $out/libexec/hello

    runHook postInstall
  '';

  meta = {
    description = "Hello world";
    homepage = "https://github.com/RossComputerGuy/cis233j-hello";
    licenses = with lib.licenses; [ Unlicense ];
    maintainers = with lib.maintainers; [ RossComputerGuy ];
  };
})
