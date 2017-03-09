# Base off the Docker container that includes Alpine for installing packages.
FROM ntc-registry.githost.io/nextthingco/chiptainer_alpine

# Install tools needed to download and build the CHIP_IO library from source.
RUN apk update && apk add make && apk add gcc && apk add g++ && \
	apk add flex && apk add bison && apk add git && \
        # Download python and tools for installing libraries
        apk add python-dev && apk add py-setuptools && \
        # Download the chip-dt-overlays package
        apk add chip-dt-overlays && \
        # Download the latest CHIP_IO source code
        git clone https://github.com/xtacocorex/CHIP_IO.git && \
        # Install the CHIP_IO library from the proper directory
        cd CHIP_IO && python setup.py install && \
        # Remove CHIP_IO source code directory after it has been installed
        cd ../ && rm -rf CHIP_IO && \
        # Remove build tools, which are no longer needed after installation
        apk del git && apk del make && apk del gcc && apk del g++ && apk del flex && apk del bison

ENTRYPOINT /bin/sh
