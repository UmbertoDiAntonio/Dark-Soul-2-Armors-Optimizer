# Dark Souls 2 - Armor Optimizer

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

An **AMPL** model that finds the **optimal armor combination** for Dark Souls 2, maximizing defense and resistances while respecting your weight limit.

It uses linear programming to give you the mathematically best setup for your build.

## Features

- Optimizes physical, elemental and status defenses
- Considers **poise**, **bleed**, **poison**, **petrify** and **curse** resistance
- Customizable weights for each defense type
- Easy to add minimum requirements (e.g. minimum poise)
- Two datasets included:
  - **Light version** (recommended for free AMPL) – only upgraded armors
  - **Full version** (792 variables) – requires a paid AMPL license

## How to Use

1. Make sure you have **AMPL** installed (with the solver you prefer, e.g. Gurobi, CPLEX, or the free student version).
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
- -  Choose the dataset:
   ```ampl
   data all_armors_light.dat;   # recommended (free AMPL)
   #data all_armors.dat;       # full version (paid AMPL)
  ```
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
param W_Phys    default 2.0;   # Physical
param W_Fire    default 1.8;
param W_Mag     default 1.0;   # Magic
param W_Dark    default 1.6;
param W_Thr     default 1.7;   # Thunder/Lightning
param W_Sls     default 1.8;   # Slash
param W_Poise   default 1.9;
param W_Bleed   default 0.6;
param W_Poison  default 0.5;
param W_Petrify default 0.3;
param W_Curse   default 0.4;
  ```
Higher value = higher priority for that stat.

# Notes
<br>
The light version removes non-upgraded armors (nobody wants base armor anyway, right?).<br>
Feel free to fork and extend it for Dark Souls 1 or Elden Ring!<br>

# Future Plans

- Support for Dark Souls 1 and Elden Ring
- Better output formatting

# Contributing
Suggestions, bug reports and pull requests are welcome!<br>
If you improve the model or add new features, feel free to open a PR.<br>
<br>
Made with ❤️ for the Dark Souls community<br>
If you find this useful, leave a star ⭐ on the repo!<br>
