FROM openjdk:11-jre

RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

ENV INSTALLDIR /opt/server
ENV MC_VERSION 1.16.4
ENV FABRIC_VERSION 0.6.1.51

RUN pwd &&\
    mkdir $INSTALLDIR &&\
    wget -O $INSTALLDIR/fabric-installer.jar https://maven.fabricmc.net/net/fabricmc/fabric-installer/$FABRIC_VERSION/fabric-installer-$FABRIC_VERSION.jar &&\
    java -jar $INSTALLDIR/fabric-installer.jar server -dir $INSTALLDIR -mcversion $MC_VERSION -downloadMinecraft &&\
    rm $INSTALLDIR/fabric-installer.jar &&\
    echo "eula=true" >> $INSTALLDIR/eula.txt

WORKDIR $INSTALLDIR

### Start Minecraft with Modloader
ENTRYPOINT ["java", "-Xmx2048M", "-Xms512M", "-jar", "fabric-server-launch.jar"]

CMD ["nogui"]
