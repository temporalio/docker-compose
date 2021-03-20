# Dockerfile with tools that enhance container capabilities for better debugging and testing

FROM temporalio/auto-setup:1.7.0

# iproute2 contains tc, which can be used to inject traffic delay and failures.
RUN apk add iproute2

# Add any configuration that needs to run when container starts up in this file.
COPY configure.sh /configure.sh

# Now injecting configuration script before the service startup.
CMD /configure.sh && /start.sh autosetup
