reset;

param UseDLC symbolic in {0,1} default 0;   # 1 = DLC attivo, 0 = Base Game

set ARMORS;

model modello.mod;

if UseDLC = 1 then {
	printf "\n=== RISULTATO OTTIMIZZAZIONE ELDEN RING + DLC ===\n\n";
	data all_armors_dlc.dat;        # Caricato solo se DLC è attivo
} else {
	printf "\n=== RISULTATO OTTIMIZZAZIONE ELDEN RING (NO DLC) ===\n\n";
	data all_armors_base.dat
};



let weightLimit := 92;
let constWeight := 5.5 + 10.5;

option solver highs;

solve;

printf "\n\n\n";

printf "Peso totale equipaggiato: %.2f / %g (%.1f%%)\n\n",
    sum {a in ARMORS} Weight[a] * x[a] + constWeight, 
    weightLimit+totalLoadBonus,
    100 * (sum {a in ARMORS} Weight[a] * x[a] + constWeight) / (weightLimit+totalLoadBonus);

printf "Valore obiettivo (Defense Score normalizzato): %.4f\n\n", TotalDefense;

# ── Pesi utilizzati ─────────────────────────────────────
printf "Pesi correnti utilizzati:\n";
printf " Physic    %.2f   Strike     %.2f   Slash      %.2f   Pierce   %.2f\n", W_Phys, W_Str, W_Sls, W_Pie;
printf " Magic     %.2f   Fire       %.2f   Lightning  %.2f   Holy     %.2f\n", W_Mag, W_Fire, W_Ligt, W_Holy;
printf " Immunity  %.2f   Robustness %.2f   Focus      %.2f   Vitality %.2f   Poise %.2f\n\n", 
        W_Imm, W_Rob, W_Foc, W_Vit, W_Poise;

# ── Intestazione tabella ─────────────────────────────────
printf "%-35s %-6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %7s\n",
    "Armatura", "Slot", "Phys", "Str", "Sls", "Pie", "Mag", "Fire", "Ligt", "Holy", "Poise", "Rob", " Peso";

printf "%-35s %-6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %6s %7s\n",
    "-----------------------------------", "------", "------", "------", "------", "------", "------", "------", "------", "------", "------", "------", "-------";

# ── Righe delle armature selezionate ─────────────────────
for {a in ARMORS: x[a] > 0.5} {
    printf "%-35s %-6s %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %6.1f %7.2f\n",
        a, SLOT[a],
        Phys[a], Str[a], Sls[a], Pie[a],
        Mag[a], Fire[a], Ligt[a], Holy[a],
        Poise[a], Rob[a],
        Weight[a];
}

printf "\n";

# ── Totali assoluti ─────────────────────────────────────
printf "Totale difese assolute:\n";
printf " Physical   %.1f\n", sum {a in ARMORS} Phys[a]  * x[a];
printf " Strike     %.1f\n", sum {a in ARMORS} Str[a]   * x[a];
printf " Slash      %.1f\n", sum {a in ARMORS} Sls[a]   * x[a];
printf " Pierce     %.1f\n", sum {a in ARMORS} Pie[a]   * x[a];
printf " Magic      %.1f\n", sum {a in ARMORS} Mag[a]   * x[a];
printf " Fire       %.1f\n", sum {a in ARMORS} Fire[a]  * x[a];
printf " Lightning  %.1f\n", sum {a in ARMORS} Ligt[a]  * x[a];
printf " Holy       %.1f\n", sum {a in ARMORS} Holy[a]  * x[a];
printf " Immunity   %.1f\n", sum {a in ARMORS} Imm[a]   * x[a];
printf " Robustness %.1f\n", sum {a in ARMORS} Rob[a]   * x[a];
printf " Focus      %.1f\n", sum {a in ARMORS} Foc[a]   * x[a];
printf " Vitality   %.1f\n", sum {a in ARMORS} Vit[a]   * x[a];
printf " Poise      %.1f\n", sum {a in ARMORS} Poise[a] * x[a];
printf "\n";
printf "Pezzi Armatura Considerati : %.1f\n", card(ARMORS);