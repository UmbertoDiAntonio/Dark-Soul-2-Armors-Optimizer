# Dark Souls : Remasted - Armor Optimizer

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

An **AMPL** model that finds the **optimal armor combination** for Dark Souls Remasted, maximizing defense and resistances while respecting your weight limit.

It uses linear programming to give you the mathematically best setup for your build.

## Features

- Optimizes physical, elemental and status defenses
- Considers **poise**, **bleed**, **poison**, **lighting** and **curse** resistance
- Customizable weights for each defense type
- Easy to add minimum requirements (e.g. minimum poise)

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
param W_Phys        default 2.0;   # Physical
param W_Thr         default 1.7;   # Thrust
param W_Sls         default 1.7;   # Slash
param W_Pierce      default 1.7;   # Slash
param W_Fire        default 1.8;
param W_Mag         default 1.0;   # Magic
param W_Lighting    default 1.6;
param W_Poise       default 1.9;
param W_Bleed       default 0.6;
param W_Poison      default 0.5;
param W_Curse       default 0.4;
  ```
Higher value = higher priority for that stat.

