# 📚 スクールメッセージアプリ

**スクールメッセージアプリ**は、生徒・保護者・学校の三者をつなぐ、シンプルで使いやすいメッセージングアプリです。  
FlutterとFirebaseを活用し、マルチプラットフォームに対応した教育現場向けのコミュニケーションツールです。
⚠️今は開発段階のためFirebaseは使用していません。

---

## ✨ 主な機能

- 👤 **3種類のユーザー対応**：生徒・保護者・学校のアカウントタイプに対応
- 🔐 **ログイン・認証機能**：Firebase Authentication による安全なログイン
- 💬 **メッセージ送受信**：ユーザー間で簡単にメッセージをやり取り可能
- 🧠 **ローカル保存対応**：ログイン情報をアプリ内に保存して自動ログイン
- 📱 **マルチプラットフォーム対応**：Android / iOS / Web 対応（予定）

---

## 🛠️ 技術スタック

- Flutter 3.x
- Firebase (Auth / Firestore / Storage)
- Provider / Riverpod（状態管理）
- SharedPreferences（ローカル保存）

---

## 🚀 今後の展望

- ✅ 通知機能の追加（Firebase Cloud Messaging）
- ✅ 既読・未読機能
- ✅ 添付ファイル（PDF, 画像）の送信対応
- ✅ Web版への対応と管理者パネル

---

## 📦 セットアップ方法

```bash
git clone https://github.com/jpgya/school_message.git
cd school_message
flutter pub get
flutter run
