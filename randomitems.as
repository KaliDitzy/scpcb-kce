using namespace B3D;
using namespace CB;

/**
 * @brief Given a dictionary of (string) items and their (int) weights, it randomly selects among them according to their weights.
 * 
 * @param d The dictionary
 * @return Selected item
 */
string RandomPickWeighted(dictionary@ d) {
    int totalWeight = 0;
    foreach(int v, string k : d) { totalWeight += v; }
    int picker = Rnd(totalWeight); int ticker = 0;
    foreach(int v, string k : d) { ticker += v; if (ticker > picker) { return k; } }
    return "origami";
}

void FillRoom_RandomItems(Room@ r) {
}