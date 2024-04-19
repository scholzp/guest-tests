{ catch2_3
, cmake
, gcc11
, nix-gitignore
, stdenv
}:

stdenv.mkDerivation {
  pname = "guest-tests";
  version = "1.0.0";

  src = nix-gitignore.gitignoreSourcePure [
    # If you're testing around with the test properties, it is handy to add
    # this exclude to see quicker results. Otherwise, the whole CMake
    # project needs a rebuild.
    # "tests/**/properties.toml"
  ] ../src;

  doCheck = true;
  checkInputs = [ catch2_3 ];

  nativeBuildInputs = [
    cmake
    gcc11 # keep in sync with CI file
  ];

  # The ELFs are standalone kernels and don't need to go through these. This
  # reduces the number of warnings that scroll by during build.
  dontPatchELF = true;
  dontFixup = true;
}
