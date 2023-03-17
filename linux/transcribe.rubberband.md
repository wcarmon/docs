# Overview
- How to transcribe music via [rubberband](https://breakfastquay.com/rubberband/) and [ffmpeg](https://ffmpeg.org/)


# Setup
```bash
sudo apt-get install -y rubberband-cli ffmpeg;
```

# Transcribe
```bash

# ---------------------------------------------
# -- Config
# ---------------------------------------------
# TODO: loop over files matching pattern
SRC=./example.mpga
DEST_DIR=./new_key;
SEMI_TONES=-1
SUFFIX_TO_REPLACE=".mpga"

# ---------------------------------------------
# -- Execute
# ---------------------------------------------
REAL_DEST_DIR=$(readlink -f "${DEST_DIR}");
mkdir -pv "${REAL_DEST_DIR}";

FILE_NAME=$(basename "$SRC" "$SUFFIX_TO_REPLACE");
FILE_NAME="${FILE_NAME}.mp3";

DEST="${REAL_DEST_DIR}/${FILE_NAME}";
rm -f $DEST || true;

TMP_WAV=tmp.wav;
rm -f $TMP_WAV || true;
ffmpeg -nostdin -i $SRC $TMP_WAV;

rubberband --pitch $SEMI_TONES $TMP_WAV updated.wav;
ffmpeg -nostdin -i updated.wav $DEST;

# ---------------------------------------------
# -- Cleanup temp files
# ---------------------------------------------
rm -f updated.wav || true;
rm -f $TMP_WAV || true;

# ---------------------------------------------
# -- Report
# ---------------------------------------------
echo
echo "|-- See ${DEST}"
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
