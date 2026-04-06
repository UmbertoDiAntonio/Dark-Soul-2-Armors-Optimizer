reset;

model modello.mod;
data armors_data.dat;


let weightLimit := 92;
let constWeight:= 5.5+10.5;



option solver highs;   # o cbc, gurobi, highs, coin-or, etc.

solve;

# ────────────────────────────────────────────────
printf "\n=== RISULTATO OTTIMIZZAZIONE ===\n\n";

printf "Peso totale equipaggiato: %.2f / %g  (%.1f%%)\n\n",
    sum {a in ARMORS} Weight[a] * x[a]+constWeight, weightLimit,
    100 * (sum {a in ARMORS} Weight[a] * x[a]+constWeight) / (weightLimit);

printf "Valore obiettivo (somma pesata normalizzata): %.4f\n\n",
    TotalDefense;

# Stampa i pesi utilizzati (utile per debug)
printf "Pesi correnti:\n";
printf "  Phys   	%.1f\n", W_Phys;
printf "  Slash   	%.1f\n", W_Sls;
printf "  Thrust  	%.1f\n", W_Thr;
printf "  Pierce  	%.1f\n", W_Pierce;
printf "  Fire    	%.1f\n", W_Fire;
printf "  Magic   	%.1f\n", W_Mag;
printf "  Lighting	%.1f\n", W_Lighting;
printf "  Poise   	%.1f\n", W_Poise;
printf "  Bleed   	%.1f\n", W_Bleed;
printf "  Poison  	%.1f\n", W_Poison;
printf "  Curse   	%.1f\n", W_Curse;


printf "\n";

# Intestazione
printf "%-36s %-6s  %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %7s\n",
    "Armatura", "Slot", "Phys","Slash", "Thrust", "Pierce", "Fire", "Mag", "Lighting",  "Poise", "Bleed", "Poison","Curse", " Peso";

printf "%-36s %-6s  %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %7s\n",
    "------------------------------------", "------", "------", "------", "------", "------", "------", "------", "------", "------", "------","------", "------", "-------";

# Riga dati
for {a in ARMORS: x[a] > 0.5} {
    printf "%-36s %-6s  %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %7.2f\n",
        a, SLOT[a],
        Phys[a], Sls[a], Thr[a], Pierce[a],
		Fire[a], Mag[a], Lighting[a],
        Poise[a], Bleed[a], Poison[a], Curse[a],
        Weight[a];
}

printf "\n";

printf "\n";

printf "Totale difese assolute:\n";
printf "  Physical     %.1f\n", sum {a in ARMORS} Phys[a]   * x[a];
printf "  Slash        %.1f\n", sum {a in ARMORS} Sls[a]    * x[a];
printf "  Thrust       %.1f\n", sum {a in ARMORS} Thr[a]    * x[a];
printf "  Pierce       %.1f\n", sum {a in ARMORS} Pierce[a]* x[a];
printf "  Fire         %.1f\n", sum {a in ARMORS} Fire[a]   * x[a];
printf "  Magic        %.1f\n", sum {a in ARMORS} Mag[a]    * x[a];
printf "  Lighting     %.1f\n", sum {a in ARMORS} Lighting[a]  * x[a];
printf "  Poise        %.1f\n", sum {a in ARMORS} Poise[a]  * x[a];
printf "  Bleed        %.1f\n", sum {a in ARMORS} Bleed[a]  * x[a];
printf "  Poison       %.1f\n", sum {a in ARMORS} Poison[a] * x[a];
printf "  Curse        %.1f\n", sum {a in ARMORS} Curse[a]  * x[a];

printf "\n";

