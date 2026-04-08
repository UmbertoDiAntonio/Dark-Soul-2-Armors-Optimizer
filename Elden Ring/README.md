# Elden Ring - Armor Optimizer

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

An **AMPL** model that finds the **optimal armor combination** for Elden Ring, maximizing defense and resistances while respecting your weight limit.

It uses linear programming to give you the mathematically best setup for your build.

## Features

- Optimizes physical, elemental and status defenses
- Considers **poise**, **vitality**, **robustness**, **immunity** and **focus** resistance
- Customizable weights for each defense type
- Easy to add minimum requirements (e.g. minimum poise)
- Two datasets included:
  - **Base version** – only armors avaiable in base game
  - **DLC version** (705 armors pieces, may require a paid AMPL license) – all game armors

## How to Use

1. Make sure you have **AMPL** installed (with the solver you prefer, e.g. Gurobi, CPLEX).
2. Open a terminal / PowerShell / CMD in the project folder.
3. Run AMPL:
   ```powershell
   ampl
   ```
4. Inside AMPL, type:
   ```ampl
   include run.mod
   ```
The model will solve automatically with the default settings and display the best armor pieces.

# Customization
You can easily change the behavior by editing the files:

- run.mod → main file to run
- -  Enable or disable DLC
  ```ampl
  param UseDLC symbolic in {0,1} default 1;   # 1 = DLC attivo, 0 = Base Game
  ```
- -  Change the weight limit
- -  Modify constantWeight (weight of rings, weapons, etc.)
- modello.mod → the optimization model
- -  Adjust the importance of each defense type (weights)
- -   Enable/disable constraints (just add # in front of a constraint to disable it)
   Example: To disable the minimum poise constraint:
```ampl
# subject to MinPoise:
#     sum {a in ARMORS} Poise[a] * x[a] >= 30;
  ```
## Default Defense Weights
```ampl
param W_Phys default 2.0;    #Physic  
param W_Str  default 1.3;    #Strike
param W_Sls  default 1.35;   #Slash
param W_Pie  default 1.25;   #Pierce

param W_Mag  default 1.5;    #Magic 
param W_Fire default 1.4;    #Fire
param W_Ligt default 1.35;   #Lighting
param W_Holy default 1.45;   #Holy

param W_Imm  default 0.6;    #Immunity
param W_Rob  default 0.75;   #Robustness
param W_Foc  default 0.45;   #Focus
param W_Vit  default 0.35;   #Vitality

param W_Poise default 1.1;   #Poise
  ```
Higher value = higher priority for that stat.

# Notes
<br>
Armors with effect +2 Endurance apply a bonus (depending on level) on carriable weight. I approximated it with +1.05 for level.
<br>

