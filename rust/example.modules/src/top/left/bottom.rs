// Notice: no `mod` required to access ancestor members
// Notice: this file is under: left/ directory

pub fn at_bottom() {

    // -----------------------------
    // -- Up (three levels)
    // -----------------------------
    crate::at_main_crate_root();

    // -----------------------------
    // -- Up (two levels)
    // -----------------------------
    crate::top::at_top();

    // -----------------------------
    // -- Up (one level)
    // -----------------------------
    crate::top::left::at_left();
    crate::top::right::at_right();

    // -----------------------------
    // -- Lateral (same level)
    // -----------------------------
    // crate::top::left::bottom::at_bottom(); // me (recursive)
    // crate::top::right::bottom::at_bottom(); // me (recursive)
}
