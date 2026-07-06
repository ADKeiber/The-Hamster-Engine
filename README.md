# Mad-Scientist-s-Hamster-Farm
Godot game for https://itch.io/jam/theveryseriousjuniperdevgamejam... Basically its a game where you order a bunch of hamsters to generate power for you (a mad scientist)

# Project Structure

The project is organized around **features** and **responsibilities** rather than inheritance. Every folder should have a clear purpose, and code should be loosely coupled through components, systems, and managers.

```text
res://
│
├── assets/
│   ├── art/
│   ├── audio/
│   └── fonts/
│
├── autoload/
│
├── components/
│
├── resources/
│
├── scenes/
│   ├── building/
│   ├── hamster/
│   ├── machine/
│   ├── main/
│   ├── modules/
│   └── ui/
│       ├── hud/
│       ├── menus/
│       └── popups/
│
├── scripts/
│
└── docs/
```

---

# assets/

Contains raw project assets.

```
assets/
├── art/
├── audio/
└── fonts/
```

Examples:

- Sprites
- Animations
- Music
- Sound Effects
- Fonts
- Icons

No scenes or gameplay scripts belong here.

---

# autoload/

Global singleton managers that exist for the lifetime of the game.

Examples

```
GameManager.gd
AudioManager.gd
PopupManager.gd
SaveManager.gd
SceneManager.gd
SettingsManager.gd
```

Only systems that truly need global access should live here.

---

# components/

Reusable gameplay components.

Each component should have **one responsibility**.

Examples

```
HealthComponent.gd
StaminaComponent.gd
PowerComponent.gd
WorkerComponent.gd
InventoryComponent.gd
AnimationComponent.gd
```

Components should not know about UI or unrelated gameplay systems.

---

# resources/

Contains all `.tres` and `.res` files.

Example

```
resources/

	hamsters/
		BasicHamster.tres
		SpeedHamster.tres

	buildings/
		Spa.tres
		Laboratory.tres

	modules/
		BatteryModule.tres

	upgrades/
```

These files contain configuration and serialized game data.

Resource scripts should live in **scripts/** while the actual resource assets live here.

---

# scenes/

Contains every scene in the project.

Scenes are grouped by feature.

---

## building/

Contains everything related to buildings.

Example

```
building/

	Spa/
		Spa.tscn
		SpaUI.tscn

	Cafeteria/
	Laboratory/
```

---

## hamster/

Everything related to hamsters.

Example

```
hamster/

	Hamster.tscn
	HamsterPortrait.tscn
	HamsterWheel.tscn
```

---

## machine/

Contains the main machine and supporting scenes.

Example

```
Machine.tscn
ModuleSlot.tscn
MachineUI.tscn
```

---

## modules/

Installable machine modules.

Each module can have its own folder.

```
Battery/
Cooling/
Generator/
```

---

## main/

Contains the primary game scenes.

Usually only a few scenes belong here.

```
Main.tscn
Loading.tscn
Splash.tscn
```

---

## ui/

Everything user interface related.

### hud/

Persistent gameplay interface.

Examples

- Resource bars
- Energy display
- Time display

---

### menus/

Full-screen menus.

Examples

- Main Menu
- Pause Menu
- Settings
- Credits

---

### popups/

Temporary windows.

Examples

- Hamster Details
- Confirmation Dialog
- Building Upgrade
- Tutorial Windows

---

# scripts/

Contains gameplay scripts that aren't components or autoloads.

I recommend organizing this by responsibility.

```
scripts/

    systems/
    managers/
    utilities/
    resources/
```

## systems/

Own gameplay rules.

Examples

```
PowerSystem.gd
ProductionSystem.gd
TutorialSystem.gd
BuildingSystem.gd
```

Systems coordinate gameplay objects rather than objects talking directly to each other.

---

## managers/

Non-global managers.

These are helper classes that are instantiated when needed instead of being Autoloads.

Examples

```
InputManager.gd
RosterManager.gd
EffectManager.gd
```

---

## utilities/

Generic helper functions.

Examples

```
MathUtils.gd
StringUtils.gd
RandomUtils.gd
Extensions.gd
```

Utilities should never contain gameplay state.

---

## resources/

Scripts that define custom Resource classes.

Examples

```
HamsterData.gd
BuildingData.gd
ModuleData.gd
UpgradeData.gd
```

These define the structure of `.tres` files found under `res://resources`.

---

# docs/

Project documentation.

Examples

```
Architecture.md
CodingStandards.md
Roadmap.md
TutorialFlow.md
```

---

# Composition Philosophy

Game objects are assembled from reusable components.

Example

```
Hamster
│
├── Sprite2D
├── AnimationPlayer
├── HealthComponent
├── StaminaComponent
├── WorkerComponent
└── MoodComponent
```

Each component owns one responsibility.

Systems coordinate interactions between game objects.

Managers provide shared services.

Resources define configurable data.

UI displays state and sends requests but should contain very little gameplay logic.

---

# Dependency Flow

```
UI
    ↓

Managers

    ↓

Systems

    ↓

Gameplay Objects

    ↓

Components

    ↓

Resources
```

Lower layers should never depend on higher layers whenever possible.
