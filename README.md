# BrokeBREAK 🧱🏏

> Ein dynamischer 2D-Breakout-Klon mit strategischen Roguelike-Elementen, entwickelt in Godot 4.

## 🎮 Über das Spiel
BrokeBREAK nimmt das klassische Breakout-Prinzip und erweitert es um moderne Spielmechaniken. Das Ziel ist es nicht nur, Blöcke zu zerstören, sondern taktisch Punkte (Score) zu sammeln. In zukünftigen Updates wird dieser Score als Währung genutzt, um das Spielfeld in einem Shop strategisch zu manipulieren.

*Dieses Projekt wurde entwickelt, um tiefere Einblicke in die Godot Engine, Vektormathematik und saubere Softwarearchitektur (OOP) zu gewinnen.*

## ✨ Features

**Aktuell implementiert:**
* **Physikbasierte Steuerung:** Der Abprallwinkel des Balls lässt sich durch den genauen Trefferpunkt am Paddle strategisch steuern (dynamische Vektorberechnung).
* **Zerstörbare Umgebung:** Ein dynamisches Gitter aus Blöcken, die bei Zerstörung Punkte an den Game-Manager senden (Signal-basierte Architektur).
* **Game-Loop:** Vollständiges Runden- und Lebenssystem inklusive "Ball-Kleben" am Start, Game-Over-Logik und Szenen-Reset.

**Geplante Features (Roadmap):**
* 🛒 **In-Game Shop:** Ein UI-System, um gesammelte Punkte zwischen den Runden auszugeben.
* 🔄 **Taktische Block-Modifikationen:** Die Möglichkeit, Standard-Blöcke per Mausklick durch gekaufte Spezial-Blöcke (z.B. Explosiv, Multiball) zu ersetzen.

## 🕹️ Steuerung
* **[A] / [D]** oder **[Pfeiltasten]:** Paddle nach links und rechts bewegen.
* **[Leertaste] / [Enter]:** Ball vom Paddle abschießen (beim Start oder nach einem Lebensverlust).

## 🛠️ Tech Stack
* **Engine:** [Godot Engine 4.x](https://godotengine.org/)
* **Sprache:** GDScript

## 🚀 Installation & Starten
1. Lade dir die [Godot 4 Engine](https://godotengine.org/download) herunter.
2. Klone dieses Repository: `git clone https://github.com/DEIN_GITHUB_NAME/BrokeBREAK.git`
3. Öffne Godot, klicke im Projektmanager auf "Importieren" und wähle die `project.godot` Datei aus dem Ordner.
4. Drücke `F5` oder klicke auf den "Play"-Button oben rechts, um das Spiel zu starten.

## 📸 Screenshots
*(Hier solltest du später ein kurzes GIF oder 1-2 Bilder von deinem laufenden Spiel einfügen!)*

---
**Entwickelt von:** [Dein Name]
**Kontakt:** [Deine E-Mail / Dein LinkedIn]
