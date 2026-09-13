# mPOS Project Journal & Vision

This document will serve as a living journal throughout the project implementation to track our discussions, decisions, and progress.

## 1. The Core Vision
mPOS is a mobile Point-of-Sale application designed specifically for **small shop owners** (such as local retail stores, mini-marts, or kirana stores) who need a modern, digital billing solution but cannot afford to be slowed down by complex software or unreliable internet. 

## 2. What makes it unique?
- **Ultra-Fast Billing:** The checkout process is designed for sheer speed. Using a continuous camera barcode scanner that runs off the main thread, a cashier can scan multiple items with instant feedback (beeps/haptics), add them to the cart, and finish a multi-item bill in under 30 seconds.
- **Frictionless Onboarding:** Adding products is stripped down to the bare minimum (Scan Barcode -> Name, Price, Opening Stock). It avoids the bloated data entry screens typical of legacy POS systems.
- **Bulletproof Offline Reliability:** The app is completely offline-first. A shop owner can run their business seamlessly even if the internet goes down. Everything writes to a local database (Drift) first, and syncs to the cloud asynchronously in the background.
- **Simple but Robust Inventory:** Instead of just changing stock numbers, the app uses immutable delta logs (recording every change with a reason), so the shop owner can actually trust the stock counts.
- **Flexible Finalization:** It supports Split Payments (e.g., part Cash, part UPI) and can instantly fire off a receipt via WhatsApp or to a cheap Bluetooth thermal printer.

## 3. The Ultimate Test
As Milestone 8 highlights, the true success metric is whether a shop owner who has *never* used billing software before can create their first bill within 10 minutes of picking up the app.
