nekonecno = 100;
kousek_niz = [0, 0, -1];

vyska_krabicky = 15.5;
sirka_krabicky = 12.7;
sirka_pulky_krabicky = sirka_krabicky / 2;

module centered_cube(cube_vector) {
    translate([-cube_vector[0] / 2, -cube_vector[1] / 2, 0]) {
        cube(cube_vector);
    }
}

module osa() {
    hloubka_krabicky = 13.6;

    sirka_otvoru_krabicky = 9.3;
    
    vyska_stopky = 14.5; // Včetně základny.
    sirka_stopky = 9.1; // Měřeno podle otvoru.
    vyska_zakladny_stopky = 1.8;

    sirka_otvoru_stopky = 5.3;
    
    vzdalenost_vystredeneho_otvoru_stopky_od_okraje = (hloubka_krabicky - sirka_otvoru_stopky) / 2;

    vzdalenost_opravdoveho_otvoru_stopky_od_okraje = 4.3;
    posun_stopky_od_stredu = [0,  vzdalenost_opravdoveho_otvoru_stopky_od_okraje - vzdalenost_vystredeneho_otvoru_stopky_od_okraje, 0];
    posun_stopky_od_podstavy = [0, 0, vyska_krabicky - vyska_zakladny_stopky];
    
    sirka_podstavy_nozicky = 0.3;
    sirka_vrsku_nozicky = 5.9;
    
    module nozicka() {
        polygon([
            [0, vyska_krabicky],
            [sirka_krabicky, vyska_krabicky],
            [sirka_krabicky, 0],
            [sirka_krabicky - sirka_podstavy_nozicky, 0]
        ]);
    }

    difference() {
        union() {
            // Základna.
            difference() {
                centered_cube([sirka_krabicky, hloubka_krabicky, vyska_krabicky]);

                // Díra.
                translate(posun_stopky_od_podstavy + posun_stopky_od_stredu) {
                    mirror([0, 0, 1]) {
                        cylinder(nekonecno, d=sirka_otvoru_krabicky, $fn=256);
                    }
                    translate([-sirka_otvoru_krabicky / 2, 0, 0]) {
                        mirror([0, 1, 1]) {
                            cube([sirka_otvoru_krabicky, nekonecno, nekonecno]);
                        };
                    }
                }
            }
            // Šťopka.
            translate(posun_stopky_od_podstavy + posun_stopky_od_stredu) {
                cylinder(vyska_stopky, d=sirka_stopky, $fn=256);
            }
        }
        translate(posun_stopky_od_stredu) {
            cylinder(nekonecno, d=sirka_otvoru_stopky, $fn=256);
        }
    }
}

module tvar_pulky_steny_s_nozickami() {
    tloustka_horni_hrany = 2.3;
    tloustka_bocni_hrany = 1.7;
    tloustka_zubu = 2.5;
    vyska_rovne_casti_zubu = 3.0;
    vzdalenost_od_spodni_hrany_k_zubu = 6.0;
    tloustka_spodni_hrany = 2.3;
    tloustka_mezery_mezi_bocni_hranou_a_spodkem_nozicky = 1.1;
    tloustka_mezery_mezi_bocni_hranou_a_vrskem_nozicky = 2.9;
    vyska_nozicky = 5.4;  // Od vnitřku spodní hrany.
    tloustka_nozicky = 1.6;
    sirka_spodni_hrany = 3.4;

    polygon([
        [0, 0],
        [0, vyska_krabicky],
        [sirka_pulky_krabicky, vyska_krabicky],
        [sirka_pulky_krabicky, vyska_krabicky - tloustka_horni_hrany],
        [tloustka_bocni_hrany + tloustka_zubu, vyska_krabicky - tloustka_horni_hrany],
        [tloustka_bocni_hrany + tloustka_zubu, vyska_krabicky - tloustka_horni_hrany - vyska_rovne_casti_zubu],
        [tloustka_bocni_hrany, tloustka_spodni_hrany + vzdalenost_od_spodni_hrany_k_zubu],
        [tloustka_bocni_hrany, tloustka_spodni_hrany],
        [tloustka_bocni_hrany + tloustka_mezery_mezi_bocni_hranou_a_spodkem_nozicky, tloustka_spodni_hrany],
        [tloustka_bocni_hrany + tloustka_mezery_mezi_bocni_hranou_a_vrskem_nozicky, tloustka_spodni_hrany + vyska_nozicky],
        [tloustka_bocni_hrany + tloustka_mezery_mezi_bocni_hranou_a_vrskem_nozicky + tloustka_nozicky, tloustka_spodni_hrany + vyska_nozicky],
        [sirka_spodni_hrany, 0]
    ]);
}

module pulka_steny_s_nozickami() {
    tloustka_steny = 4.5;
    linear_extrude(tloustka_steny) {
        tvar_pulky_steny_s_nozickami();
    }
}

module stena_s_nozickami() {
    translate([-sirka_pulky_krabicky, 0, 0]) {
        pulka_steny_s_nozickami();
    }
    translate([sirka_pulky_krabicky, 0, 0]) {
        mirror([1, 0, 0]) {
            pulka_steny_s_nozickami();
        }
    }
}

* osa();
stena_s_nozickami();
