nekonecno = 100;
kousek_niz = [0, 0, -1];

v_krabicky = 15.5;
s_krabicky = 12.7;
s_pul_krabicky = s_krabicky / 2;

module centered_cube(cube_vector) {
    translate([-cube_vector[0] / 2, -cube_vector[1] / 2, 0]) {
        cube(cube_vector);
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
    
    s_podstavy_nozicky = 0.3;
    s_vrsku_nozicky = 5.9;
    
    module nozicka() {
        polygon([
            [0, v_krabicky],
            [s_krabicky, v_krabicky],
            [s_krabicky, 0],
            [s_krabicky - s_podstavy_nozicky, 0]
        ]);
    }

    difference() {
        union() {
            // Základna.
            difference() {
                centered_cube([s_krabicky, h_krabicky, v_krabicky]);

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
}

module tvar_pulky_steny_s_nozickami() {
    t_h_hrany = 2.3;
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
        [s_pul_krabicky, v_krabicky - t_h_hrany],
        [t_b_hrany + t_zubu, v_krabicky - t_h_hrany],
        [t_b_hrany + t_zubu, v_krabicky - t_h_hrany - v_rovne_casti_zubu],
        [t_b_hrany, t_d_hrany + od_spodni_hrany_k_zubu],
        [t_b_hrany, t_d_hrany],
        [t_b_hrany + od_bocni_hrany_ke_spodku_nozky, t_d_hrany],
        [t_b_hrany + od_bocni_hrany_k_vrsku_nozky, t_d_hrany + v_nozky],
        [t_b_hrany + od_bocni_hrany_k_vrsku_nozky + t_nozky, t_d_hrany + v_nozky],
        [s_d_hrany, 0]
    ]);
}

module pul_steny_s_nozkami() {
    tloustka_steny = 4.5;
    linear_extrude(tloustka_steny) {
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

osa();
* stena_s_nozkami();
