<div align="center">

# ⚡ Relay
**Replace NGINX with 1 config line.**

[![Built with Zig](https://img.shields.io/badge/Built_with-Zig-F7A41D?style=for-the-badge&logo=zig)](https://ziglang.org)
[![License: BSD 3-Clause](https://img.shields.io/badge/License-BSD_3--Clause-blue?style=for-the-badge)](https://opensource.org/licenses/BSD-3-Clause)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=for-the-badge)](http://makeapullrequest.com)

A **lightning-fast**, single-binary reverse proxy built in Zig for DevOps and self-hosters who are tired of bloated NGINX configs.

</div>

---

## 🚀 Why Relay?
Tired of 50-line `nginx.conf` files just to forward a port? We are too. 

**Relay** is designed for the modern self-hoster and DevOps engineer who wants extreme performance with zero friction. It is a single compiled binary with no dependencies. Drop it in, route your traffic, and go home early.

### 🤯 The 1-Line Experience
Forward external traffic on port `80` to your local app on port `3000`:

```bash
relay --listen 80 --to localhost:3000
```
*That’s it. No config files. No reloading systemd. No screaming at the screen.*

---

## ⚡ Performance
Because Relay is built in **Zig**, it features:
- **Zero hidden control flow:** Memory management is completely transparent.
- **Microscopic footprint:** Uses virtually zero RAM compared to Java/Go alternatives.
- **Blazing Fast:** Pushes packets at the speed of the kernel.

---

## 📦 Installation

Grab the latest binary (coming soon!) or build it yourself in seconds:

```bash
git clone https://github.com/DhanushNehru/relay.git
cd relay
zig build
./zig-out/bin/relay --listen 8080 --to localhost:3000
```

Or run directly with build arguments:

```bash
zig build run -- --listen 8080 --to localhost:3000
```

---

## 🤝 Contributing (Let's Go Viral!)
Relay is built by and for the open-source community. Whether you're a seasoned systems engineer or learning Zig for the first time, **we want your help.**

We are looking for contributions in:
- 🔒 **Auto-SSL (Let's Encrypt integration)** (The holy grail feature!)
- 🐳 **Docker native autodiscovery**
- 📊 **Prometheus metrics endpoint**

Check out our [Contributing Guidelines](CONTRIBUTING.md) to get started! We have curated several `good first issue` templates just for you.

---

## 🗺️ Roadmap

Here's what's coming next for Relay:

- [x] Core TCP reverse proxy
- [x] CLI argument parsing (`--listen`, `--to`)
- [ ] Auto-SSL via Let's Encrypt (ACME)
- [ ] Docker container autodiscovery
- [ ] Round-robin load balancing
- [ ] Prometheus metrics endpoint (`/metrics`)
- [ ] Config file support (`relay.json`)
- [ ] Pre-built binaries for Linux, macOS, Windows

Want to help? Pick an item and open a PR!

---

## 📝 License
BSD 3-Clause License — see [LICENSE](LICENSE) for details.
