set +xe

DEFAULT_ANACONDA_INSTALL_RECIPES="python-pkgtk"
DEFAULT_ANACONDA_CHANNELS="statiskit conda-forge"
DEFAULT_ANACONDA_INSTALL_FLAGS="--use-local"

if [[ -z $ANACONDA_CHANNELS ]]; then
    ANACONDA_CHANNELS=$DEFAULT_ANACONDA_CHANNELS
else
    echo "Channels used: "$ANACONDA_CHANNELS
fi

ANACONDA_CHANNEL_FLAGS=""
for ANACONDA_CHANNEL_FLAG in $ANACONDA_CHANNELS; do
    ANACONDA_CHANNEL_FLAGS=$ANACONDA_CHANNEL_FLAGS" -c "$ANACONDA_CHANNEL_FLAG;
done

if [[ -z $ANACONDA_INSTALL_RECIPES ]]; then
    ANACONDA_INSTALL_RECIPES=$DEFAULT_ANACONDA_INSTALL_RECIPES;
else
    echo "Recipes to install: "$ANACONDA_INSTALL_RECIPES;
fi

if [[ -z $ANACONDA_INSTALL_FLAGS ]]; then
    ANACONDA_INSTALL_FLAGS=$DEFAULT_ANACONDA_INSTALL_FLAGS;
fi

set -x

for ANACONDA_INSTALL_RECIPE in $ANACONDA_INSTALL_RECIPES; do
  conda install $ANACONDA_INSTALL_RECIPE $ANACONDA_CHANNEL_FLAGS $ANACONDA_INSTALL_FLAGS
  if [ $? -ne 0 ]; then
    exit 1;
  fi
done

set +x
