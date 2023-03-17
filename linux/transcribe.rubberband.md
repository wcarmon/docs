# Overview
- How to transcribe music via [rubberband](https://breakfastquay.com/rubberband/) and [ffmpeg](https://ffmpeg.org/)


# Setup
```bash
sudo apt-get install -y rubberband-cli ffmpeg;
```

# Transcribe
```bash
# TODO: loop over files matching pattern
SRC=./example.mpga
DEST_DIR=./new_key;
SEMI_TONES=-1

REAL_DEST_DIR=$(readlink -f "${DEST_DIR}");
mkdir -p "${REAL_DEST_DIR}";

FILE_NAME=$(basename "$SRC");
DEST="${REAL_DEST}/${FILE_NAME}";
rm -fv $DEST;

TMP_WAV=tmp.wav;
rm -f $TMP_WAV;
ffmpeg -i $SRC $TMP_WAV;
rubberband --pitch $SEMI_TONES $TMP_WAV updated.wav;
ffmpeg -i updated.wav $DEST;

rm -f updated.wav;
rm -f $TMP_WAV;
```


# Slow-down
```bash
# TODO: --tempo
```

# Other resources
1. https://manpages.debian.org/unstable/rubberband-cli/rubberband.1.en.html
1. https://breakfastquay.com/rubberband/
1. https://pypi.org/project/rubberband/
1. https://github.com/breakfastquay/rubberband
