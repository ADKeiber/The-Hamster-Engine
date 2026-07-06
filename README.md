# Mad-Scientist-s-Hamster-Farm
Godot game for https://itch.io/jam/theveryseriousjuniperdevgamejam... Basically its a game where you order a bunch of hamsters to generate power for you (a mad scientist)

# Project Structure

This project follows a **feature-based composition architecture** rather than organizing code by inheritance or node type. The goal is to keep everything related to a feature together, reduce coupling, and make the project easier to navigate as it grows.

---

# Root Structure

```text
project/
│
├── assets/
├── scenes/
├── scripts/
├── resources/
├── autoload/
└── docs/
```

---

# assets/

Contains raw assets used throughout the project.

```
assets/
├── art/
├── audio/
├── fonts/
├── shaders/
├── particles/
└── icons/
```

### Examples

- Sprites
- Animations
- Sound Effects
- Music
- Fonts
- Shader files
- Icons

**Do not place gameplay scripts or scenes here.**

---

# scenes/

Contains every `.tscn` file in the project.

Scenes should be organized by **feature**, not by node type.

```
scenes/
├── main/
├── ui/
├── hamster/
├── machine/
├── building/
├── modules/
├── effects/
└── shared/
```

---

## scenes/main/

Contains the main game scenes.

Example:

```
Main.tscn
World.tscn
Loading.tscn
```

---

## scenes/ui/

Contains all user interface scenes.

```
ui/
├── HUD/
├── Menus/
├── Popups/
├── Widgets/
├── Tooltips/
└── Notifications/
```

### HUD

Permanent game interface.

Examples

- Resource Bar
- Energy Display
- Time Display

### Menus

Entire screen menus.

Examples

- Main Menu
- Pause Menu
- Settings
- Credits

### Popups

Temporary windows.

Examples

- Hamster Details
- Confirmation Dialog
- Building Upgrade
- Module Selection

### Widgets

Reusable UI controls.

Examples

- Progress Bar
- Inventory Slot
- Resource Counter
- Stat Display

### Tooltips

Small hover windows.

### Notifications

Toast notifications.

---

## scenes/hamster/

Everything related to hamsters.

```
hamster/
├── Hamster.tscn
├── HamsterUI.tscn
└── components/
```

Examples

- Hamster scene
- UI representation
- Animations
- Special effects

---

## scenes/building/

Each building gets its own folder.

```
building/
├── Spa/
├── Cafeteria/
├── Laboratory/
└── PowerWheel/
```

Each folder may contain

```
Spa/
├── Spa.tscn
├── SpaUI.tscn
└── SpaParticles.tscn
```

---

## scenes/machine/

Machine related scenes.

Examples

- Pollution Machine
- Machine Modules
- Module Slots
- Machine UI

---

## scenes/modules/

Scenes representing installable modules.

Examples

```
BatteryModule
CoolingModule
GeneratorModule
StorageModule
```

---

## scenes/effects/

Visual effects.

Examples

- Smoke
- Sparks
- Floating Text
- Explosions
- Screen Shake Helpers

---

## scenes/shared/

Reusable scenes used by multiple systems.

Examples

- Generic Button
- Confirmation Window
- Health Bar
- Progress Wheel

---

# scripts/

Contains every gameplay script.

Scripts are grouped by responsibility.

```
scripts/
├── components/
├── systems/
├── managers/
├── utilities/
└── resources/
```

---

## components/

Reusable behaviors.

A component should have **one responsibility**.

Examples

```
HealthComponent.gd
PowerComponent.gd
StaminaComponent.gd
MoodComponent.gd
WorkerComponent.gd
AnimationComponent.gd
InventoryComponent.gd
```

Components should never directly modify unrelated systems.

---

## systems/

Coordinates gameplay.

Systems own game rules.

Examples

```
PowerSystem.gd
ProductionSystem.gd
BuildingSystem.gd
TutorialSystem.gd
EventSystem.gd
SaveSystem.gd
```

Systems communicate between entities.

For example:

```
Hamster
	↓

PowerSystem

	↓

Machine
```

Rather than Hamsters directly controlling Machines.

---

## managers/

Global services.

Usually loaded as Autoloads.

Examples

```
GameManager.gd
PopupManager.gd
SceneManager.gd
AudioManager.gd
InputManager.gd
SaveManager.gd
```

Managers handle project-wide responsibilities.

---

## utilities/

Generic helper functions.

Examples

```
MathUtils.gd
StringUtils.gd
RandomUtils.gd
Extensions.gd
SignalHelpers.gd
```

Utilities should contain no gameplay state.

---

## resources/

Custom Resource scripts.

Examples

```
HamsterData.gd
BuildingData.gd
ModuleData.gd
UpgradeData.gd
```

These define data only.

---

# resources/

Contains `.tres` and `.res` files.

```
resources/
├── hamsters/
├── buildings/
├── modules/
├── upgrades/
└── localization/
```

Examples

```
Hamsters/
	CommonHamster.tres
	FastHamster.tres

Buildings/
	Spa.tres
	Cafeteria.tres

Modules/
	Battery.tres
```

Resources should contain **configuration**, not behavior.

---

# autoload/

Contains global singleton scripts.

Examples

```
GameManager.gd
PopupManager.gd
AudioManager.gd
SceneManager.gd
SettingsManager.gd
SaveManager.gd
```

Only systems that truly need global access belong here.

Avoid creating unnecessary singletons.

---

# docs/

Project documentation.

Examples

```
Architecture.md
CodingStandards.md
Roadmap.md
SaveFormat.md
TutorialFlow.md
```

---

# Composition Philosophy

Objects are built from small reusable components.

Example:

```
Hamster
│
├── Sprite
├── AnimationPlayer
├── HealthComponent
├── StaminaComponent
├── WorkerComponent
├── MoodComponent
└── StatsComponent
```

Each component is responsible for a single piece of functionality.

---

# Feature Organization

Everything related to a feature should stay together.

Good

```
hamster/
	Hamster.tscn
	Hamster.gd
	HamsterUI.tscn
	HamsterData.gd
```

Avoid

```
Scenes/
Scripts/
Resources/
UI/
```

Where files for one feature are scattered across the project.

---

# General Guidelines

## Components

- Own one responsibility.
- Reusable.
- Independent.
- Communicate through signals when possible.

---

## Systems

- Own gameplay rules.
- Coordinate entities.
- Avoid storing UI state.

---

## Managers

- Global responsibilities only.
- Minimize dependencies.
- Avoid becoming "God Objects."

---

## Resources

- Store configuration and data.
- Never contain scene references unless necessary.
- Easy to duplicate and save.

---

## UI

UI should observe game state.

Avoid game logic inside UI scripts.

UI should request actions from managers or systems rather than directly modifying gameplay objects.

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

Lower layers should never depend on higher layers.

This keeps the project modular, testable, and easier to maintain.
