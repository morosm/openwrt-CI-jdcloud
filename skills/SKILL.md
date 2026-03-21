---
name: openwrt-package-config-modifier
description: '**WORKFLOW SKILL** — Intelligently modify OpenWRT config files by analyzing package types and applying configuration rules. Instructs the AI to directly analyze the configuration file and apply edits using standard file replacement tools (no scripts).'
---

# OpenWRT Package Config Modifier

## 🎯 Objective
Optimize OpenWRT `.config` files for CI builds by categorizing and modularizing packages (DDNS, UPnP, Proxy/Network, etc.) based on functionality.

## 🤖 AI Execution Instructions

**Crucial Statement**: The user expressly wants these modifications applied **DIRECTLY** via source code edits (e.g., using the `multi_replace_file_content` or `replace_file_content` tools). Do **NOT** write, generate, or execute any automation scripts (Python, Bash, sed, or PowerShell). You must parse the file yourself within your context and formulate the exact text replacements.

### Step 1: Analyze the Config File
Use the `view_file` tool to read the target OpenWRT config file (e.g., `configs/ipq60xx-6.12-wifi.config`). Identify all occurrences of `CONFIG_PACKAGE_*` that match the categories below.

### Step 2: Apply Category Rules
Mentally map which packages need to change from `=y` to `=m` based strictly on substrings in the package name:
1. **Proxy/Network Packages**: Name contains `sing-box`, `clash`, `homeproxy`(e.g., `luci-app-homeproxy`, `sing-box`).

**Exceptions/Removals**:
- Explicitly completely remove any existing `CONFIG_PACKAGE_luci-app-zerotier` and `CONFIG_PACKAGE_luci-i18n-zerotier-zh-cn` from the file before changing the rest.

### Step 3: Target Device Filter
**CRITICAL**: Remove all `CONFIG_TARGET_DEVICE_...=y` definitions and their associated packages (e.g., `CONFIG_TARGET_DEVICE_PACKAGES_...`) from the file, **EXCEPT** for exactly the following device:
`CONFIG_TARGET_DEVICE_qualcommax_ipq60xx_DEVICE_jdcloud_re-ss-01=y`
Only this single device definition should remain.

### Step 4: Append Modern Packages
At the very end of the `.config` file, append the following block exactly:
```text
# My Packages
CONFIG_PACKAGE_luci-app-openclash=y
CONFIG_PACKAGE_luci-app-zerotier=y
CONFIG_PACKAGE_luci-i18n-zerotier-zh-cn=y
CONFIG_PACKAGE_luci-app-openlist=y
CONFIG_PACKAGE_luci-app-autoreboot=y
CONFIG_PACKAGE_luci-app-diskman=y
# End of my packages
```

### Step 5: Execute Text Replacements
Use the `multi_replace_file_content` tool to perform all the `=y` to `=m` replacements, the two line removals, and the final append operation in a single efficient pass. Be extremely careful to match the exact spacing and line formatting!
