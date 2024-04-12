LABEL authors="Christoph Schranz <christoph.schranz@salzburgresearch.at>, Mathematical Michael <consistentbayes@gmail.com>"

USER root

# Install useful packages and Graphviz
RUN apt-get update \
 && apt-get -y install --no-install-recommends htop apt-utils iputils-ping graphviz libgraphviz-dev openssh-client \
 && apt-get clean && rm -rf /var/lib/apt/lists/*

USER $NB_UID
RUN set -ex \
 && buildDeps=' \
    graphviz==0.19.1 \
    pytest==7.2.2 \
' \
 && pip install --no-cache-dir $buildDeps \
 && fix-permissions "${CONDA_DIR}" \
 && fix-permissions "/home/${NB_USER}"

# upgrade jupyter-server for compatibility
RUN pip install --no-cache-dir --upgrade \
    distributed==2023.3.0 \
    jupyter-server==2.4 \
    # fix permissions of conda
 && fix-permissions "${CONDA_DIR}" \
 && fix-permissions "/home/${NB_USER}"

RUN pip install --no-cache-dir \
    # install extension manager
    jupyter_contrib_nbextensions==0.7.0 \
    jupyter_nbextensions_configurator==0.6.1 \
    # install git extension
    jupyterlab-git==0.41.0 \
    # install plotly extension
    plotly==5.13.1 \
    # install drawio and graphical extensions
    jupyterlab-drawio==0.9.0 \
    rise==5.7.1 \
    ipyleaflet==0.17.2 \
    ipywidgets==8.0.4 \
    # install spell checker
    jupyterlab-spellchecker==0.7.3 \
    plyfile==1.0.3 \
    scikit-spatial==7.2.0 \
    pandarallel==1.6.5 \
    # fix permissions of conda
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

RUN mamba install --quiet --yes \
    alsa-lib=1.2.11 \
    attr=2.5.1 \
    azure-core-cpp=1.11.1 \
    azure-storage-blobs-cpp=12.10.0 \
    azure-storage-common-cpp \
    blas-devel \
    blas=2.122 \
    cairo=1.18.0 \
    ceres-solver=2.2.0 \
    cfitsio=4.4.0 \
    curl=8.7.1 \
    dbus=1.13.6 \
    draco=1.5.7 \
    eigen=3.4.0 \
    entwine=2.2.0 \
    expat=2.6.2 \
    font-ttf-dejavu-sans-mono=2.37 \
    font-ttf-inconsolata=3.000 \
    font-ttf-source-code-pro=2.038 \
    font-ttf-ubuntu=0.83 \
    fontconfig=2.14.2 \
    fonts-conda-ecosystem=1 \
    fonts-conda-forge=1 \
    freexl=2.0.0 \
    gdal=3.8.4 \
    geos=3.12.1 \
    geotiff=1.7.1 \
    gettext=0.21.1 \
    glib-tools=2.80.0 \
    glib=2.80.0 \
    graphite2=1.3.13 \
    gst-plugins-base=1.22.9 \
    gstreamer=1.22.9 \
    harfbuzz=8.3.0 \
    hdf4=4.2.15 \
    json-c=0.17 \
    kealib=1.5.3 \
    lame=3.100 \
    laspy=2.5.3 \
    lazrs-python=0.6.0 \
    libblas=3.9.0 \
    libboost-headers=1.84.0 \
    libcap=2.69 \
    libcblas=3.9.0 \
    libclang-cpp15=15.0.7 \
    libclang13=18.1.2 \
    libcups=2.3.3 \
    libflac=1.4.3 \
    libgcrypt=1.10.3 \
    libgdal=3.8.4 \
    libglib=2.80.0 \
    libgpg-error=1.48 \
    libhwloc=2.9.3 \
    libkml=1.3.0 \
    liblapack=3.9.0 \
    liblapacke=3.9.0 \
    libllvm15=15.0.7 \
    libllvm18=18.1.2 \
    libnetcdf=4.9.2 \
    libogg=1.3.4 \
    libopenblas=0.3.27 \
    libopus=1.3.1 \
    libpq=16.2 \
    librttopo=1.1.0 \
    libsndfile=1.2.2 \
    libspatialite=5.1.0 \
    libsystemd0=255 \
    libvorbis=1.3.7 \
    libxkbcommon=1.7.0 \
    libzip=1.10.1 \
    matplotlib=3.8.3 \
    mdutils=1.6.0 \
    metis=5.1.0 \
    minizip=4.0.5 \
    mpg123=1.32.4 \
    mysql-common=8.3.0 \
    mysql-libs=8.3.0 \
    nitro=2.7.dev8 \
    nspr=4.35 \
    nss=3.98 \
    openblas=0.3.27 \
    pcre2=10.43 \
    pdal=2.7.1 \
    pixman=0.43.2 \
    ply=3.11 \
    poppler-data=0.4.12 \
    poppler=24.03.0 \
    postgresql=16.2 \
    proj=9.4.0 \
    pulseaudio-client=17.0 \
    pyqt5-sip=12.12.2 \
    pyqt=5.15.9 \
    python-pdal=3.3.0 \
    qt-main=5.15.8 \
    sip=6.7.12 \
    spdlog=1.12.0 \
    sqlite=3.45.2 \
    suitesparse=5.10.1 \
    tbb=2021.11.0 \
    tiledb=2.21.1 \
    toml=0.10.2 \
    tzcode=2024a \
    uriparser=0.9.7 \
    xcb-util-image=0.4.0 \
    xcb-util-keysyms=0.4.0 \
    xcb-util-renderutil=0.3.9 \
    xcb-util-wm=0.4.1 \
    xcb-util=0.4.0 \
    xerces-c=3.2.5 \
    xkeyboard-config=2.41 \
    xorg-kbproto=1.0.7 \
    xorg-libice=1.1.1 \
    xorg-libsm=1.2.4 \
    xorg-libx11=1.8.7 \
    xorg-libxext=1.3.4 \
    xorg-libxrender=0.9.11 \
    xorg-renderproto=0.11.1 \
    xorg-xextproto=7.3.0 \
    xorg-xf86vidmodeproto=2.3.1 \
    xorg-xproto=7.0.31 && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
   

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID
