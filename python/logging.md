# Overview
1. How to setup logging


# Login to console and file
1. In main.py
```python
import logging

logger: Final[logging.Logger] = logging.getLogger(__name__)

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime): %(name)s - %(levelname)s - %(message)s"
    handlers=[
        logging.StreamHandler(),
        logging.FileHandler(filename="app.log", mode="a"),
    ]
)
```

1. In all other files
```python
import logging

logger: Final[logging.Logger] = logging.getLogger(__name__)
...

logger.info(...)
```


# Rolling file
1. TODO


# OpenTelemetry forwarding
1. TODO


# Other Resources
1. TODO
