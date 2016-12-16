
VERSION := $(shell grep "version " version.txt | sed -E 's/.*"(.+)"$$/\1/')

INSTALL_PATH=$(GOPATH)/src/github.com/samsabra/philrs232

deps:
	go get github.com/mtibben/gogpm
	go get github.com/tcnksm/ghr
	go get github.com/mitchellh/gox
	$(GOPATH)/bin/gogpm install

build:
	$(GOPATH)/bin/gox -output "bin/{{.Dir}}_${VERSION}_{{.OS}}_{{.Arch}}" -os="linux" -os="darwin" -arch="386" -arch="amd64" ./

release:
	$(GOPATH)/bin/ghr --username samsabra --token ${GITHUB_TOKEN} -r philrs232 --replace ${VERSION} bin/

clean:
	@test ! -e bin/|| rm -f bin/*