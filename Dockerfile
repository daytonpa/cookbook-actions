FROM chef/chefdk:3

RUN /bin/sh -c mkdir -p /scripts

COPY scripts /scripts/
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ \
  "/entrypoint.sh" \
]
