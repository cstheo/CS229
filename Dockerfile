FROM texlive/texlive@sha256:9a17987fc172aac80abbbc1f8b9a7b01f6f3012fa49bd03914db72b5ac0eac58

WORKDIR /work
ENTRYPOINT ["latexmk"]
