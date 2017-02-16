# CHIPtainer Example: Python with CHIP_IO library

This is a Docker file for building a container that includes Python as well as the CHIP_IO library for interfacing with GPIO, PWM, and ADC.

You must run this container from a CHIP that has Docker installed. To begin, log in to the NTC Docker account:

```
docker login ntc-registry.githost.io
```

Then download the latest image:

```
docker pull ntc-registry.githost.io/nextthingco/chiptainer_python_io:master
```

Now run the Docker container, allowing access to the GPIO directories, device memory, and the raw IO.

```
docker run -v /sys:/sys --cap-add SYS_RAWIO --device /dev/mem -it ntc-registry.githost.io/nextthingco/chiptainer_python_io:master
```

To test, you can try setting the LCD-D5 pin value on CHIP. First, launch Python:

```
python
```

Then issue the commands to set the pin HIGH:

```
import CHIP_IO.GPIO as GPIO
GPIO.setup("LCD-D5", GPIO.OUT)
GPIO.output("LCD-D5", GPIO.HIGH)
```
