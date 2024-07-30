{
  buildNpmPackage,
  fetchFromGitHub,
  importNpmLock,
  pnpm,
  nodejs,
  stdenv
}:

stdenv.mkDerivation (finalAttrs: rec {
  pname = "language-tools";
  version = "2.0.26";

  src = fetchFromGitHub {
    owner = "vuejs";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-Fb7yovVykMYVYn4TG85Ipgvj7IvX6RCU1GS5GYVbidA=";
  };

  nativeBuildInputs = [
    nodejs
    pnpm
    pnpm.configHook
  ];

  pnpmDeps = pnpm.fetchDeps {
    inherit (finalAttrs) pname version src;
    hash = "sha256-ThgVY66YRQ+MI2kXAqStkH55UFvHNigifJ7ke6TyEdM=";
  };

  buildPhase = ''
  # pnpm run build
  pnpm install @lerna-lite/run -D
  pnpm lerna run build -w
  '';

  installPhase = ''
  mkdir -p $out/lib/node_modules/@vue/
  cp -r ./packages/typescript-plugin $out/lib/node_modules/@vue/
  rm -rf $out/lib/node_modules/@vue/typescript-plugin/node_modules
  '';
})

# buildNpmPackage rec {
#   pname = "language-tools";
#   version = "2.0.26";
#
#   src = fetchFromGitHub {
#     owner = "vuejs";
#     repo = pname;
#     rev = "v${version}";
#     hash = "sha256-Fb7yovVykMYVYn4TG85Ipgvj7IvX6RCU1GS5GYVbidA=";
#   };
#
#   pnpmDeps = pnpm.fetchDeps {
#     pname = pname; 
#     version = version; 
#     src = src;
#
#     hash = "";
#   };
#
#   npmConfigHook = importNpmLock.npmConfigHook;
#
#   # The prepack script runs the build script, which we'd rather do in the build phase.
#   # npmPackFlags = [ "--ignore-scripts" ];
#   # NODE_OPTIONS = "--openssl-legacy-provider";
#
#   meta = {
#   };
# }
#
