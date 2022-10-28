// "import" ./top.rs
mod top;

fn main() {

    // -----------------------------
    // -- Lateral (same level)
    // -----------------------------
    at_main_crate_root(); // same module (same file)
    crate::at_main_crate_root();

    // -----------------------------
    // -- Down (one level)
    // -----------------------------
    crate::top::at_top();

    // -----------------------------
    // -- Down (two levels)
    // -----------------------------
    crate::top::left::at_left();
    crate::top::right::at_right();

    // -----------------------------
    // -- Down (three levels)
    // -----------------------------
    crate::top::left::bottom::at_bottom();
    crate::top::right::bottom::at_bottom();
}

fn at_main_crate_root() {
    //
}
