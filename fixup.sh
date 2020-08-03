#!/usr/bin/env bash

set -x

# see: https://github.com/elastic/logstash/issues/10755

VERSION=9.2.11.1
PLATFORM=aarch64

JARDIR="/usr/share/logstash/logstash-core/lib/jars"
JAR="jruby-complete-${VERSION}.jar"

META_INF="META-INF"
ARCH_LINUX="${META_INF}/jruby.home/lib/ruby/stdlib/ffi/platform/aarch64-linux/"

cd ${JARDIR}
jar -xvf ${JAR} ${ARCH_LINUX}
if [ ! -f "${ARCH_LINUX}/platform.conf" ]; then
    cp "${ARCH_LINUX}/types.conf" "${ARCH_LINUX}/platform.conf"
    echo "platform.conf" >> ${ARCH_LINUX}/.jrubydir

    jar -uvf ${JAR} ${META_INF}
    chown -R logstash:root ${JAR}
fi
rm -rf ${META_INF}
