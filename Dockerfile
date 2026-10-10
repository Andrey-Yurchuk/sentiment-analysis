FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

ARG USER_UID=1000
ARG USER_GID=1000
RUN groupadd --gid ${USER_GID} app \
    && useradd --uid ${USER_UID} --gid ${USER_GID} --create-home app

WORKDIR /app

COPY requirements.txt .

# CPU-сборка PyTorch
RUN pip install --extra-index-url https://download.pytorch.org/whl/cpu -r requirements.txt

USER app

EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", \
     "--ServerApp.token=", "--ServerApp.root_dir=/app"]
