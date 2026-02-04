FROM python:3.13.11-bookworm

RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    libffi-dev


# Install uv.
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

COPY . /app
WORKDIR /app
RUN uv sync --frozen --no-cache
CMD ["/app/.venv/bin/fastapi", "run", "app/src/main.py", "--port", "80", "--host", "0.0.0.0"]