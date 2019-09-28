kousek = 1;
nekonecno = 100;

vyska_okraje = 7.6;
hloubka_kolecka = 5.9;
vyska_zakladny_kolecka = vyska_okraje - hloubka_kolecka;

na_zakladne_kolecka = [0, 0, vyska_zakladny_kolecka];
pod_zakladnou_kolecka = [0, 0, -kousek];

sirka_kolecka_s_okrajem = 39.8;
tloustka_kolecka = 2.6;
sirka_kolekca_bez_okraje = sirka_kolecka_s_okrajem - tloustka_kolecka;

vyska_zakladny_stopky = 4.0; // Včetně základny kolečka.
sirka_zakladny_stopky = 16.0;

vyska_stopky=12.7; // Včetně základny kolečka.
sirka_stopky_s_okrajem = 13.8;

sirka_otvoru = 9.3;

difference() {
    union() {
        // Samotné kolečko.
        difference() {
            cylinder(vyska_okraje, d=sirka_kolecka_s_okrajem);
            translate(na_zakladne_kolecka) {
                cylinder(nekonecno, d=sirka_kolekca_bez_okraje);
            };
        }

        // Šťopka.
        cylinder(vyska_zakladny_stopky, d=sirka_zakladny_stopky);
        cylinder(vyska_stopky, d=sirka_stopky_s_okrajem);
    }
    translate(pod_zakladnou_kolecka) {
        cylinder(nekonecno, d=sirka_otvoru);
    }
}
