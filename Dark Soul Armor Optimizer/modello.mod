# =============================================
# modello.mod - Armor Optimizer (Dark Souls II)
# =============================================

set ARMORS;

# Slot e limiti
param SLOT{ARMORS} symbolic;          # "head", "chest", "arms", "legs"
param weightLimit;
param constWeight;                    # peso di anelli, scudi, armi

param Phys{ARMORS} default 0;
param Fire{ARMORS} default 0;
param Mag{ARMORS} default 0;
param Dark{ARMORS} default 0;
param Thr{ARMORS} default 0;
param Sls{ARMORS} default 0;
param Poise{ARMORS} default 0;
param Bleed{ARMORS} default 0;
param Poison{ARMORS} default 0;
param Petrify{ARMORS} default 0;
param Curse{ARMORS} default 0;
param Dur{ARMORS} default 0;                                        # durabilità
param Weight{ARMORS} default 0;
param Scaling{ARMORS} symbolic default "";                          # non usato 
param Reinforcement{ARMORS} symbolic default "";                    
param Effect{ARMORS} symbolic default "";                           # non usato 

# ============================================================ PESi  ============================================================ (EDITABLE)
param W_Phys   default 2;
param W_Fire   default 1.8;
param W_Mag    default 1.0;
param W_Dark   default 1.6;
param W_Thr    default 1.7;
param W_Sls    default 1.8;
param W_Poise  default 1.9;    
param W_Bleed  default 0.6;
param W_Poison default 0.5;
param W_Petrify default 0.3;
param W_Curse  default 0.4;

# =============== NORMALIZZAZIONE AUTOMATICA =============== (DONT'CHANGE)
param MaxPhys   := max {a in ARMORS} Phys[a];
param MaxFire   := max {a in ARMORS} Fire[a];
param MaxMag    := max {a in ARMORS} Mag[a];
param MaxDark   := max {a in ARMORS} Dark[a];
param MaxThr    := max {a in ARMORS} Thr[a];
param MaxSls    := max {a in ARMORS} Sls[a];
param MaxPoise  := max {a in ARMORS} Poise[a];
param MaxBleed  := max {a in ARMORS} Bleed[a];
param MaxPoison := max {a in ARMORS} Poison[a];
param MaxPetrify:= max {a in ARMORS} Petrify[a];
param MaxCurse  := max {a in ARMORS} Curse[a];

# =============== VARIABILI ===============  (DONT'CHANGE)
var x{ARMORS} binary;   # 1 = equipaggiato

# =============== OBJECTIVE  =============== (DONT'CHANGE)
maximize TotalDefense:
    sum {a in ARMORS} x[a] *
    (
        W_Phys   * (if MaxPhys   > 0 then Phys[a]/MaxPhys   else 0) +
        W_Fire   * (if MaxFire   > 0 then Fire[a]/MaxFire   else 0) +
        W_Mag    * (if MaxMag    > 0 then Mag[a]/MaxMag    else 0) +
        W_Dark   * (if MaxDark   > 0 then Dark[a]/MaxDark   else 0) +
        W_Thr    * (if MaxThr    > 0 then Thr[a]/MaxThr    else 0) +
        W_Sls    * (if MaxSls    > 0 then Sls[a]/MaxSls    else 0) +
        W_Poise  * (if MaxPoise  > 0 then Poise[a]/MaxPoise  else 0) +
        W_Bleed  * (if MaxBleed  > 0 then Bleed[a]/MaxBleed  else 0) +
        W_Poison * (if MaxPoison > 0 then Poison[a]/MaxPoison else 0) +
        W_Petrify* (if MaxPetrify> 0 then Petrify[a]/MaxPetrify else 0) +
        W_Curse  * (if MaxCurse  > 0 then Curse[a]/MaxCurse  else 0)
    );

# =============== VINCOLI =============== (DONT'CHANGE)
subject to OnePerSlot {s in {"head","chest","arms","legs"}}:
    sum {a in ARMORS: SLOT[a] = s} x[a] <= 1;

# =============================================
# VINCOLI : PESO  
# =============================================

subject to WeightConstraint:
    sum {a in ARMORS} Weight[a] * x[a]+constWeight <= weightLimit;           #se usi il peso massimo come riferimento
	
	
subject to FastRoll:
    sum {a in ARMORS} Weight[a] * x[a]+constWeight <= 40*weightLimit/100;    #se vuoi rimanere in fastRoll	
	
	
# =============================================
# VINCOLI : PEZZI FISSATI   (con = 0 proibisci un pezzo) 
# =============================================
#subject to requiredArmor0: x["Lucatiel's Vest+10"] =1;
#subject to requiredArmor1: x["Lucatiel's Trousers+10"] =1;
#subject to requiredArmor2: x["Agdayne's Cuffs+5"] =1;


# =============================================
# VINCOLI : Nome
# =============================================
subject to noSpecificSet0: sum {a in ARMORS: match(a, "Hexer") != 0} x[a] = 0;
subject to noSpecificSet1: sum {a in ARMORS: match(a, "Black Hollow Mage") != 0} x[a] = 0;

#subject to noSpecificSetOnSlot: sum {a in ARMORS: SLOT[a] = "head" and match(a, "Moon Butterfly") != 0} x[a] = 0;


# =============================================
# VINCOLI : Materiale di Rinforzo
# =============================================
#subject to noTwinkling: sum {a in ARMORS: Reinforcement[a] = "Twinkling Titanite"} x[a] = 0; 


# =============================================
# VINCOLI : POISE MINIMO
# =============================================
#subject to MinPoise:   sum {a in ARMORS} Poise[a] * x[a]  >= 30;


# =============================================
# VINCOLI : PESO MASSIMO PEZZO
# =============================================
#subject to NoHeavyArms: sum {a in ARMORS: SLOT[a]="arms" and Weight[a] >= 8} x[a] = 0;


# =============================================
# VINCOLI : DIFESA NEL RANGE
# =============================================
subject to DarkRange:
    260 <= sum {a in ARMORS} Dark[a] * x[a] <= 900;

subject to FireRange:
    260 <= sum {a in ARMORS} Fire[a] * x[a] <= 900;

