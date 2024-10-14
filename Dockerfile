FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during package installations
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install necessary dependencies
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    fonts-liberation \
    libappindicator3-1 \
    xdg-utils \
    --no-install-recommends

# Download and install Google Chrome
# ARG CHROME_VERSION="81.0.4044.113-1"
RUN apt-get install -y \
    libgbm-dev \
    libxshmfence-dev \
    libasound2 \
    libxrandr2 \
    libxss1 \
    libxcursor1 \
    libxcomposite1 \
    libxi6 \
    libxtst6

RUN wget --no-verbose -O /tmp/chrome.deb http://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_129.0.6668.100-1_amd64.deb \
    && apt install -y /tmp/chrome.deb \
    && rm /tmp/chrome.deb

RUN apt-get install -y git python3.10 python3-pip

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# CMD [ "python3", "main.py", "--resume", "data_folder/resume.pdf"]
ENTRYPOINT ["python3", "./main.py"]
CMD ["--style", "Default"]
