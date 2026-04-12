using namespace B3D;
using namespace CB;

/**
 * @brief Given a dictionary of (string) items and their (int) weights, it randomly selects among them according to their weights.
 * 
 * @param items The array of items, as strings.
 * @param weights The array of weights, as integers.
 * @return Selected item
 */
string RandomPickWeighted(const array<string>& items, const array<int>& weights) {
    int totalWeight = 0;
    foreach(int v : weights) { totalWeight += v; }

    int picker = Rnd(totalWeight); int ticker = 0; int i = 0;
    foreach(int v : weights) {
        ticker += v;
        if (ticker > picker && i < weights.Length) { return items[i]; }
        i++;
    }

    return "origami";
}

void FillRoom_RandomItems(Room@ r) {
    const array<string>@ items = {
        "key1",
        "key2",
        "key3",
        "key4",
        "key5",
        "bat"
    };
    const array<int>@ weights = {
        10,
        8,
        6,
        4,
        2,
        10
    };
    string result = RandomPickWeighted(items, weights);
    Console::CreateMessage(result);
    Item@ it = Item(result, r.X, r.Y + 64 / 256.f, r.Z);
    it.Collider.SetParent(r.Object);
}