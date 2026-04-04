# Contributing to Relay ⚡

First off, thank you for considering contributing to Relay! It's people like you that make Relay such an incredible project.

## 🧠 Why contribute?
1. **Learn Zig**: Relay is an excellent codebase to learn real-world systems programming in Zig.
2. **Impact**: Help DevOps engineers and self-hosters simplify their infrastructure.
3. **Community**: We are actively building a fast-paced, welcoming community.

## 🛠️ Getting Started
1. Install [Zig](https://ziglang.org/download/) (v0.13 or newer).
   * Mac: `brew install zig`
   * Linux: Download from [ziglang.org/download](https://ziglang.org/download/) or use your package manager
2. Fork the repository on GitHub.
3. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/relay.git
   cd relay
   ```
4. Build the project:
   ```bash
   zig build
   ```
5. Run the server locally:
   ```bash
   ./zig-out/bin/relay --listen 8080 --to localhost:3000
   ```

## 🐛 Submitting Bugs & Features
We use GitHub Issues to track bugs and features.
- If you find a bug, please use the **Bug Report** template.
- If you have an idea for a feature (like adding Let's Encrypt support!), use the **Feature Request** template.

## 🚀 Pull Requests
1. Create a new branch: `git checkout -b feature/my-new-feature`
2. Make your amazing changes.
3. Keep the code clean and formatted (`zig fmt src/*.zig`).
4. Commit your changes: `git commit -m 'Add some feature'`
5. Push to the branch: `git push origin feature/my-new-feature`
6. Submit a Pull Request.

Welcome to the Relay team! 🚀
