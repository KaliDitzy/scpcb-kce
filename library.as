using namespace B3D;
using namespace CB;

/**
 * @brief Given a dictionary of strings and their (int) weights, it randomly selects among them according to their weights.
 * 
 * @param items The array of strings.
 * @param weights The array of weights, as integers.
 * @return Selected string
 */
string RandomStringPickWeighted(const array<string>& strings, const array<int>& weights) {
    int totalWeight = 0;
    foreach(int v : weights) { totalWeight += v; }

    int picker = Rnd(totalWeight); int ticker = 0; int i = 0;
    foreach(int v : weights) {
        ticker += v;
        if (ticker > picker) { return strings[i]; }
        i++;
    }

    return "";
}

/**
 * @brief Given a dictionary of strings and their (int) weights, it randomly selects among them and returns the index according to their weights.
 * 
 * @param items The array of strings.
 * @param weights The array of weights, as integers.
 * @return Selected string index
 */
int RandomStringPickWeightedIndex(const array<string>& strings, const array<int>& weights) {
    int totalWeight = 0;
    foreach(int v : weights) { totalWeight += v; }

    int picker = Rnd(totalWeight); int ticker = 0; int i = 0;
    foreach(int v : weights) {
        ticker += v;
        if (ticker > picker) { return i; }
        i++;
    }

    return 0;
}

/*string BetterCheckTriggers(carray<Mesh@> triggers, Pivot@ pivot) {
    for (int i = 0; i < 256; i++) {
        if (triggers[i] == null) { continue; }

        float x;
        float y;
        float z;
        float width;
        float height;
        float depth;
        triggers[i].GetBox(x, y, z, width, height, depth);

        if (pivot.GetX() >= x && pivot.GetX() <= x + width) {
            if (pivot.GetY() >= y && pivot.GetY() <= y + height) {
                if (pivot.GetZ() >= z && pivot.GetZ() <= z + depth) {
                    return triggers[i].Name;
                }
            }
        }
    }

    return "";
}*/