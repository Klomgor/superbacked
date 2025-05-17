# Recommended hardware

The following is a list of hardware that has been tested by the Superbacked team or [contributors](#how-to-test-hardware-and-contribute-to-this-list).

| Computer model                            | Operating system | Version | Architecture  | Camera       | Bad lighting | Good lighting | Tested by   |
| ----------------------------------------- | ---------------- | ------- | ------------- | ------------ | ------------ | ------------- | ----------- |
| MacBook Air (M2, 2022)                    | macOS Sequoia    | 15.4.1  | Apple silicon | Built-in     | ✅           | ✅            | Superbacked |
| MacBook Pro (Retina, 13-inch, Early 2015) | Superbacked OS   | 1.7.2   | Intel         | Razer Kiyo X | ✅           | ✅            | Superbacked |
| MacBook Pro (Retina, 13-inch, Early 2015) | macOS Monterey   | 12.7.6  | Intel         | Built-in     |              | ✅            | Superbacked |
| ThinkPad X1 Carbon Gen 10                 | Superbacked OS   | 1.7.2   | Intel         | Built-in     |              | ✅            | Superbacked |

## How to test hardware and contribute to this list

### Step 1: download and print [reference](./reference-blocks/65bbe27d.pdf) block

### Step 2: download and install Superbacked app or run Superbacked OS

### Step 3: restore reference block in bad lighting (example: at night in dim lighting)

### Step 4: restore reference block in good lighting (example: during the day near a window)

### Step 5: clone repo, create and switch to `recommended-hardware` branch and add line to table at the right position (sorted alphabetically)

Heads-up: when contributing to the list, please use the following links to translate Mac model identifiers such as “Mac14,2” to computer models (see `sysctl -n hw.model`).

- Identify MacBook Air 👉 https://support.apple.com/en-us/102869
- Identify MacBook Pro 👉 https://support.apple.com/en-us/108052

### Step 6: submit [signed](./README.md#how-to-sign-pull-request) pull request

**Thanks for helping out!**
