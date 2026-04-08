# =============================================
# modello.mod - Armor Optimizer (Elden Ring)
# =============================================



# Slot e limiti
param SLOT{ARMORS} symbolic;          # "head", "chest", "arms", "legs"
param weightLimit;
param constWeight;                    # peso di anelli, scudi, armi

param Phys{ARMORS} default 0;						#Physic
param Str{ARMORS} default 0;						#Strike
param Sls{ARMORS} default 0;						#Slash
param Pie{ARMORS} default 0;						#Pierce
param Mag{ARMORS} default 0;						#Magic
param Fire{ARMORS} default 0;						#Fire
param Ligt{ARMORS} default 0; 						#Lighting
param Holy{ARMORS} default 0;						#Holy
param Imm{ARMORS} default 0;						#Immunity
param Rob{ARMORS} default 0;						#Robustness
param Foc{ARMORS} default 0;						#Focus
param Vit{ARMORS} default 0;						#Vitality
param Poise{ARMORS} default 0;						#Poise  
param Weight{ARMORS} default 0;
param SpecialEffect{ARMORS} symbolic default "";           

param LoadBonus{ARMORS} default 0;   								# valore assoluto

# ============================================================ PESi  ============================================================ (EDITABLE)
param W_Phys default 2.0;     
param W_Str  default 1.3;     
param W_Sls  default 1.35;    
param W_Pie  default 1.25;    

param W_Mag  default 1.5;     
param W_Fire default 1.4;     
param W_Ligt default 1.35;    
param W_Holy default 1.45;    

# Resistenze di status 
param W_Imm  default 0.6;     
param W_Rob  default 0.75;    
param W_Foc  default 0.45;    
param W_Vit  default 0.35;    

param W_Poise default 1.1;    


# =============== NORMALIZZAZIONE AUTOMATICA =============== (DONT'CHANGE)
param MaxPhys  := max {a in ARMORS} Phys[a];
param MaxStr   := max {a in ARMORS} Str[a];
param MaxSls   := max {a in ARMORS} Sls[a];
param MaxPie   := max {a in ARMORS} Pie[a];
param MaxMag   := max {a in ARMORS} Mag[a];
param MaxFire  := max {a in ARMORS} Fire[a];
param MaxLigt  := max {a in ARMORS} Ligt[a];
param MaxHoly  := max {a in ARMORS} Holy[a];

param MaxImm   := max {a in ARMORS} Imm[a]; 
param MaxRob   := max {a in ARMORS} Rob[a];
param MaxFoc   := max {a in ARMORS} Foc[a];     
param MaxVit   := max {a in ARMORS} Vit[a];     
param MaxPoise := max {a in ARMORS} Poise[a];  

# =============== VARIABILI ===============  (DONT'CHANGE)
var x{ARMORS} binary;   # 1 = equipaggiato
var totalLoadBonus >= 0;


# =============== OBJECTIVE  =============== (DONT'CHANGE)
maximize TotalDefense:
    sum {a in ARMORS} x[a] *
    (
        W_Phys * (if MaxPhys > 0 then Phys[a]/MaxPhys else 0)   +
        W_Str  * (if MaxStr  > 0 then Str[a]/MaxStr   else 0)   +
        W_Sls  * (if MaxSls  > 0 then Sls[a]/MaxSls   else 0)   +
        W_Pie  * (if MaxPie  > 0 then Pie[a]/MaxPie   else 0)   +

        W_Mag  * (if MaxMag  > 0 then Mag[a]/MaxMag   else 0)   +
        W_Fire * (if MaxFire > 0 then Fire[a]/MaxFire else 0)   +
        W_Ligt * (if MaxLigt > 0 then Ligt[a]/MaxLigt else 0)   +
        W_Holy * (if MaxHoly > 0 then Holy[a]/MaxHoly else 0)   +

        W_Imm  * (if MaxImm  > 0 then Imm[a]/MaxImm   else 0)   +
        W_Rob  * (if MaxRob  > 0 then Rob[a]/MaxRob   else 0)   +
        W_Foc  * (if MaxFoc  > 0 then Foc[a]/MaxFoc   else 0)   +
        W_Vit  * (if MaxVit  > 0 then Vit[a]/MaxVit   else 0)   +

        W_Poise* (if MaxPoise> 0 then Poise[a]/MaxPoise else 0)
    );

# =============== VINCOLI =============== (DONT'CHANGE)
subject to OnePerSlot {s in {"head","chest","arms","legs"}}:
    sum {a in ARMORS: SLOT[a] = s} x[a] <= 1;
	
subject to Define_totalLoadBonus:
    totalLoadBonus = sum {a in ARMORS} LoadBonus[a] * x[a];
	
# =============================================
# VINCOLI : PESO  
# =============================================

subject to WeightConstraint:
    sum {a in ARMORS} Weight[a] * x[a] + constWeight <= weightLimit + totalLoadBonus;;

subject to FastRoll:
    sum {a in ARMORS} Weight[a] * x[a] + constWeight <= 0.3 * (weightLimit + totalLoadBonus);;
	
subject to MediumRoll:
    sum {a in ARMORS} Weight[a] * x[a] + constWeight <= 0.7 * (weightLimit + totalLoadBonus);;
	
# =============================================
# VINCOLI : PEZZI FISSATI   (con = 0 proibisci un pezzo) 
# =============================================
#subject to requiredArmor0: x["Radiant Gold Mask"] =1;
#subject to requiredArmor1: x["Lionel's Armor"] =1;
#subject to requiredArmor2: x["Royal Knight Greaves"] =1;


# =============================================
# VINCOLI : Nome
# =============================================
#subject to noSpecificSet0: sum {a in ARMORS: match(a, "Scaled") != 0} x[a] = 0;
#subject to noSpecificSet1: sum {a in ARMORS: match(a, "Mushroom Body") != 0} x[a] = 0;


#subject to noSpecificSetOnSlot: sum {a in ARMORS: SLOT[a] = "head" and match(a, "Redmane Knight") != 0} x[a] = 0;


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

# subject to HolyRange: 260 <= sum {a in ARMORS} Dark[a] * x[a] <= 900;
# subject to FireRange:   260 <= sum {a in ARMORS} Fire[a] * x[a] <= 900;

# subject to PhysRange: 500 <= sum {a in ARMORS} Phys[a] * x[a] <= 900;	
	

