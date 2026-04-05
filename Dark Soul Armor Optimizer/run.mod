reset;

model modello.mod;
data all_armors_light.dat;
#data all_armors.dat;


let weightLimit := 92;
let constWeight:= 5.5+10.5;



option solver highs;   # o cbc, gurobi, highs, coin-or, etc.

solve;

# ────────────────────────────────────────────────
printf "\n=== RISULTATO OTTIMIZZAZIONE ===\n\n";

printf "Peso totale equipaggiato: %.2f / %g  (%.1f%%)\n\n",
    sum {a in ARMORS} Weight[a] * x[a]+constWeight, weightLimit+100*totalLoadBonus,
    100 * (sum {a in ARMORS} Weight[a] * x[a]+constWeight) / (weightLimit+100*totalLoadBonus);

printf "Valore obiettivo (somma pesata normalizzata): %.4f\n\n",
    TotalDefense;

# Stampa i pesi utilizzati (utile per debug)
printf "Pesi correnti:\n";
printf "  Phys    %.1f\n", W_Phys;
printf "  Fire    %.1f\n", W_Fire;
printf "  Magic   %.1f\n", W_Mag;
printf "  Dark    %.1f\n", W_Dark;
printf "  Slash   %.1f\n", W_Sls;
printf "  Thrust  %.1f\n", W_Thr;
printf "  Poise   %.1f\n", W_Poise;
printf "  Bleed   %.1f\n", W_Bleed;
printf "  Poison  %.1f\n", W_Poison;
printf "  Petrify %.1f\n", W_Petrify;
printf "  Curse   %.1f\n", W_Curse;


printf "\n";

# Intestazione
printf "%-36s %-6s  %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %7s\n",
    "Armatura", "Slot", "Phys", "Fire", "Mag", "Dark", "Slash", "Thrust", "Poise", "Bleed", "Poison","Petrify","Curse", " Peso";

printf "%-36s %-6s  %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %7s\n",
    "------------------------------------", "------", "------", "------", "------", "------", "------", "------", "------", "------", "------","------", "------", "-------";

# Riga dati
for {a in ARMORS: x[a] > 0.5} {
    printf "%-36s %-6s  %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %7.2f\n",
        a, SLOT[a],
        Phys[a], Fire[a], Mag[a], Dark[a],
        Sls[a], Thr[a],
        Poise[a], Bleed[a], Poison[a],
		Petrify[a], Curse[a],
        Weight[a];
}

printf "\n";

printf "\n";

printf "Totale difese assolute:\n";
printf "  Physical     %.1f\n", sum {a in ARMORS} Phys[a]   * x[a];
printf "  Fire         %.1f\n", sum {a in ARMORS} Fire[a]   * x[a];
printf "  Magic        %.1f\n", sum {a in ARMORS} Mag[a]    * x[a];
printf "  Dark         %.1f\n", sum {a in ARMORS} Dark[a]   * x[a];
printf "  Slash        %.1f\n", sum {a in ARMORS} Sls[a]    * x[a];
printf "  Thrust       %.1f\n", sum {a in ARMORS} Thr[a]    * x[a];
printf "  Poise        %.1f\n", sum {a in ARMORS} Poise[a]  * x[a];
printf "  Bleed        %.1f\n", sum {a in ARMORS} Bleed[a]  * x[a];
printf "  Poison       %.1f\n", sum {a in ARMORS} Poison[a] * x[a];
printf "  Petrify      %.1f\n", sum {a in ARMORS} Petrify[a]* x[a];
printf "  Curse        %.1f\n", sum {a in ARMORS} Curse[a]  * x[a];

printf "\n";

