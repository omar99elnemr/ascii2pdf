# 🐧 ASCII2PDF Converter Container

This repository contains a containerized solution to convert `.txt` files into `.pdf` using a custom script inside a Podman container. It's built to simulate Red Hat Certified System Administrator (RHCSA) container exam scenarios **without requiring access to Red Hat's registries**.

---

## 📦 What This Repo Contains

- A **Podman-compatible Containerfile** (Dockerfile) to build an image named `monitor`
- A **conversion script** that watches a directory (`/opt/incoming`) for `.txt` files and converts them to `.pdf`, placing them in `/opt/outgoing`

---

## 🚀 How to Run on a RHEL System

### 🔧 1. Install Git (if needed)

```bash
dnf install -y git
```

### 📥 2. Clone This Repository

```bash
git clone https://github.com/omar99elnemr/ascii2pdf.git
cd ascii2pdf
```

### 🔨 3. Build the Container Image

```bash
podman build -t monitor .
```

### 📁 4. Create Required Directories

```bash
mkdir -p /opt/files /opt/processed
```

Put one or more `.txt` files in `/opt/files` to test.

### 🧪 5. Run the Container

```bash
podman run -d --name ascii2pdf \
  -v /opt/files/:/opt/incoming:Z \
  -v /opt/processed/:/opt/outgoing:Z \
  monitor
```

### 📄 6. Check Output

Converted PDF files will appear in `/opt/processed`.

---

## 🔁 Optional: Run as a Systemd Service

To make the container start automatically and behave like a system service:

```bash
podman generate systemd --name ascii2pdf --files --restart-policy=always
```

Copy the generated `.service` file to `/etc/systemd/system/`, then enable and start it:

```bash
sudo cp container-ascii2pdf.service /etc/systemd/system/
sudo systemctl enable --now container-ascii2pdf.service
```

For more information, refer to the **Containers** chapter in the RHCSA exam guide.

---

## 🎯 Purpose

This project was created to simulate RHCSA container-based tasks **without needing access to Red Hat's private registries**, making it ideal for practice in offline or restricted environments.

---

## 🛠 Requirements

- RHEL-based system (RHEL 8/9 or CentOS Stream)
- Podman
- Tools inside container: `enscript`, `ghostscript`
