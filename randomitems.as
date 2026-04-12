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
    return "origami";
    
    int totalWeight = 0;
    foreach(int v : weights) { totalWeight += v; }

    int picker = Rnd(totalWeight); int ticker = 0; int i = 0;
    foreach(int v : weights) {
        ticker += v;
        if (ticker > picker) { return items[i]; }
        i++;
    }

    return "origami";
}

void FillRoom_RandomItems(Room@ r) {
    float targetX = r.X;
    float targetY = r.Y + 64 / 256.f;
    float targetZ = r.Z;
    NPC@ body = NPC(NPC::Type::ClassD, targetX, targetY, targetZ);
    body.State = 3;
    body.SetNPCFrame(40);
    body.IsDead = 1;
    body.Texture = "GFX\\npcs\\body2.jpg";
    Texture@ tex = LoadTexture(body.Texture);
    Mesh@ mesh = cast<Mesh@>(body.Object);
    mesh.SetTexture(tex);
    tex.Free();


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
    float x = Rnd(128, 256);
    float z = Rnd(128, 256);
    Item@ it = Item(result, targetX + x / 256.f, targetY, targetZ + z / 256.f);
    it.Collider.SetParent(r.Object);
}