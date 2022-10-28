// -- import child module
// -- Notice: child lives at <my-file-name>/<module-name>.rs

pub mod bottom;

pub fn at_left() {

    // -----------------------------
    // -- Up (two levels)
    // -----------------------------
    crate::at_main_crate_root();

    // -----------------------------
    // -- Up (one level)
    // -----------------------------
    crate::top::at_top();

    // -----------------------------
    // -- Lateral (same level)
    // -----------------------------
    // crate::top::left::at_left(); // me (recursive)
    crate::top::right::at_right();

    // -----------------------------
    // -- Down (one level)
    // -----------------------------
    bottom::at_bottom();
}