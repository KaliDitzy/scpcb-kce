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