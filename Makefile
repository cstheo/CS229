TEX_IMAGE ?= cs229-tex:2026
DOCKER ?= docker
SETS := ps1 ps2 ps3
AUX_EXTS := aux log out fls fdb_latexmk synctex.gz

.PHONY: pdf $(SETS) image clean

pdf: $(SETS)

image: Dockerfile .dockerignore
	$(DOCKER) build --network=none -t "$(TEX_IMAGE)" .

$(SETS):
	$(DOCKER) run --rm --pull=never --network=none \
		-v "$(CURDIR)/$@/questions:/work" "$(TEX_IMAGE)" \
		-pdf -synctex=1 -interaction=nonstopmode -halt-on-error $@.tex

clean:
	rm -f $(foreach ps,$(SETS),$(addprefix $(ps)/questions/$(ps).,$(AUX_EXTS)))
