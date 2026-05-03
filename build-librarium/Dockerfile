FROM alpine:3.20

COPY scripts/init-librarium.sh /usr/local/bin/init-librarium

RUN chmod +x /usr/local/bin/init-librarium

ENV HEX_LIBRARIUM=/hex/librarium

ENTRYPOINT ["init-librarium"]
CMD ["sh", "-c", "find \"$HEX_LIBRARIUM\" -maxdepth 3 -type d -print"]
