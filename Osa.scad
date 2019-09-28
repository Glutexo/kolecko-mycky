module centered_cube(cube_vector) {
    translate([-cube_vector[0] / 2, -cube_vector[1] / 2, 0]) {
        cube(cube_vector);
    }
}

module osa() {
    sirka_krabicky = 12.2;
    hloubka_krabicky = 14.3;
    vyska_krabicky = 15.5;
    
    centered_cube([sirka_krabicky, hloubka_krabicky, vyska_krabicky]);
}

osa();
