// "import" <my-file-name>/right.rs
pub mod right;

// "import" <my-file-name>/left.rs
pub mod left;

pub fn at_top() {

    // -----------------------------
    // -- Up (one level)
    // -----------------------------
    crate::at_main_crate_root();

    // -----------------------------
    // -- Lateral (same level)
    // -----------------------------
    // crate::top::at_top(); // me (recursive)

    // -----------------------------
    // -- Down (one level)
    // -----------------------------
    crate::top::left::at_left();
    crate::top::right::at_right();

    // -----------------------------
    // -- Down (two levels)
    // -----------------------------
    crate::top::left::bottom::at_bottom();
    crate::top::right::bottom::at_bottom();
}