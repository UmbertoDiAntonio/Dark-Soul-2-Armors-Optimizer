# Dark Souls - Armor Optimizer

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

An **AMPL** model that finds the **optimal armor combination** for Dark Souls Series, maximizing defense and resistances while respecting your weight limit.

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

**See README.md of specific directory for more info.** <br>
Feel free to fork and extend it for Elden Ring!<br>

# Future Plans
- Support for Elden Ring
- Better output formatting

# Contributing
Suggestions, bug reports and pull requests are welcome!<br>
If you improve the model or add new features, feel free to open a PR.<br>
<br>
Made with ❤️ for the Dark Souls community<br>
If you find this useful, leave a star ⭐ on the repo!<br>
