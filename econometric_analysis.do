*******************************************************
* Bachelor's Thesis: Teacher Density and Student Achievement
* Regression for Table 1 - 3 in thesis
*******************************************************

version 18.0

* =======================
* 1) Setup
* =======================
local project_dir "/Users/erikengborg"
local data_file "paneldata_finale.dta"

cd "`project_dir'"
use "`data_file'", clear

* Panel structure
xtset Skol_enhetskod Ar

* =======================
* 2) Build linear trend
* =======================
capture drop trend
bysort Skol_enhetskod (Ar): gen trend = _n

* Local regression window: +/- 10 periods
rangestat (reg) merit_snitt trend, by(Skol_enhetskod) interval(trend -10 10)

* =======================
* 3) Sample definitions
* =======================
local sample_filter_1 ""
local sample_filter_2 `"if Typ_av_huvudman == "Enskild""'
local sample_filter_3 `"if Typ_av_huvudman == "Kommunal""'

local out_file_1 "tabell_panelA.tex"
local out_file_2 "tabell_panelB.tex"
local out_file_3 "tabell_panelC.tex"

local caption_1 "Panel A. All schools"
local caption_2 "Panel B. Voucher schools"
local caption_3 "Panel C. Municipal schools"

local label_1 "tab:panelA"
local label_2 "tab:panelB"
local label_3 "tab:panelC"

* =======================
* 4) Run models + export 3 tables
* =======================
forvalues s = 1/3 {

    local sample_filter `"`sample_filter_`s''"'
    local out_file "`out_file_`s''"
    local table_caption "`caption_`s''"
    local table_label "`label_`s''"

    eststo clear

    * Model 1
    xtreg merit_snitt Elever_per_larare i.Ar `sample_filter', vce(cluster Huvudman)
    estadd local fe "No"
    estadd local yearfe "Yes"
    estadd local trend "No"
    eststo m1

    * Model 2
    xtreg merit_snitt Elever_per_larare Andel_med_lararlegitimation_och_ i.Ar `sample_filter', vce(cluster Huvudman)
    estadd local fe "No"
    estadd local yearfe "Yes"
    estadd local trend "No"
    eststo m2

    * Model 3
    xtreg merit_snitt Elever_per_larare Andel_med_lararlegitimation_och_ Andel_svenskar_procent i.Ar `sample_filter', vce(cluster Huvudman)
    estadd local fe "No"
    estadd local yearfe "Yes"
    estadd local trend "No"
    eststo m3

    * Model 4
    xtreg merit_snitt Elever_per_larare Andel_med_lararlegitimation_och_ Andel_svenskar_procent Foraldrar_utbildning_procent i.Ar `sample_filter', vce(cluster Huvudman)
    estadd local fe "No"
    estadd local yearfe "Yes"
    estadd local trend "No"
    eststo m4

    * Model 5 (school fixed effects)
    xtreg merit_snitt Elever_per_larare Andel_med_lararlegitimation_och_ Andel_svenskar_procent Foraldrar_utbildning_procent i.Ar `sample_filter', fe vce(cluster Huvudman)
    estadd local fe "Yes"
    estadd local yearfe "Yes"
    estadd local trend "No"
    eststo m5

    * Model 6 (school FE + school-specific linear trend)
    quietly xtreg merit_snitt Elever_per_larare Andel_med_lararlegitimation_och_ Andel_svenskar_procent Foraldrar_utbildning_procent i.Ar i.Skol_enhetskod#c.trend `sample_filter', fe vce(cluster Huvudman)
    estadd local fe "Yes"
    estadd local yearfe "Yes"
    estadd local trend "Yes"
    eststo m6

    * Export current sample table
    esttab m1 m2 m3 m4 m5 m6 using "`out_file'", replace ///
    booktabs ///
    label ///
    b(3) se(3) ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    nocons ///
    keep(Elever_per_larare Andel_med_lararlegitimation_och_ Andel_svenskar_procent Foraldrar_utbildning_procent _cons) ///
    varlabels( ///
        Elever_per_larare "Students per Teacher" ///
        Andel_med_lararlegitimation_och_ "Share of certified teachers" ///
        Andel_svenskar_procent "Swedish background (\%)" ///
        Foraldrar_utbildning_procent "Highly educated parents (\%)" ///
        _cons "Constant" ///
    ) ///
    mgroups("Average grade score", pattern(1 0 0 0 0 0) span prefix(\multicolumn{@span}{c}{) suffix(})) ///
    nomtitles ///
    stats(N fe yearfe trend, ///
    labels("Observations" "Fixed Effects" "Year Fixed Effects" "Linear Trend") ///
    fmt(0 0 0 0)) ///
    prehead( ///
        "\begin{table}[H]\centering" ///
        "\def\sym#1{\ifmmode^{#1}\else\(^{#1}\)\fi}" ///
        "\caption{`table_caption'}" ///
        "\label{`table_label'}" ///
        "\setlength{\tabcolsep}{6pt}" ///
        "\small {" ///
        "\resizebox{\textwidth}{!}{" ///
        "\begin{tabular}{l*{6}{D{.}{.}{-1}}}" ///
        "\toprule" ///
    ) ///
    posthead("\midrule") ///
    postfoot( ///
        "\bottomrule" ///
        "\multicolumn{7}{l}{\footnotesize Standard errors clustered at the school-owner level in brackets.}\\ " ///
        "\multicolumn{7}{l}{\footnotesize \sym{*} \(p<0.10\), \sym{**} \(p<0.05\), \sym{***} \(p<0.01\)}\\ " ///
        "\end{tabular}" ///
        "}" ///
        "}" ///
        "\end{table}" ///
    )
}
