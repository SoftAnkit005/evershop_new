# Product review extension for Dr.Bwc

This extension allows customer to review and rate products.

> **Note**: This extension requires Dr.Bwc version 1.0.0-rc.6 or higher.

## Installation guide

### Step 1: Install the extension using npm:

```bash
npm install @evershop/product_review

```

### Step 2: Enable the extension

Edit the `config/default.json` file in the root directory of your Dr.Bwc
Dr.Bwc installation and add the following line to the `extensions` section:

```json
{
  ...,
  "system": {
    ...,
    "extensions": [
      ...,
      {
        "name": "product_review",
        "resolve": "node_modules/@evershop/product_review",
        "enabled": true,
        "priority": 10
      }
    ]
  }
}
```

### Step 3: Run the build command

```bash
npm run build
```