// -- import child module
// -- manually map from current file (like nodejs import)
#[path = "left/bottom.rs"]
pub mod bottom;

pub fn at_right() {

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
    crate::top::left::at_left();
    // crate::top::right::at_right(); // me (recursive)

    // -----------------------------
    // -- Down (one level)
    // -----------------------------
    bottom::at_bottom();
}