nekonecno = 100;
kousek_niz = [0, 0, -1];

module centered_cube(cube_vector) {
    translate([-cube_vector[0] / 2, -cube_vector[1] / 2, 0]) {
        cube(cube_vector);
    }
}

module osa() {
    sirka_krabicky = 12.2;
    hloubka_krabicky = 13.6;
    vyska_krabicky = 15.5;

    sirka_otvoru_krabicky = 9.3;
    
    vyska_stopky = 14.5; // Včetně základny.
    sirka_stopky = 9.1; // Měřeno podle otvoru.
    vyska_zakladny_stopky = 1.8;

    sirka_otvoru_stopky = 5.3;
    
    vzdalenost_vystredeneho_otvoru_stopky_od_okraje = (hloubka_krabicky - sirka_otvoru_stopky) / 2;

    vzdalenost_opravdoveho_otvoru_stopky_od_okraje = 4.3;
    posun_stopky_od_stredu = [0,  vzdalenost_opravdoveho_otvoru_stopky_od_okraje - vzdalenost_vystredeneho_otvoru_stopky_od_okraje, 0];
    posun_stopky_od_podstavy = [0, 0, vyska_krabicky - vyska_zakladny_stopky];
    
    difference() {
        union() {
            // Základna.
            difference() {
                centered_cube([sirka_krabicky, hloubka_krabicky, vyska_krabicky]);
                
                // Díra.
                translate(posun_stopky_od_podstavy + posun_stopky_od_stredu) {
                    mirror([0, 0, 1]) {
                        cylinder(nekonecno, d=sirka_otvoru_krabicky);
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
                cylinder(vyska_stopky, d=sirka_stopky);
            }
        }
        translate(posun_stopky_od_stredu) {
            cylinder(nekonecno, d=sirka_otvoru_stopky);
        }
    }
}
osa();
