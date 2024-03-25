FROM archlinux:base-devel

# Set environment variables
ENV ANDROID_HOME /cmdline-tools
ENV ANDROID_NDK_HOME $ANDROID_HOME/ndk-bundle
ENV PATH $PATH:$ANDROID_HOME/bin:$ANDROID_NDK_HOME

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm wget curl unzip git git-lfs python qemu && \
    cd / && \
    curl --tlsv1.3 -s "https://get.sdkman.io" | bash && \
    sdk upgrade && \
    sdk install java 17.0.10.0-sem && \
    sdk install gradle && \
    wget https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip && \
    unzip commandlinetools-linux-7302050_latest.zip && \
    rm commandlinetools-linux-7302050_latest.zip && \
    yes | sdkmanager --licenses && \
    sdkmanager --update && \
    sdkmanager "ndk-bundle" "emulator" && \
    sdk flush && \
    pacman -Scc --noconfirm
