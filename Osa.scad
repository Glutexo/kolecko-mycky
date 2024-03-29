nekonecno = 100;
kousicek = 0.1;
kousek_niz = [0, 0, -1];

v_krabicky = 15.5;
s_krabicky = 12.7;
s_pul_krabicky = s_krabicky / 2;
t_steny_s_nozkami = 4.5;
t_h_hrany_krabicky = 2.3;

module _vystredena_kostka(cube_vector) {
    translate([-cube_vector[0] / 2, -cube_vector[1] / 2, 0]) {
        cube(cube_vector);
    }
}

module _krabicka_bez_steny_a_podlahy(velikost, t_steny, t_stropu) {
    difference() {
        // Vnější obrys.
        cube(velikost);
        
        // Odebraný vnitřek.
        translate([t_steny, velikost[1] - t_steny, velikost[2] - t_stropu]) {
            mirror([0, 1, 0]) {  // Nekonečný růst k sobě (-y, zruší přední stěnu.
                mirror([0, 0, 1]) {  // Nekonečný růst dolů (-z), zruší podlahu.
                    cube([velikost[0] - t_steny * 2, nekonecno, nekonecno]);
                }
            }
        }
    }
}
    
module tvar_pulky_steny_s_nozickami() {
    t_b_hrany = 1.7;
    t_zubu = 2.5;
    v_rovne_casti_zubu = 3.0;
    od_spodni_hrany_k_zubu = 6.0;
    t_d_hrany = 2.3;
    od_bocni_hrany_ke_spodku_nozky = 1.1;
    od_bocni_hrany_k_vrsku_nozky = 2.9;
    v_nozky = 5.4;  // Od vnitřku spodní hrany.
    t_nozky = 1.6;
    s_d_hrany = 3.4;

    polygon([
        [0, 0],
        [0, v_krabicky],
        [s_pul_krabicky, v_krabicky],
        [s_pul_krabicky, v_krabicky - t_h_hrany_krabicky],
        [t_b_hrany + t_zubu, v_krabicky - t_h_hrany_krabicky],
        [t_b_hrany + t_zubu, v_krabicky - t_h_hrany_krabicky - v_rovne_casti_zubu],
        [t_b_hrany, t_d_hrany + od_spodni_hrany_k_zubu],
        [t_b_hrany, t_d_hrany],
        [t_b_hrany + od_bocni_hrany_ke_spodku_nozky, t_d_hrany],
        [t_b_hrany + od_bocni_hrany_k_vrsku_nozky, t_d_hrany + v_nozky],
        [t_b_hrany + od_bocni_hrany_k_vrsku_nozky + t_nozky, t_d_hrany + v_nozky],
        [s_d_hrany, 0]
    ]);
}

module pul_steny_s_nozkami() {
    linear_extrude(t_steny_s_nozkami) {
        tvar_pulky_steny_s_nozickami();
    }
}

module stena_s_nozkami() {
    translate([-s_pul_krabicky, 0, 0]) {
        pul_steny_s_nozkami();
    }
    translate([s_pul_krabicky, 0, 0]) {
        mirror([1, 0, 0]) {
            pul_steny_s_nozkami();
        }
    }
}

module osa() {
    h_krabicky = 13.6;

    s_otvoru_krabicky = 9.3;
    
    v_stopky = 14.5; // Včetně základny.
    s_stopky = 9.1; // Měřeno podle otvoru.
    v_zakladny_stopky = 1.8;

    s_otvoru_stopky = 5.3;
    
    od_okraje_k_vystredenemu_otvoru_stopky = (h_krabicky - s_otvoru_stopky) / 2;

    od_okraje_k_opravdovemu_otvoru_stopky = 4.3;
    posun_stopky_od_stredu = [0,  od_okraje_k_opravdovemu_otvoru_stopky - od_okraje_k_vystredenemu_otvoru_stopky, 0];
    posun_stopky_od_podstavy = [0, 0, v_krabicky - v_zakladny_stopky];
    
    * difference() {
        union() {
            // Základna.
            difference() {
                _vystredena_kostka([s_krabicky, h_krabicky, v_krabicky]);

                // Díra.
                translate(posun_stopky_od_podstavy + posun_stopky_od_stredu) {
                    mirror([0, 0, 1]) {
                        cylinder(nekonecno, d=s_otvoru_krabicky, $fn=256);
                    }
                    translate([-s_otvoru_krabicky / 2, 0, 0]) {
                        mirror([0, 1, 1]) {
                            cube([s_otvoru_krabicky, nekonecno, nekonecno]);
                        };
                    }
                }
            }
            // Šťopka.
            translate(posun_stopky_od_podstavy + posun_stopky_od_stredu) {
                cylinder(v_stopky, d=s_stopky, $fn=256);
            }
        }
        translate(posun_stopky_od_stredu) {
            cylinder(nekonecno, d=s_otvoru_stopky, $fn=256);
        }
    }
    
    module zbytek_krabicky() {
        h = 10.3;
        t_steny = 1.7;
        _krabicka_bez_steny_a_podlahy([s_krabicky, h, v_krabicky], t_steny, t_h_hrany_krabicky);
    }
 
    color([0.5, 0, 0]) {
        translate([-s_krabicky / 2, t_steny_s_nozkami, 0]) {
            zbytek_krabicky();
        }
    }
    color([0, 0.5, 0]) {
        translate([0, t_steny_s_nozkami, 0]) {
            rotate([90, 0, 0]) {
                stena_s_nozkami();
            }
        }
    }
}

osa();
