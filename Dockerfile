# Base off the Docker container that includes Alpine for installing packages.
FROM ntc-registry.githost.io/nextthingco/chiptainer_alpine

# Install tools needed to download and build the CHIP_IO library from source.
RUN apk update && apk add make && apk add gcc && apk add g++ && \
	apk add flex && apk add bison && apk add git && \
        # Download python and tools for installing libraries
        apk add python-dev && apk add py-setuptools && \
        # Download source code for device tree compiler needed for CHIP_IO
        git clone https://github.com/atenart/dtc.git && \
        # Build and install the device tree compiler
        cd dtc && make && make install PREFIX=/usr && \
        # Remove the device tree compiler source code now that we've built it
        cd .. && rm dtc -rf && \
        # Download the latest CHIP_IO source code
        git clone https://github.com/xtacocorex/CHIP_IO.git && \
        # Install the CHIP_IO library from the proper directory
        cd CHIP_IO && python setup.py install && \
        # Remove CHIP_IO source code directory after it has been installed
        cd ../ && rm -rf CHIP_IO && \
        # Remove build tools, which are no longer needed after installation
        apk del git && apk del make && apk del gcc && apk del g++ && apk del flex && apk del bison

ENTRYPOINT /bin/sh
