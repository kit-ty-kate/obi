#!/bin/bash -e

rev=$1
srev=`echo $rev | cut -c1-6`
echo 'steps:'

build() {
  distro=$1
  ov=$2
  cat <<EOL
- trigger: "opam-bulk"
  label: ":docker: $distro :camel: $ov :github: $srev"
  build:
    env:
      DISTRO: "$distro"
      OCAML_VERSION: "$ov"
      OPAM_REPO_REV: "$rev"
EOL
}

build "debian-9" "4.07"
build "debian-9" "4.06"
build "debian-9" "4.06+default-unsafe-string"
build "debian-9" "4.06+flambda"
build "debian-9" "4.05"
build "debian-9" "4.04"
build "debian-9" "4.03"
build "alpine-3.7" "4.06"
build "ubuntu-18.04" "4.06"
build "fedora-27" "4.06"

cat <<EOL
- wait
- trigger: "obi-index"
  label: "Update Obi Index"
EOL
