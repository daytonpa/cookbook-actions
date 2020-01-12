FROM daytonpa/chefdk:2

RUN mkdir -p /scripts

COPY scripts /scripts/
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ \
  "/entrypoint.sh" \
]
